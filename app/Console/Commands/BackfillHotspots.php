<?php

namespace App\Console\Commands;

use App\Models\Hotspot;
use App\Services\FirmsService;
use App\Services\GeoService;
use Illuminate\Console\Command;

class BackfillHotspots extends Command
{
    protected $signature = 'hotspots:backfill {date}';

    protected $description = 'Mengambil ulang data hotspot NASA FIRMS untuk tanggal tertentu';

    public function handle(FirmsService $firms, GeoService $geo): int
    {
        $date = $this->argument('date');

        $this->info('======================================');
        $this->info('       NASA FIRMS HOTSPOT BACKFILL');
        $this->info("       Tanggal: {$date}");
        $this->info('======================================');

        $sources = [
            'MODIS_NRT',
            'VIIRS_SNPP_NRT',
            'VIIRS_NOAA20_NRT',
        ];

        $area = '105,-3.5,109,-1';

        $totalFetched = 0;
        $totalSaved = 0;
        $totalDuplicate = 0;
        $totalOutside = 0;

        foreach ($sources as $source) {
            $this->newLine();
            $this->info("Mengambil data: {$source}");

            try {
                $hotspots = $firms->fetchHotspots(
                    source: $source,
                    area: $area,
                    days: 1,
                    date: $date
                );

                $this->info("Data diterima: " . count($hotspots));

                $totalFetched += count($hotspots);

                foreach ($hotspots as $hotspot) {
                    $latitude = (float) ($hotspot['latitude'] ?? 0);
                    $longitude = (float) ($hotspot['longitude'] ?? 0);

                    if (!$geo->isInsideBangkaBelitung($latitude, $longitude)) {
                        $totalOutside++;
                        continue;
                    }

                    $region = $geo->getRegion($latitude, $longitude);

                    $exists = Hotspot::where('latitude', $latitude)
                        ->where('longitude', $longitude)
                        ->where('acq_date', $hotspot['acq_date'] ?? null)
                        ->where('acq_time', $hotspot['acq_time'] ?? null)
                        ->where('source', $source)
                        ->exists();

                    if ($exists) {
                        $totalDuplicate++;
                        continue;
                    }

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

                    $totalSaved++;
                }

                $this->info("Selesai: {$source}");

            } catch (\Throwable $e) {
                $this->error(
                    "Gagal mengambil {$source}: {$e->getMessage()}"
                );
            }
        }

        $this->newLine();
        $this->info('======================================');
        $this->info('              SELESAI');
        $this->info('======================================');
        $this->info("Total data diterima      : {$totalFetched}");
        $this->info("Total data disimpan      : {$totalSaved}");
        $this->info("Total duplikat dilewati  : {$totalDuplicate}");
        $this->info("Total di luar Babel      : {$totalOutside}");

        return self::SUCCESS;
    }
}