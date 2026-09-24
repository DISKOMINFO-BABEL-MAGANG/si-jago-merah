<?php

namespace App\Console\Commands;

use App\Models\Hotspot;
use App\Models\HotspotFetchLog;
use App\Services\FirmsService;
use App\Services\GeoService;
use Carbon\Carbon;
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
         * Format: west,south,east,north
         */
        $area = '105,-3.5,109,-1';

        /*
         * Batas waktu 24 jam terakhir (dalam UTC, sama dengan
         * acq_date & acq_time dari FIRMS).
         */
        $cutoff = now('UTC')->subHours(24);

        $this->info(
            'Mengambil deteksi sejak: '
            . $cutoff->copy()->setTimezone('Asia/Jakarta')->format('Y-m-d H:i')
            . ' WIB'
        );

        /*
         * Statistik keseluruhan.
         */
        $totalFetched = 0;
        $totalRecent = 0;
        $totalFiltered = 0;
        $totalSaved = 0;
        $totalDuplicate = 0;
        $totalOutside = 0;
        $failedSources = [];

        $fetchLog = HotspotFetchLog::create([
            'status' => 'running',
            'started_at' => now(),
        ]);

        foreach ($sources as $source) {

            $this->newLine();
            $this->info("Mengambil data: {$source}");

            $sourceSaved = 0;
            $sourceDuplicate = 0;
            $sourceOutside = 0;

            try {

                /*
                 * days: 2 supaya deteksi dari tanggal UTC kemarin
                 * tetap ikut terambil. Nanti difilter ke 24 jam
                 * terakhir di bawah.
                 */
                $hotspots = $firms->fetchHotspots(
                    source: $source,
                    area: $area,
                    days: 2
                );

                $fetched = count($hotspots);
                $totalFetched += $fetched;

                $this->info("Data diterima: {$fetched}");

                /*
                 * Filter 24 jam terakhir.
                 */
                $hotspots = array_filter(
                    $hotspots,
                    function ($hotspot) use ($cutoff) {

                        $acquiredAt = $this->parseAcquiredAt($hotspot);

                        return $acquiredAt !== null
                            && $acquiredAt->greaterThanOrEqualTo($cutoff);
                    }
                );

                $recent = count($hotspots);
                $totalRecent += $recent;

                $this->info("Data dalam 24 jam terakhir: {$recent}");

                /*
                 * Filter berdasarkan bounding box.
                 */
                $hotspots = array_filter(
                    $hotspots,
                    function ($hotspot) {

                        if (!isset($hotspot['latitude'], $hotspot['longitude'])) {
                            return false;
                        }

                        $latitude = (float) $hotspot['latitude'];
                        $longitude = (float) $hotspot['longitude'];

                        return $latitude >= -3.5
                            && $latitude <= -1.0
                            && $longitude >= 105.0
                            && $longitude <= 109.0;
                    }
                );

                $filtered = count($hotspots);
                $totalFiltered += $filtered;

                $this->info("Data setelah filter bounding box: {$filtered}");

                /*
                 * Proses setiap hotspot.
                 */
                foreach ($hotspots as $hotspot) {

                    $latitude = (float) $hotspot['latitude'];
                    $longitude = (float) $hotspot['longitude'];

                    /*
                     * Pastikan titik berada di dalam
                     * polygon wilayah Bangka Belitung.
                     */
                    if (!$geo->isInsideBangkaBelitung($latitude, $longitude)) {

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
                    $region = $geo->getRegion($latitude, $longitude);

                    /*
                     * Cek duplikat:
                     * latitude, longitude, tanggal, waktu, source.
                     */
                    $exists = Hotspot::where('latitude', $latitude)
                        ->where('longitude', $longitude)
                        ->where('acq_date', $hotspot['acq_date'] ?? null)
                        ->where('acq_time', $hotspot['acq_time'] ?? null)
                        ->where('source', $source)
                        ->exists();

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

                        'bright_ti4' => $hotspot['bright_ti4'] ?? null,
                        'scan' => $hotspot['scan'] ?? null,
                        'track' => $hotspot['track'] ?? null,

                        'acq_date' => $hotspot['acq_date'] ?? null,
                        'acq_time' => $hotspot['acq_time'] ?? null,

                        'satellite' => $hotspot['satellite'] ?? null,
                        'instrument' => $hotspot['instrument'] ?? null,
                        'confidence' => $hotspot['confidence'] ?? null,
                        'version' => $hotspot['version'] ?? null,

                        'bright_ti5' => $hotspot['bright_ti5'] ?? null,
                        'frp' => $hotspot['frp'] ?? null,
                        'daynight' => $hotspot['daynight'] ?? null,
                    ]);

                    $sourceSaved++;
                    $totalSaved++;

                    $this->line("  ✓ {$latitude}, {$longitude} → {$region}");
                }

                /*
                 * Ringkasan source.
                 */
                $this->info("Data baru disimpan: {$sourceSaved}");
                $this->info("Duplikat dilewati: {$sourceDuplicate}");
                $this->info("Di luar wilayah Babel: {$sourceOutside}");

            } catch (\Throwable $e) {

                $failedSources[$source] = substr($e->getMessage(), 0, 1000);

                $this->error("Gagal mengambil {$source}: {$e->getMessage()}");

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

        $this->info("Total data diterima      : {$totalFetched}");
        $this->info("Total dalam 24 jam       : {$totalRecent}");
        $this->info("Total setelah bbox       : {$totalFiltered}");
        $this->info("Total data disimpan      : {$totalSaved}");
        $this->info("Total duplikat dilewati  : {$totalDuplicate}");
        $this->info("Total di luar Babel      : {$totalOutside}");

        $status = count($failedSources) === count($sources)
            ? 'failed'
            : (count($failedSources) > 0 ? 'partial' : 'success');

        $fetchLog->update([
            'status' => $status,
            'total_fetched' => $totalFetched,
            'total_filtered' => $totalFiltered,
            'total_saved' => $totalSaved,
            'total_duplicates' => $totalDuplicate,
            'total_outside_area' => $totalOutside,
            'source_errors' => $failedSources ?: null,
            'message' => $status === 'success'
                ? 'Fetch hotspot selesai.'
                : 'Ada sumber data yang gagal diproses.',
            'finished_at' => now(),
        ]);

        return $status === 'failed'
            ? self::FAILURE
            : self::SUCCESS;
    }

    /**
     * Gabungkan acq_date (Y-m-d) dan acq_time (mis. "553" = 05:53)
     * menjadi objek Carbon dalam UTC.
     */
    protected function parseAcquiredAt(array $hotspot): ?Carbon
    {
        $date = $hotspot['acq_date'] ?? null;

        if (!$date) {
            return null;
        }

        $time = str_pad((string) ($hotspot['acq_time'] ?? '0'), 4, '0', STR_PAD_LEFT);

        try {
            return Carbon::createFromFormat('Y-m-d Hi', "{$date} {$time}", 'UTC');
        } catch (\Throwable $e) {
            return null;
        }
    }
}