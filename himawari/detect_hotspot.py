import bz2
import struct
import json
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

import numpy as np


# =========================================================
# BACA POLYGON BOUNDARY BANGKA BELITUNG
# =========================================================

# Path GeoJSON boundary (digunakan juga oleh Laravel)
_GEOJSON_PATH = (
    Path(__file__).resolve().parent.parent
    / "storage/app/private/geo/bangka-belitung.geojson"
)


def load_boundary_polygons():
    """
    Membaca GeoJSON Bangka Belitung dan mengembalikan
    daftar polygon (list of list of (lon, lat) tuples).

    Mendukung tipe geometry Polygon dan MultiPolygon.
    """

    if not _GEOJSON_PATH.exists():
        raise FileNotFoundError(
            f"File GeoJSON boundary tidak ditemukan:\n"
            f"{_GEOJSON_PATH}"
        )

    with open(_GEOJSON_PATH, encoding="utf-8") as f:
        geojson = json.load(f)

    polygons = []

    for feature in geojson.get("features", []):
        geom = feature.get("geometry", {})
        gtype = geom.get("type", "")
        coords = geom.get("coordinates", [])

        if gtype == "Polygon":
            # coords = [ exterior_ring, *inner_rings ]
            # Kita hanya butuh exterior ring.
            polygons.append(coords[0])

        elif gtype == "MultiPolygon":
            # coords = [ polygon1, polygon2, ... ]
            # polygon = [ exterior_ring, *inner_rings ]
            for poly in coords:
                polygons.append(poly[0])

    return polygons


def point_in_polygon(lon, lat, polygon):
    """
    Algoritma ray casting untuk mengecek apakah
    titik (lon, lat) berada di dalam polygon.

    polygon: list of [lon, lat] pasangan koordinat.
    """

    inside = False
    n = len(polygon)
    j = n - 1

    for i in range(n):
        xi, yi = polygon[i][0], polygon[i][1]
        xj, yj = polygon[j][0], polygon[j][1]

        if (
            (yi > lat) != (yj > lat)
        ) and (
            lon < (
                (xj - xi) * (lat - yi)
                / (yj - yi)
                + xi
            )
        ):
            inside = not inside

        j = i

    return inside


# =========================================================
# INISIALISASI POLYGON SAAT MODUL DIMUAT
# =========================================================

# Boundary WAJIB ada. Jika hilang, filter bounding box saja akan
# ikut memasukkan daratan Sumatra Selatan sebagai "Bangka Belitung",
# jadi lebih aman berhenti dengan error yang jelas.
_BOUNDARY_POLYGONS = load_boundary_polygons()

if not _BOUNDARY_POLYGONS:
    raise ValueError(
        "GeoJSON boundary terbaca tetapi tidak berisi "
        "Polygon/MultiPolygon."
    )

print(
    f"Boundary Bangka Belitung dimuat: "
    f"{len(_BOUNDARY_POLYGONS)} polygon"
)


def point_in_bangka_belitung(lat, lon):
    """
    Mengembalikan True jika koordinat (lat, lon)
    berada di dalam salah satu polygon Bangka Belitung.

    Bounding box kasar digunakan sebagai pre-filter
    sebelum ray casting yang lebih mahal.
    """

    # Pre-filter bounding box (lebih cepat)
    if not (
        -3.8 <= lat <= -0.8
        and 104.8 <= lon <= 108.5
    ):
        return False

    # Ray casting terhadap semua polygon
    for polygon in _BOUNDARY_POLYGONS:
        if point_in_polygon(lon, lat, polygon):
            return True

    return False


# =========================================================
# KONFIGURASI
# =========================================================

BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "data"
OUTPUT_FILE = BASE_DIR / "output" / "himawari_hotspots.json"

# Segmen yang mencakup Bangka Belitung (lat -0.8 s/d -3.8).
# HARUS sama dengan REQUIRED_SEGMENT di fetch_himawari.py.
SEGMENT = "S0610"

LINES_PER_SEGMENT = 550


def segment_first_line(segment):
    """
    Nomor baris global pertama sebuah segmen.
    S0610 -> segmen 06 -> (6 - 1) * 550 + 1 = 2751
    """
    match = re.fullmatch(r"S(\d{2})(\d{2})", segment)

    if not match:
        raise ValueError(f"Format segmen tidak valid: {segment}")

    number = int(match.group(1))

    return (number - 1) * LINES_PER_SEGMENT + 1


FIRST_LINE = segment_first_line(SEGMENT)

# Batas usia observasi. Lebih tua dari ini dianggap basi,
# kecuali script dijalankan dengan --allow-stale.
MAX_OBSERVATION_AGE_MINUTES = 120

MANIFEST_FILE = DATA_DIR / "latest.json"

# ---------------------------------------------------------
# THRESHOLD DETEKSI
# ---------------------------------------------------------

# Threshold absolut B07
MIN_BT07 = 325.0

# Selisih minimum B07 - B14
MIN_BT_DIFFERENCE = 20.0

# Batas maksimum B14
MAX_BT14 = 300.0

# ---------------------------------------------------------
# CONTEXTUAL DETECTION
# ---------------------------------------------------------

# Ukuran lingkungan pixel yang digunakan untuk
# menghitung kondisi background.
#
# 5 = area 5x5 pixel di sekitar kandidat.
#
# Pixel tengah tidak dihitung sebagai background.
CONTEXT_SIZE = 5

# Minimum selisih BT07 kandidat terhadap rata-rata
# lingkungan sekitar.
MIN_LOCAL_ANOMALY = 6.0

# Kandidat juga harus lebih panas dari background
# berdasarkan standar deviasi lokal.
LOCAL_STD_MULTIPLIER = 1.5

# Minimum jumlah pixel valid dalam lingkungan
# agar contextual detection dianggap valid.
MIN_VALID_CONTEXT_PIXELS = 8

# Radius clustering
CLUSTER_DISTANCE_KM = 5.0


# =========================================================
# CARI FILE HIMAWARI TERBARU
# =========================================================

_FILENAME_RE = re.compile(
    r"HS_H\d{2}_(\d{8})_(\d{4})_(B\d{2})_FLDK_R20_(S\d{4})\.DAT\.bz2"
)


def _parse_name(path):
    match = _FILENAME_RE.fullmatch(Path(path).name)

    if not match:
        return None

    return {
        "date": match.group(1),
        "time": match.group(2),
        "band": match.group(3),
        "segment": match.group(4),
    }


def _observation_age_minutes(date_raw, time_raw):
    observed = datetime.strptime(
        date_raw + time_raw,
        "%Y%m%d%H%M"
    ).replace(tzinfo=timezone.utc)

    delta = datetime.now(timezone.utc) - observed

    return delta.total_seconds() / 60.0


def find_latest_observation_files():
    """
    Mengembalikan (file_b07, file_b14) dari SATU observasi
    yang sama (tanggal, jam, dan segmen identik).

    1. Utamakan data/latest.json yang ditulis fetch_himawari.py.
    2. Jika tidak ada, cari timestamp terbaru di data/ yang
       memiliki B07 dan B14 untuk SEGMENT.
    """

    pair = None

    # --- 1. manifest dari fetch_himawari.py ---------------------
    if MANIFEST_FILE.exists():
        manifest = json.loads(
            MANIFEST_FILE.read_text(encoding="utf-8")
        )

        if manifest.get("segment") != SEGMENT:
            raise ValueError(
                f"Segmen manifest ({manifest.get('segment')}) "
                f"berbeda dengan SEGMENT ({SEGMENT})."
            )

        b07 = DATA_DIR / manifest["files"]["B07"]
        b14 = DATA_DIR / manifest["files"]["B14"]

        for f in (b07, b14):
            if not f.exists():
                raise FileNotFoundError(
                    f"File di manifest tidak ada: {f}"
                )

        pair = (b07, b14)
        print("Memakai observasi dari latest.json")

    # --- 2. fallback: scan folder data ---------------------------
    else:
        found = {}

        for f in DATA_DIR.glob("HS_H*_FLDK_R20_*.DAT.bz2"):
            info = _parse_name(f)

            if not info or info["segment"] != SEGMENT:
                continue

            key = (info["date"], info["time"])
            found.setdefault(key, {})[info["band"]] = f

        complete = [
            key for key, bands in found.items()
            if "B07" in bands and "B14" in bands
        ]

        if not complete:
            raise FileNotFoundError(
                f"Tidak ada observasi lengkap (B07 + B14, "
                f"{SEGMENT}) di folder:\n{DATA_DIR}"
            )

        latest = max(complete)
        pair = (found[latest]["B07"], found[latest]["B14"])
        print("latest.json tidak ada, memakai scan folder data")

    # --- validasi pasangan ---------------------------------------
    info07 = _parse_name(pair[0])
    info14 = _parse_name(pair[1])

    if not info07 or not info14:
        raise ValueError("Nama file Himawari tidak dikenali.")

    if (
        info07["date"] != info14["date"]
        or info07["time"] != info14["time"]
        or info07["segment"] != info14["segment"]
    ):
        raise ValueError(
            "B07 dan B14 berasal dari observasi berbeda: "
            f"{pair[0].name} vs {pair[1].name}"
        )

    age = _observation_age_minutes(
        info07["date"],
        info07["time"]
    )

    print(
        f"Observasi: {info07['date']} {info07['time']} UTC "
        f"({age:.0f} menit lalu)"
    )

    if (
        age > MAX_OBSERVATION_AGE_MINUTES
        and "--allow-stale" not in sys.argv
    ):
        raise RuntimeError(
            f"Data berusia {age:.0f} menit "
            f"(> {MAX_OBSERVATION_AGE_MINUTES}). "
            "Jalankan fetch_himawari.py dulu, "
            "atau gunakan --allow-stale."
        )

    return pair


# =========================================================
# BACA FILE HIMAWARI HSD
# =========================================================

def read_hsd_file(filepath):

    print(f"\nMembaca file: {filepath}")

    # -----------------------------------------------------
    # Decompress BZ2
    # -----------------------------------------------------

    with bz2.open(filepath, "rb") as f:
        data = f.read()

    print(
        f"Ukuran data setelah decompress: "
        f"{len(data):,} bytes"
    )

    # -----------------------------------------------------
    # Struktur header HSD
    # -----------------------------------------------------

    block_lengths = [
        282,
        50,
        127,
        139,
        147,
        259,
        47,
        81,
        85,
        47,
        259,
    ]

    blocks = []

    offset = 0

    for i, length in enumerate(
        block_lengths,
        start=1
    ):
        blocks.append({
            "number": i,
            "offset": offset,
            "length": length,
        })

        print(
            f"Block {i:02d}: "
            f"offset={offset:,}, "
            f"length={length:,}"
        )

        offset += length

    # -----------------------------------------------------
    # Block 12 = pixel data
    # -----------------------------------------------------

    fixed_offset = offset

    rows = LINES_PER_SEGMENT
    cols = 5500

    expected_pixels = rows * cols
    expected_bytes = expected_pixels * 2

    # Total panjang header tertulis di block 1 (uint32, offset 70).
    # Lebih andal daripada menjumlah panjang block tetap, karena
    # block 8-10 bisa berubah panjangnya.
    header_length = struct.unpack_from("<I", data, 70)[0]

    if header_length + expected_bytes == len(data):
        data_offset = header_length

        if header_length != fixed_offset:
            print(
                f"[INFO] Panjang header dari block 1 "
                f"({header_length}) berbeda dari jumlah block "
                f"tetap ({fixed_offset}); memakai nilai block 1."
            )

    elif fixed_offset + expected_bytes <= len(data):
        data_offset = fixed_offset

        print(
            "[PERINGATAN] Panjang header block 1 tidak "
            "konsisten dengan ukuran file; memakai offset "
            "block tetap."
        )

    else:
        raise ValueError(
            f"Ukuran file tidak cocok. Header block 1="
            f"{header_length}, data={len(data)} bytes, "
            f"pixel dibutuhkan={expected_bytes}."
        )

    pixel_data = data[
        data_offset:
        data_offset + expected_bytes
    ]

    if len(pixel_data) != expected_bytes:
        raise ValueError(
            f"Ukuran pixel tidak sesuai. "
            f"Expected {expected_bytes:,}, "
            f"dapat {len(pixel_data):,}"
        )

    pixels = np.frombuffer(
        pixel_data,
        dtype="<u2"
    ).reshape(
        rows,
        cols
    )

    print(
        f"\nShape pixel           : "
        f"{pixels.shape}"
    )

    print(
        f"Nilai pixel minimum   : "
        f"{pixels.min()}"
    )

    print(
        f"Nilai pixel maksimum  : "
        f"{pixels.max()}"
    )

    # -----------------------------------------------------
    # Block 5 = calibration
    # -----------------------------------------------------

    block5 = blocks[4]

    block5_data = data[
        block5["offset"]:
        block5["offset"] + block5["length"]
    ]

    wavelength = struct.unpack_from(
        "<d",
        block5_data,
        5
    )[0]

    valid_bits = struct.unpack_from(
        "<H",
        block5_data,
        13
    )[0]

    slope = struct.unpack_from(
        "<d",
        block5_data,
        19
    )[0]

    intercept = struct.unpack_from(
        "<d",
        block5_data,
        27
    )[0]

    c0 = struct.unpack_from(
        "<d",
        block5_data,
        35
    )[0]

    c1 = struct.unpack_from(
        "<d",
        block5_data,
        43
    )[0]

    c2 = struct.unpack_from(
        "<d",
        block5_data,
        51
    )[0]

    c = struct.unpack_from(
        "<d",
        block5_data,
        83
    )[0]

    h = struct.unpack_from(
        "<d",
        block5_data,
        91
    )[0]

    k = struct.unpack_from(
        "<d",
        block5_data,
        99
    )[0]

    calibration = {
        "wavelength": wavelength,
        "valid_bits": valid_bits,
        "slope": slope,
        "intercept": intercept,
        "c0": c0,
        "c1": c1,
        "c2": c2,
        "c": c,
        "h": h,
        "k": k,
    }

    print("\n=== KALIBRASI ===")

    print(
        f"Wavelength : "
        f"{wavelength} µm"
    )

    print(
        f"Valid bits : "
        f"{valid_bits}"
    )

    print(
        f"Slope      : "
        f"{slope}"
    )

    print(
        f"Intercept  : "
        f"{intercept}"
    )

    print(
        f"c0         : "
        f"{c0}"
    )

    print(
        f"c1         : "
        f"{c1}"
    )

    print(
        f"c2         : "
        f"{c2}"
    )

    return {
        "pixels": pixels,
        "calibration": calibration,
    }


# =========================================================
# RAW COUNT → BRIGHTNESS TEMPERATURE
# =========================================================

def counts_to_brightness_temperature(
    counts,
    calibration
):

    wavelength = calibration["wavelength"]
    slope = calibration["slope"]
    intercept = calibration["intercept"]

    c0 = calibration["c0"]
    c1 = calibration["c1"]
    c2 = calibration["c2"]

    c = calibration["c"]
    h = calibration["h"]
    k = calibration["k"]

    # -----------------------------------------------------
    # Nilai invalid
    # -----------------------------------------------------

    invalid = (
        (counts == 65534)
        |
        (counts == 65535)
        |
        (counts == 0)
    )

    # -----------------------------------------------------
    # Count → Radiance
    # -----------------------------------------------------

    radiance = (
        slope *
        counts.astype(np.float64)
        +
        intercept
    )

    invalid |= radiance <= 0

    # -----------------------------------------------------
    # Output
    # -----------------------------------------------------

    bt = np.full(
        counts.shape,
        np.nan,
        dtype=np.float64
    )

    valid = ~invalid

    # -----------------------------------------------------
    # Wavelength µm → meter
    # -----------------------------------------------------

    wavelength_m = wavelength * 1e-6

    # -----------------------------------------------------
    # Radiance
    # -----------------------------------------------------

    radiance_si = (
        radiance[valid] * 1e6
    )

    # -----------------------------------------------------
    # Effective temperature
    # -----------------------------------------------------

    te = (
        h * c /
        (k * wavelength_m)
    ) / np.log(
        (
            2 * h * c**2
        )
        /
        (
            wavelength_m**5 *
            radiance_si
        )
        + 1
    )

    # -----------------------------------------------------
    # Brightness Temperature
    # -----------------------------------------------------

    bt[valid] = (
        c0
        + c1 * te
        + c2 * te**2
    )

    return bt


# =========================================================
# STATISTIK BRIGHTNESS TEMPERATURE
# =========================================================

def print_bt_statistics(
    bt,
    name
):

    valid = bt[
        ~np.isnan(bt)
    ]

    print(
        f"\n=== BRIGHTNESS TEMPERATURE "
        f"{name} ==="
    )

    print(
        f"Minimum : "
        f"{np.min(valid):.2f} K"
    )

    print(
        f"Maximum : "
        f"{np.max(valid):.2f} K"
    )

    print(
        f"Median  : "
        f"{np.median(valid):.2f} K"
    )

    print(
        f"Mean    : "
        f"{np.mean(valid):.2f} K"
    )


# =========================================================
# GEOLOCATION HIMAWARI
# =========================================================

def pixel_to_latlon(
    row,
    col,
    first_line=2751
):
    """
    Mengubah koordinat pixel Himawari
    menjadi latitude dan longitude.
    """

    # -----------------------------------------------------
    # Parameter proyeksi Himawari
    # -----------------------------------------------------

    sub_lon = 140.7

    CFAC = 20466275
    LFAC = 20466275

    COFF = 2750.5
    LOFF = 2750.5

    H = 42164.0

    req = 6378.137
    rpol = 6356.7523

    # -----------------------------------------------------
    # Pixel lokal → pixel global
    # -----------------------------------------------------

    line = first_line + row
    column = col + 1

    # -----------------------------------------------------
    # Pixel → sudut proyeksi
    # -----------------------------------------------------

    x = (
        np.pi *
        (column - COFF)
        /
        (
            180.0 *
            (2 ** -16) *
            CFAC
        )
    )

    y = (
        np.pi *
        (line - LOFF)
        /
        (
            180.0 *
            (2 ** -16) *
            LFAC
        )
    )

    # -----------------------------------------------------
    # Perhitungan geostationary projection
    # -----------------------------------------------------

    cos_x = np.cos(x)
    sin_x = np.sin(x)

    cos_y = np.cos(y)
    sin_y = np.sin(y)

    ratio = (
        req ** 2 /
        rpol ** 2
    )

    a = (
        cos_y ** 2
        +
        ratio *
        sin_y ** 2
    )

    discriminant = (
        (
            H *
            cos_x *
            cos_y
        ) ** 2
        -
        a *
        (
            H ** 2 -
            req ** 2
        )
    )

    if discriminant < 0:
        return None, None

    sd = np.sqrt(
        discriminant
    )

    sn = (
        H *
        cos_x *
        cos_y
        -
        sd
    ) / a

    s1 = (
        H
        -
        sn *
        cos_x *
        cos_y
    )

    s2 = (
        sn *
        sin_x *
        cos_y
    )

    s3 = (
        -sn *
        sin_y
    )

    # -----------------------------------------------------
    # Latitude
    # -----------------------------------------------------

    latitude = np.degrees(
        np.arctan(
            ratio *
            s3 /
            np.sqrt(
                s1 ** 2 +
                s2 ** 2
            )
        )
    )

    # -----------------------------------------------------
    # Longitude
    # -----------------------------------------------------

    longitude = (
        sub_lon
        +
        np.degrees(
            np.arctan2(
                s2,
                s1
            )
        )
    )

    return (
        float(latitude),
        float(longitude)
    )


# =========================================================
# HITUNG STATISTIK LOKAL
# =========================================================

def calculate_local_statistics(
    bt,
    window_size=5
):
    """
    Menghitung rata-rata dan standar deviasi
    lingkungan setiap pixel.

    Pixel tengah tidak digunakan dalam
    perhitungan background.

    Menggunakan integral image sehingga tidak
    membutuhkan scipy.
    """

    if window_size % 2 == 0:
        raise ValueError(
            "window_size harus berupa angka ganjil."
        )

    radius = window_size // 2

    valid = np.isfinite(bt)

    values = np.where(
        valid,
        bt,
        0.0
    )

    values_squared = np.where(
        valid,
        bt ** 2,
        0.0
    )

    valid_count = valid.astype(
        np.float64
    )

    # -----------------------------------------------------
    # Padding
    # -----------------------------------------------------

    padded_values = np.pad(
        values,
        (
            (radius, radius),
            (radius, radius)
        ),
        mode="constant",
        constant_values=0
    )

    padded_squared = np.pad(
        values_squared,
        (
            (radius, radius),
            (radius, radius)
        ),
        mode="constant",
        constant_values=0
    )

    padded_count = np.pad(
        valid_count,
        (
            (radius, radius),
            (radius, radius)
        ),
        mode="constant",
        constant_values=0
    )

    # -----------------------------------------------------
    # Integral image
    # -----------------------------------------------------

    integral_values = np.pad(
        padded_values.cumsum(axis=0).cumsum(axis=1),
        (
            (1, 0),
            (1, 0)
        ),
        mode="constant",
        constant_values=0
    )

    integral_squared = np.pad(
        padded_squared.cumsum(axis=0).cumsum(axis=1),
        (
            (1, 0),
            (1, 0)
        ),
        mode="constant",
        constant_values=0
    )

    integral_count = np.pad(
        padded_count.cumsum(axis=0).cumsum(axis=1),
        (
            (1, 0),
            (1, 0)
        ),
        mode="constant",
        constant_values=0
    )

    height, width = bt.shape

    y1 = np.arange(
        0,
        height
    )

    y2 = y1 + window_size

    x1 = np.arange(
        0,
        width
    )

    x2 = x1 + window_size

    # -----------------------------------------------------
    # Jumlah nilai dalam window
    # -----------------------------------------------------

    window_sum = (
        integral_values[
            y2[:, None],
            x2[None, :]
        ]
        -
        integral_values[
            y1[:, None],
            x2[None, :]
        ]
        -
        integral_values[
            y2[:, None],
            x1[None, :]
        ]
        +
        integral_values[
            y1[:, None],
            x1[None, :]
        ]
    )

    # -----------------------------------------------------
    # Jumlah kuadrat
    # -----------------------------------------------------

    window_squared_sum = (
        integral_squared[
            y2[:, None],
            x2[None, :]
        ]
        -
        integral_squared[
            y1[:, None],
            x2[None, :]
        ]
        -
        integral_squared[
            y2[:, None],
            x1[None, :]
        ]
        +
        integral_squared[
            y1[:, None],
            x1[None, :]
        ]
    )

    # -----------------------------------------------------
    # Jumlah pixel valid
    # -----------------------------------------------------

    window_count = (
        integral_count[
            y2[:, None],
            x2[None, :]
        ]
        -
        integral_count[
            y1[:, None],
            x2[None, :]
        ]
        -
        integral_count[
            y2[:, None],
            x1[None, :]
        ]
        +
        integral_count[
            y1[:, None],
            x1[None, :]
        ]
    )

    # -----------------------------------------------------
    # Hapus pixel tengah dari background
    # -----------------------------------------------------

    center_valid = valid

    window_sum = (
        window_sum
        -
        np.where(
            center_valid,
            bt,
            0.0
        )
    )

    window_squared_sum = (
        window_squared_sum
        -
        np.where(
            center_valid,
            bt ** 2,
            0.0
        )
    )

    window_count = (
        window_count
        -
        center_valid.astype(
            np.float64
        )
    )

    # -----------------------------------------------------
    # Local mean
    # -----------------------------------------------------

    local_mean = np.full(
        bt.shape,
        np.nan,
        dtype=np.float64
    )

    valid_context = (
        window_count >=
        MIN_VALID_CONTEXT_PIXELS
    )

    local_mean[valid_context] = (
        window_sum[valid_context]
        /
        window_count[valid_context]
    )

    # -----------------------------------------------------
    # Local variance
    # -----------------------------------------------------

    local_variance = np.full(
        bt.shape,
        np.nan,
        dtype=np.float64
    )

    local_variance[valid_context] = (
        window_squared_sum[valid_context]
        /
        window_count[valid_context]
        -
        local_mean[valid_context] ** 2
    )

    # Floating point error bisa menghasilkan
    # nilai negatif sangat kecil.
    local_variance = np.maximum(
        local_variance,
        0.0
    )

    local_std = np.full(
        bt.shape,
        np.nan,
        dtype=np.float64
    )

    local_std[valid_context] = np.sqrt(
        local_variance[valid_context]
    )

    return (
        local_mean,
        local_std,
        window_count
    )


# =========================================================
# DETEKSI KANDIDAT HOTSPOT
# =========================================================

def detect_hotspots(
    bt07,
    bt14
):
    """
    Mendeteksi kandidat hotspot menggunakan
    kombinasi threshold absolut dan
    contextual detection.

    Kandidat harus memenuhi:

    1. BT07 > 325 K
    2. BT07 - BT14 > 20 K
    3. BT14 < 300 K
    4. BT07 lebih panas dari background lokal
    5. Anomali lokal minimal 6 K
    6. Kandidat minimal 1.5 standar deviasi
       di atas background lokal

    Threshold absolut merupakan pendekatan
    literatur/prototipe, bukan standar resmi JMA.
    """

    # -----------------------------------------------------
    # Hitung selisih B07 dan B14
    # -----------------------------------------------------

    difference = bt07 - bt14

    # -----------------------------------------------------
    # Hitung statistik lingkungan B07
    # -----------------------------------------------------

    print(
        "\nMenghitung statistik "
        "lingkungan lokal..."
    )

    (
        local_mean,
        local_std,
        local_count
    ) = calculate_local_statistics(
        bt07,
        window_size=CONTEXT_SIZE
    )

    # -----------------------------------------------------
    # Local anomaly
    # -----------------------------------------------------

    local_anomaly = (
        bt07 -
        local_mean
    )

    # -----------------------------------------------------
    # Contextual threshold
    # -----------------------------------------------------

    contextual_threshold = (
        local_mean
        +
        np.maximum(
            MIN_LOCAL_ANOMALY,
            LOCAL_STD_MULTIPLIER *
            local_std
        )
    )

    # -----------------------------------------------------
    # Threshold absolut
    # -----------------------------------------------------

    absolute_mask = (
        (bt07 > MIN_BT07)
        &
        (difference > MIN_BT_DIFFERENCE)
        &
        (bt14 < MAX_BT14)
    )

    # -----------------------------------------------------
    # Contextual mask
    # -----------------------------------------------------

    contextual_mask = (
        np.isfinite(local_mean)
        &
        np.isfinite(local_std)
        &
        (
            local_count >=
            MIN_VALID_CONTEXT_PIXELS
        )
        &
        (
            bt07 >
            contextual_threshold
        )
    )

    # -----------------------------------------------------
    # Gabungkan threshold
    # -----------------------------------------------------

    candidate_mask = (
        absolute_mask
        &
        contextual_mask
    )

    rows, cols = np.where(
        candidate_mask
    )

    candidates = []

    # -----------------------------------------------------
    # Konversi pixel → koordinat
    # -----------------------------------------------------

    for row, col in zip(
        rows,
        cols
    ):

        latitude, longitude = (
            pixel_to_latlon(
                row,
                col,
                first_line=FIRST_LINE
            )
        )

        if latitude is None:
            continue

        # -------------------------------------------------
        # Filter wilayah Bangka Belitung (polygon GeoJSON)
        # -------------------------------------------------

        if not point_in_bangka_belitung(
            latitude,
            longitude
        ):
            continue

        candidates.append({
            "row": int(row),
            "col": int(col),

            "latitude": latitude,
            "longitude": longitude,

            "bt07": float(
                bt07[row, col]
            ),

            "bt14": float(
                bt14[row, col]
            ),

            "difference": float(
                difference[row, col]
            ),

            "local_mean": float(
                local_mean[row, col]
            ),

            "local_std": float(
                local_std[row, col]
            ),

            "local_anomaly": float(
                local_anomaly[row, col]
            ),

            "local_count": int(
                local_count[row, col]
            ),
        })

    # =====================================================
    # DIAGNOSTIK KANDIDAT
    # =====================================================

    print(
        "\n=== DIAGNOSTIK PIXEL KANDIDAT ==="
    )

    print(
        f"Threshold BT07        : "
        f">{MIN_BT07:.1f} K"
    )

    print(
        f"Threshold Diff        : "
        f">{MIN_BT_DIFFERENCE:.1f} K"
    )

    print(
        f"Threshold BT14        : "
        f"<{MAX_BT14:.1f} K"
    )

    print(
        f"Ukuran context        : "
        f"{CONTEXT_SIZE}x{CONTEXT_SIZE}"
    )

    print(
        f"Minimum anomali lokal : "
        f"{MIN_LOCAL_ANOMALY:.1f} K"
    )

    print(
        f"Pengali local std     : "
        f"{LOCAL_STD_MULTIPLIER:.1f}"
    )

    print(
        f"Total kandidat setelah "
        f"filter wilayah: {len(candidates)}"
    )

    if candidates:

        rows_candidate = [
            item["row"]
            for item in candidates
        ]

        cols_candidate = [
            item["col"]
            for item in candidates
        ]

        print(
            f"Row minimum : "
            f"{min(rows_candidate)}"
        )

        print(
            f"Row maksimum : "
            f"{max(rows_candidate)}"
        )

        print(
            f"Col minimum : "
            f"{min(cols_candidate)}"
        )

        print(
            f"Col maksimum : "
            f"{max(cols_candidate)}"
        )

        print(
            "\n10 kandidat pertama:"
        )

        for candidate in candidates[:10]:

            print(
                f"row={candidate['row']}, "
                f"col={candidate['col']}, "
                f"lat={candidate['latitude']:.6f}, "
                f"lon={candidate['longitude']:.6f}, "
                f"BT07={candidate['bt07']:.2f}, "
                f"BT14={candidate['bt14']:.2f}, "
                f"Diff={candidate['difference']:.2f}, "
                f"LocalMean={candidate['local_mean']:.2f}, "
                f"LocalStd={candidate['local_std']:.2f}, "
                f"Anomaly={candidate['local_anomaly']:.2f}"
            )

    return candidates


# =========================================================
# HITUNG JARAK HAVERSINE
# =========================================================

def haversine_distance(
    lat1,
    lon1,
    lat2,
    lon2
):
    """
    Menghitung jarak antara dua koordinat
    dalam kilometer.
    """

    R = 6371.0

    lat1 = np.radians(lat1)
    lat2 = np.radians(lat2)

    dlat = lat2 - lat1

    dlon = (
        np.radians(lon2)
        -
        np.radians(lon1)
    )

    a = (
        np.sin(dlat / 2) ** 2
        +
        np.cos(lat1)
        *
        np.cos(lat2)
        *
        np.sin(dlon / 2) ** 2
    )

    c = (
        2 *
        np.arctan2(
            np.sqrt(a),
            np.sqrt(1 - a)
        )
    )

    return R * c


# =========================================================
# CLUSTERING HOTSPOT
# =========================================================

def cluster_hotspots(
    candidates,
    max_distance_km=CLUSTER_DISTANCE_KM
):
    """
    Mengelompokkan kandidat hotspot
    berdasarkan jarak geografis.

    Kandidat dengan jarak <= 5 km
    dianggap berada dalam cluster
    yang sama.
    """

    if not candidates:
        return []

    clusters = []

    for candidate in candidates:

        assigned = False

        # -------------------------------------------------
        # Cek terhadap cluster yang sudah ada
        # -------------------------------------------------

        for cluster in clusters:

            center = cluster["center"]

            distance = haversine_distance(
                candidate["latitude"],
                candidate["longitude"],
                center["latitude"],
                center["longitude"]
            )

            # ---------------------------------------------
            # Masih dalam radius cluster
            # ---------------------------------------------

            if distance <= max_distance_km:

                cluster["candidates"].append(
                    candidate
                )

                assigned = True

                # -----------------------------------------
                # Hitung ulang pusat cluster
                # -----------------------------------------

                lats = [
                    item["latitude"]
                    for item
                    in cluster["candidates"]
                ]

                lons = [
                    item["longitude"]
                    for item
                    in cluster["candidates"]
                ]

                cluster["center"] = {
                    "latitude": float(
                        np.mean(lats)
                    ),

                    "longitude": float(
                        np.mean(lons)
                    )
                }

                break

        # -------------------------------------------------
        # Tidak masuk cluster mana pun
        # -------------------------------------------------

        if not assigned:

            clusters.append({
                "center": {
                    "latitude":
                        candidate["latitude"],

                    "longitude":
                        candidate["longitude"],
                },

                "candidates": [
                    candidate
                ],
            })

    return clusters


# =========================================================
# AMBIL INFORMASI DARI NAMA FILE
# =========================================================

def parse_himawari_filename(filepath):
    """
    Mengambil informasi tanggal, waktu,
    satelit, dan band dari nama file.
    """

    filename = Path(filepath).name

    pattern = (
        r"HS_(H\d{2})_"
        r"(\d{8})_"
        r"(\d{4})_"
        r"(B\d{2})_"
    )

    match = re.search(
        pattern,
        filename
    )

    if not match:

        raise ValueError(
            f"Format nama file Himawari "
            f"tidak dikenali: {filename}"
        )

    satellite = match.group(1)

    acq_date_raw = match.group(2)

    acq_time = match.group(3)

    band = match.group(4)

    acq_date = (
        f"{acq_date_raw[0:4]}-"
        f"{acq_date_raw[4:6]}-"
        f"{acq_date_raw[6:8]}"
    )

    return {
        "satellite": satellite,
        "acq_date": acq_date,
        "acq_time": acq_time,
        "band": band,
    }


# =========================================================
# BUAT DATA HOTSPOT
# =========================================================

def prepare_hotspot_results(
    clusters,
    b07_file
):

    file_info = parse_himawari_filename(
        b07_file
    )

    results = []

    for cluster in clusters:

        candidates = cluster["candidates"]

        # -------------------------------------------------
        # Gunakan pixel dengan BT07 tertinggi
        # sebagai representasi cluster
        # -------------------------------------------------

        representative = max(
            candidates,
            key=lambda item: item["bt07"]
        )

        results.append({
            "latitude": round(
                cluster["center"]["latitude"],
                7
            ),

            "longitude": round(
                cluster["center"]["longitude"],
                7
            ),

            "source": "HIMAWARI9",

            "satellite": file_info["satellite"],

            "instrument": "AHI",

            "acq_date": file_info["acq_date"],

            "acq_time": file_info["acq_time"],

            # acq_time = HHMM dalam UTC (WIB = UTC + 7)
            "timezone": "UTC",

            "bt07": round(
                representative["bt07"],
                3
            ),

            "bt14": round(
                representative["bt14"],
                3
            ),

            "bt_difference": round(
                representative["difference"],
                3
            ),

            "pixel_count": len(
                candidates
            ),

            "region": None,
        })

    return results


# =========================================================
# SIMPAN HASIL KE JSON
# =========================================================

def save_results_json(
    results,
    output_file=OUTPUT_FILE
):

    output_path = Path(
        output_file
    )

    output_path.parent.mkdir(
        parents=True,
        exist_ok=True
    )

    with open(
        output_path,
        "w",
        encoding="utf-8"
    ) as f:

        json.dump(
            results,
            f,
            indent=4,
            ensure_ascii=False
        )

    print(
        f"\nHasil JSON disimpan ke:"
        f"\n{output_path}"
    )


# =========================================================
# MAIN
# =========================================================

if __name__ == "__main__":

    # =====================================================
    # CARI FILE TERBARU
    # =====================================================

    print("\n")

    print(
        "========================================"
    )

    print(
        "MENCARI DATA HIMAWARI TERBARU"
    )

    print(
        "========================================"
    )

    b07_file, b14_file = (
        find_latest_observation_files()
    )

    # =====================================================
    # B07
    # =====================================================

    print("\n")

    print(
        "========================================"
    )

    print(
        "MEMPROSES HIMAWARI-9 B07"
    )

    print(
        "========================================"
    )

    b07 = read_hsd_file(
        b07_file
    )

    bt07 = (
        counts_to_brightness_temperature(
            b07["pixels"],
            b07["calibration"]
        )
    )

    print_bt_statistics(
        bt07,
        "B07"
    )

    # =====================================================
    # B14
    # =====================================================

    print("\n")

    print(
        "========================================"
    )

    print(
        "MEMPROSES HIMAWARI-9 B14"
    )

    print(
        "========================================"
    )

    b14 = read_hsd_file(
        b14_file
    )

    bt14 = (
        counts_to_brightness_temperature(
            b14["pixels"],
            b14["calibration"]
        )
    )

    print_bt_statistics(
        bt14,
        "B14"
    )

    # =====================================================
    # DETEKSI HOTSPOT
    # =====================================================

    print("\n")

    print(
        "========================================"
    )

    print(
        "DETEKSI KANDIDAT HOTSPOT"
    )

    print(
        "========================================"
    )

    candidates = detect_hotspots(
        bt07,
        bt14
    )

    print(
        f"\nJumlah kandidat pixel "
        f"di wilayah Bangka Belitung: "
        f"{len(candidates)}"
    )

    # =====================================================
    # CLUSTERING HOTSPOT
    # =====================================================

    clusters = cluster_hotspots(
        candidates,
        max_distance_km=CLUSTER_DISTANCE_KM
    )

    print("\n")

    print(
        "========================================"
    )

    print(
        "HASIL CLUSTERING"
    )

    print(
        "========================================"
    )

    print(
        f"Jumlah kandidat pixel : "
        f"{len(candidates)}"
    )

    print(
        f"Jumlah hotspot        : "
        f"{len(clusters)}"
    )

    # =====================================================
    # TAMPILKAN HASIL HOTSPOT
    # =====================================================

    for i, cluster in enumerate(
        clusters,
        start=1
    ):

        center = cluster["center"]

        print(
            "\n----------------------------------------"
        )

        print(
            f"HOTSPOT #{i}"
        )

        print(
            "----------------------------------------"
        )

        print(
            f"Latitude  : "
            f"{center['latitude']:.6f}"
        )

        print(
            f"Longitude : "
            f"{center['longitude']:.6f}"
        )

        print(
            f"Jumlah pixel : "
            f"{len(cluster['candidates'])}"
        )

        # -------------------------------------------------
        # Detail pixel dalam cluster
        # -------------------------------------------------

        for j, candidate in enumerate(
            cluster["candidates"],
            start=1
        ):

            print(
                f"  Pixel #{j}: "
                f"BT07={candidate['bt07']:.2f} K, "
                f"BT14={candidate['bt14']:.2f} K, "
                f"Diff={candidate['difference']:.2f} K, "
                f"Anomaly={candidate['local_anomaly']:.2f} K"
            )

    # =====================================================
    # SIAPKAN DATA UNTUK LARAVEL
    # =====================================================

    results = prepare_hotspot_results(
        clusters,
        b07_file
    )

    # =====================================================
    # SIMPAN JSON
    # =====================================================

    save_results_json(
        results
    )

    # =====================================================
    # TAMPILKAN JSON
    # =====================================================

    print("\n")

    print(
        "========================================"
    )

    print(
        "DATA UNTUK LARAVEL"
    )

    print(
        "========================================"
    )

    print(
        json.dumps(
            results,
            indent=4,
            ensure_ascii=False
        )
    )

    print("\n")

    print(
        "========================================"
    )

    print(
        "DETEKSI SELESAI"
    )

    print(
        "========================================"
    )