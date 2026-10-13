import json
from pathlib import Path

path = Path(__file__).resolve().parent.parent / "storage/app/private/geo/bangka-belitung.geojson"
d = json.loads(path.read_text(encoding="utf-8"))

# Tipe geometry yang dibaca detect_hotspot.py
SUPPORTED = {"Polygon", "MultiPolygon"}

# Bounding box kasar di detect_hotspot.py (point_in_bangka_belitung)
DETECT_BBOX = {"lat": (-3.8, -0.8), "lon": (104.8, 108.5)}


def iter_points(coords):
    """Iterasi semua titik [lon, lat] dari struktur koordinat bersarang."""
    if coords and isinstance(coords[0], (int, float)):
        yield coords
    else:
        for item in coords:
            yield from iter_points(item)


min_lon = min_lat = float("inf")
max_lon = max_lat = float("-inf")
ignored = 0
used_polygons = 0

for i, feat in enumerate(d["features"]):
    props = feat.get("properties", {})
    geom = feat["geometry"]
    gtype = geom["type"]
    name = props.get("namobj") or props.get("NAMOBJ") or props.get("name") or str(props)[:60]

    supported = gtype in SUPPORTED
    note = "" if supported else "  <-- DIABAIKAN oleh detect_hotspot.py"
    print(f"Feature {i}: type={gtype}, name={name}{note}")

    if not supported:
        ignored += 1
        continue

    used_polygons += 1 if gtype == "Polygon" else len(geom["coordinates"])

    for lon, lat, *_ in iter_points(geom["coordinates"]):
        min_lon, max_lon = min(min_lon, lon), max(max_lon, lon)
        min_lat, max_lat = min(min_lat, lat), max(max_lat, lat)

print()
print(f"Polygon yang dipakai detect : {used_polygons}")
print(f"Feature diabaikan           : {ignored}")

if used_polygons:
    print(f"Bounding box GeoJSON        : lat {min_lat:.3f}..{max_lat:.3f}, lon {min_lon:.3f}..{max_lon:.3f}")

    lat_lo, lat_hi = DETECT_BBOX["lat"]
    lon_lo, lon_hi = DETECT_BBOX["lon"]

    if min_lat < lat_lo or max_lat > lat_hi or min_lon < lon_lo or max_lon > lon_hi:
        print("[PERINGATAN] GeoJSON keluar dari bounding box pre-filter di detect_hotspot.py; "
              "hotspot di bagian itu akan terbuang. Perlebar bbox di point_in_bangka_belitung().")
    else:
        print("Bounding box pre-filter di detect_hotspot.py mencakup seluruh GeoJSON.")