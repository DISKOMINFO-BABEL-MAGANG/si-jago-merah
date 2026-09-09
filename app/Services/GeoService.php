<?php

namespace App\Services;

use Illuminate\Support\Facades\Storage;

class GeoService
{
    protected array $geojson;

    public function __construct()
    {
        $path = 'geo/bangka-belitung.geojson';

        if (!Storage::disk('local')->exists($path)) {
            throw new \RuntimeException(
                'File boundary Bangka Belitung tidak ditemukan.'
            );
        }

        $this->geojson = json_decode(
            Storage::disk('local')->get($path),
            true
        );

        if (
            !isset($this->geojson['features']) ||
            !is_array($this->geojson['features'])
        ) {
            throw new \RuntimeException(
                'Format GeoJSON Bangka Belitung tidak valid.'
            );
        }
    }

    /**
     * Mengecek apakah sebuah titik berada
     * di dalam wilayah Bangka Belitung.
     */
    public function isInsideBangkaBelitung(
        float $latitude,
        float $longitude
    ): bool {
        foreach ($this->geojson['features'] as $feature) {

            $geometry = $feature['geometry'] ?? null;

            if (!$geometry) {
                continue;
            }

            if (
                $geometry['type'] === 'Polygon' &&
                $this->pointInPolygon(
                    $latitude,
                    $longitude,
                    $geometry['coordinates']
                )
            ) {
                return true;
            }

            if ($geometry['type'] === 'MultiPolygon') {

                foreach ($geometry['coordinates'] as $polygon) {

                    if (
                        $this->pointInPolygon(
                            $latitude,
                            $longitude,
                            $polygon
                        )
                    ) {
                        return true;
                    }
                }
            }
        }

        return false;
    }

    /**
     * Point-in-Polygon menggunakan
     * Ray Casting Algorithm.
     */
    protected function pointInPolygon(
        float $latitude,
        float $longitude,
        array $polygon
    ): bool {

        /*
         * GeoJSON Polygon:
         *
         * coordinates = [
         *     outer ring,
         *     hole 1,
         *     hole 2,
         *     ...
         * ]
         *
         * Kita menggunakan outer ring terlebih dahulu.
         */

        if (empty($polygon[0])) {
            return false;
        }

        $ring = $polygon[0];

        $inside = false;

        $count = count($ring);

        for ($i = 0, $j = $count - 1; $i < $count; $j = $i++) {

            $xi = (float) $ring[$i][0];
            $yi = (float) $ring[$i][1];

            $xj = (float) $ring[$j][0];
            $yj = (float) $ring[$j][1];

            /*
             * GeoJSON:
             *
             * [longitude, latitude]
             *
             * Jadi:
             * x = longitude
             * y = latitude
             */

            $intersects = (
                (($yi > $latitude) !== ($yj > $latitude))
                &&
                (
                    $longitude <
                    ($xj - $xi)
                    * ($latitude - $yi)
                    / (($yj - $yi) ?: 0.0000001)
                    + $xi
                )
            );

            if ($intersects) {
                $inside = !$inside;
            }
        }

        return $inside;
    }

    /**
     * Mendapatkan nama kabupaten/kota
     * berdasarkan koordinat hotspot.
     */
    public function getRegion(
        float $latitude,
        float $longitude
    ): ?string {

        foreach ($this->geojson['features'] as $feature) {

            $geometry = $feature['geometry'] ?? null;

            if (!$geometry) {
                continue;
            }

            $inside = false;

            if ($geometry['type'] === 'Polygon') {

                $inside = $this->pointInPolygon(
                    $latitude,
                    $longitude,
                    $geometry['coordinates']
                );

            } elseif ($geometry['type'] === 'MultiPolygon') {

                foreach ($geometry['coordinates'] as $polygon) {

                    if (
                        $this->pointInPolygon(
                            $latitude,
                            $longitude,
                            $polygon
                        )
                    ) {
                        $inside = true;
                        break;
                    }
                }
            }

            if ($inside) {
                return $feature['properties']['namobj']
                    ?? $feature['properties']['wadmkk']
                    ?? null;
            }
        }

        return null;
    }
}