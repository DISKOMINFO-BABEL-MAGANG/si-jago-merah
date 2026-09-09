<?php

namespace App\Console\Commands;

use App\Models\Hotspot;
use App\Services\FirmsService;
use App\Services\GeoService;
use Illuminate\Console\Command;

class FetchHotspots extends Command
{
    protected $signature = 'hotspots:fetch';

    protected $description = 'Mengambil data hotspot dari MODIS, SNPP, dan NOAA-20';

    public function handle(FirmsService $firms, GeoService $geo): int
    {
        $this->info('======================================');
        $this->info('     NASA FIRMS HOTSPOT FETCHER');
        $this->info('======================================');

        /*
         * Sumber data NASA FIRMS.
         */
        $sources = [
            'MODIS_NRT',
            'VIIRS_SNPP_NRT',
            'VIIRS_NOAA20_NRT',
        ];

        /*
         * Bounding box Kepulauan Bangka Belitung.
         *
         * Format:
         * west,south,east,north
         */
        $area = '105,-3.5,109,-1';

        /*
         * Statistik keseluruhan.
         */
        $totalFetched = 0;
        $totalFiltered = 0;
        $totalSaved = 0;
        $totalDuplicate = 0;
        $totalOutside = 0;

        foreach ($sources as $source) {

            $this->newLine();
            $this->info("Mengambil data: {$source}");

            /*
             * Statistik per source.
             */
            $sourceSaved = 0;
            $sourceDuplicate = 0;
            $sourceOutside = 0;

            try {

                /*
                 * Ambil data dari NASA FIRMS.
                 *
                 * Untuk sekarang mengambil data terbaru.
                 * Nanti akan kita ubah agar bisa berdasarkan tanggal.
                 */
                $hotspots = $firms->fetchHotspots(
                    source: $source,
                    area: $area,
                    days: 1
                );

                $fetched = count($hotspots);

                $totalFetched += $fetched;

                $this->info("Data diterima: {$fetched}");

                /*
                 * Filter berdasarkan bounding box.
                 */
                $hotspots = array_filter(
                    $hotspots,
                    function ($hotspot) {

                        $latitude = (float) ($hotspot['latitude'] ?? 0);
                        $longitude = (float) ($hotspot['longitude'] ?? 0);

                        return $latitude >= -3.5
                            && $latitude <= -1.0
                            && $longitude >= 105.0
                            && $longitude <= 109.0;
                    }
                );

                $filtered = count($hotspots);

                $totalFiltered += $filtered;

                $this->info(
                    "Data setelah filter: {$filtered}"
                );

                /*
                 * Proses setiap hotspot.
                 */
                foreach ($hotspots as $hotspot) {

                    $latitude = (float) ($hotspot['latitude'] ?? 0);
                    $longitude = (float) ($hotspot['longitude'] ?? 0);

                    /*
                     * Pastikan titik berada di dalam
                     * polygon wilayah Bangka Belitung.
                     */
                    if (!$geo->isInsideBangkaBelitung(
                        $latitude,
                        $longitude
                    )) {

                        $sourceOutside++;
                        $totalOutside++;

                        $this->line(
                            "  ↳ Skip luar Babel: {$latitude}, {$longitude}"
                        );

                        continue;
                    }

                    /*
                     * Tentukan kabupaten/kota.
                     */
                    $region = $geo->getRegion(
                        $latitude,
                        $longitude
                    );

                    /*
                     * Cek apakah deteksi hotspot ini
                     * sudah tersimpan sebelumnya.
                     *
                     * Kombinasi:
                     * latitude
                     * longitude
                     * tanggal akuisisi
                     * waktu akuisisi
                     * source
                     */
                    $exists = Hotspot::where('latitude', $latitude)
                        ->where('longitude', $longitude)
                        ->where(
                            'acq_date',
                            $hotspot['acq_date'] ?? null
                        )
                        ->where(
                            'acq_time',
                            $hotspot['acq_time'] ?? null
                        )
                        ->where('source', $source)
                        ->exists();

                    /*
                     * Jika sudah ada → jangan simpan lagi.
                     */
                    if ($exists) {

                        $sourceDuplicate++;
                        $totalDuplicate++;

                        $this->line(
                            "  ↳ Skip duplikat: {$latitude}, {$longitude} → {$region}"
                        );

                        continue;
                    }

                    /*
                     * Simpan hotspot baru.
                     */
                    Hotspot::create([

                        'latitude' => $latitude,
                        'longitude' => $longitude,

                        'source' => $source,
                        'region' => $region,

                        'bright_ti4' =>
                            $hotspot['bright_ti4'] ?? null,

                        'scan' =>
                            $hotspot['scan'] ?? null,

                        'track' =>
                            $hotspot['track'] ?? null,

                        'acq_date' =>
                            $hotspot['acq_date'] ?? null,

                        'acq_time' =>
                            $hotspot['acq_time'] ?? null,

                        'satellite' =>
                            $hotspot['satellite'] ?? null,

                        'instrument' =>
                            $hotspot['instrument'] ?? null,

                        'confidence' =>
                            $hotspot['confidence'] ?? null,

                        'version' =>
                            $hotspot['version'] ?? null,

                        'bright_ti5' =>
                            $hotspot['bright_ti5'] ?? null,

                        'frp' =>
                            $hotspot['frp'] ?? null,

                        'daynight' =>
                            $hotspot['daynight'] ?? null,
                    ]);

                    $sourceSaved++;
                    $totalSaved++;

                    $this->line(
                        "  ✓ {$latitude}, {$longitude} → {$region}"
                    );
                }

                /*
                 * Ringkasan source.
                 */
                $this->info(
                    "Data baru disimpan: {$sourceSaved}"
                );

                $this->info(
                    "Duplikat dilewati: {$sourceDuplicate}"
                );

                $this->info(
                    "Di luar wilayah Babel: {$sourceOutside}"
                );

            } catch (\Throwable $e) {

                $this->error(
                    "Gagal mengambil {$source}: {$e->getMessage()}"
                );

                /*
                 * Jika satu source gagal,
                 * source lainnya tetap diproses.
                 */
                continue;
            }
        }

        /*
         * Ringkasan keseluruhan.
         */
        $this->newLine();

        $this->info('======================================');
        $this->info('             SELESAI');
        $this->info('======================================');

        $this->info(
            "Total data diterima      : {$totalFetched}"
        );

        $this->info(
            "Total data difilter      : {$totalFiltered}"
        );

        $this->info(
            "Total data disimpan      : {$totalSaved}"
        );

        $this->info(
            "Total duplikat dilewati  : {$totalDuplicate}"
        );

        $this->info(
            "Total di luar Babel      : {$totalOutside}"
        );

        return self::SUCCESS;
    }
}