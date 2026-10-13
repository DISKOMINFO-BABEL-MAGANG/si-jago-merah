import json
import subprocess
import re
from pathlib import Path
from datetime import datetime, timedelta, timezone


# =====================================================
# KONFIGURASI
# =====================================================

BUCKET = "s3://noaa-himawari9"
PREFIX = "AHI-L1b-FLDK"

BANDS = ["B07", "B14"]

# Segment yang mencakup Bangka Belitung.
# HARUS sama dengan SEGMENT di detect_hotspot.py.
# Tidak ada fallback ke segment lain: segment lain tidak
# mencakup wilayah ini, dan detect_hotspot.py hanya membaca
# segment ini.
REQUIRED_SEGMENT = "S0610"

# Seberapa jauh mundur (menit) mencari observasi yang lengkap.
LOOKBACK_MINUTES = 60

BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "data"

DATA_DIR.mkdir(exist_ok=True)

# Manifest dibaca detect_hotspot.py agar B07 dan B14 yang
# diproses pasti berasal dari observasi yang sama.
MANIFEST_FILE = DATA_DIR / "latest.json"


# =====================================================
# JALANKAN COMMAND
# =====================================================

def run_command(command, allow_failure=False):
    result = subprocess.run(
        command,
        capture_output=True,
        text=True
    )

    if result.returncode != 0:
        if allow_failure:
            return None

        if result.stderr:
            print(result.stderr)

        raise RuntimeError(
            "Perintah AWS gagal."
        )

    return result.stdout


# =====================================================
# CARI OBSERVASI TERBARU
# =====================================================

def get_latest_observation():
    now = datetime.now(timezone.utc)

    # Cek beberapa waktu terakhir karena
    # data Himawari terbaru mungkin belum tersedia.
    for minutes_back in range(0, LOOKBACK_MINUTES + 1, 10):

        check_time = now - timedelta(
            minutes=minutes_back
        )

        # Himawari menggunakan interval 10 menit.
        minute = (
            check_time.minute // 10
        ) * 10

        observation = check_time.replace(
            minute=minute,
            second=0,
            microsecond=0
        )

        date_path = observation.strftime(
            "%Y/%m/%d"
        )

        time_path = observation.strftime(
            "%H%M"
        )

        prefix = (
            f"{PREFIX}/"
            f"{date_path}/"
            f"{time_path}/"
        )

        command = [
            "aws",
            "s3",
            "ls",
            f"{BUCKET}/{prefix}",
            "--no-sign-request"
        ]

        output = run_command(
            command,
            allow_failure=True
        )

        if not (output and output.strip()):
            continue

        # Observasi dianggap layak hanya jika B07 DAN B14
        # untuk segment wajib sudah tersedia. Jika belum,
        # mundur ke observasi 10 menit sebelumnya.
        if is_complete(output):

            print(
                "Data ditemukan: "
                f"{observation.strftime('%Y-%m-%d %H:%M')} UTC"
            )

            return (
                observation,
                prefix,
                output
            )

        print(
            f"{observation.strftime('%H:%M')} UTC belum "
            f"lengkap untuk {REQUIRED_SEGMENT}, "
            "mundur 10 menit."
        )

    raise RuntimeError(
        f"Observasi lengkap ({REQUIRED_SEGMENT}, B07 + B14) "
        f"tidak ditemukan dalam {LOOKBACK_MINUTES} menit terakhir."
    )


# =====================================================
# CARI FILE BAND
# =====================================================

def get_band_files(listing, band):
    pattern = re.compile(
        rf"HS_H09_\d{{8}}_\d{{4}}_"
        rf"{band}_FLDK_R20_(S\d{{4}})\.DAT\.bz2"
    )

    matches = pattern.findall(listing)

    return sorted(
        set(matches)
    )


# =====================================================
# CEK KELENGKAPAN SEGMENT WAJIB
# =====================================================

def is_complete(listing):
    for band in BANDS:
        segments = set(
            get_band_files(
                listing,
                band
            )
        )

        if REQUIRED_SEGMENT not in segments:
            return False

    return True


# =====================================================
# DOWNLOAD BAND
# =====================================================

def download_band(
    prefix,
    listing,
    band,
    segment
):
    pattern = (
        rf"(HS_H09_\d{{8}}_\d{{4}}_"
        rf"{band}_FLDK_R20_"
        rf"{segment}\.DAT\.bz2)"
    )

    match = re.search(
        pattern,
        listing
    )

    if not match:
        raise RuntimeError(
            f"File {band} segment "
            f"{segment} tidak ditemukan."
        )

    filename = match.group(1)

    source = (
        f"{BUCKET}/"
        f"{prefix}"
        f"{filename}"
    )

    destination = DATA_DIR / filename

    if destination.exists():

        print(
            f"Sudah ada: {filename}"
        )

        return destination

    print(
        f"Mengunduh: {filename}"
    )

    command = [
        "aws",
        "s3",
        "cp",
        source,
        str(destination),
        "--no-sign-request"
    ]

    run_command(command)

    print(
        f"Selesai: {destination}"
    )

    return destination


# =====================================================
# MAIN
# =====================================================

def main():

    print("=" * 60)
    print("FETCH HIMAWARI-9")
    print("=" * 60)

    # -------------------------------------------------
    # CARI DATA TERBARU
    # -------------------------------------------------

    observation, prefix, listing = (
        get_latest_observation()
    )

    print(
        "Observasi : "
        f"{observation.strftime('%Y-%m-%d %H:%M')} UTC"
    )

    # -------------------------------------------------
    # CARI SEGMENT YANG TERSEDIA
    # -------------------------------------------------

    segment = REQUIRED_SEGMENT

    print(
        "Segment yang digunakan: "
        f"{segment}"
    )

    # -------------------------------------------------
    # DOWNLOAD B07 + B14
    # -------------------------------------------------

    files = []

    for band in BANDS:

        file = download_band(
            prefix,
            listing,
            band,
            segment
        )

        files.append(file)

    # -------------------------------------------------
    # TULIS MANIFEST (dibaca detect_hotspot.py)
    # -------------------------------------------------

    manifest = {
        "observation_utc": observation.strftime(
            "%Y-%m-%dT%H:%M:00Z"
        ),
        "segment": segment,
        "files": {
            band: file.name
            for band, file in zip(BANDS, files)
        },
        "fetched_at_utc": datetime.now(
            timezone.utc
        ).strftime("%Y-%m-%dT%H:%M:%SZ"),
    }

    tmp = MANIFEST_FILE.with_suffix(".json.tmp")

    tmp.write_text(
        json.dumps(manifest, indent=4),
        encoding="utf-8"
    )

    tmp.replace(MANIFEST_FILE)

    # -------------------------------------------------
    # HASIL
    # -------------------------------------------------

    print()

    print(
        "File Himawari berhasil disiapkan:"
    )

    for file in files:
        print(
            f"- {file.name}"
        )

    print()

    print(
        "Segment digunakan: "
        f"{segment}"
    )

    print(
        "Observasi: "
        f"{observation.strftime('%Y-%m-%d %H:%M')} UTC"
    )


# =====================================================
# START
# =====================================================

if __name__ == "__main__":
    main()