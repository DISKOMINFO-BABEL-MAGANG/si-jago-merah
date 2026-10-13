<?php

namespace App\Console\Commands;

use App\Models\HimawariHotspot;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class ImportHimawariHotspots extends Command
{
    protected $signature = 'himawari:import';

    protected $description = 'Mengimpor data hotspot Himawari dari file JSON';

    public function handle(): int
    {
        $path = base_path('himawari/output/himawari_hotspots.json');

        if (!File::exists($path)) {
            $this->error('File JSON Himawari tidak ditemukan:');
            $this->line($path);

            return self::FAILURE;
        }

        $json = File::get($path);
        $data = json_decode($json, true);

        if (!is_array($data)) {
            $this->error('Format JSON Himawari tidak valid.');

            return self::FAILURE;
        }

        $saved = 0;
        $updated = 0;

        foreach ($data as $hotspot) {
            if (
                !isset(
                    $hotspot['latitude'],
                    $hotspot['longitude'],
                    $hotspot['acq_date'],
                    $hotspot['acq_time']
                )
            ) {
                $this->warn('Data hotspot tidak lengkap, dilewati.');
                continue;
            }

            $record = HimawariHotspot::updateOrCreate(
                [
                    'latitude' => $hotspot['latitude'],
                    'longitude' => $hotspot['longitude'],
                    'acq_date' => $hotspot['acq_date'],
                    'acq_time' => $hotspot['acq_time'],
                    'source' => $hotspot['source'] ?? 'HIMAWARI9',
                ],
                [
                    'satellite' => $hotspot['satellite'] ?? 'H09',
                    'instrument' => $hotspot['instrument'] ?? 'AHI',
                    'bt07' => $hotspot['bt07'],
                    'bt14' => $hotspot['bt14'],
                    'bt_difference' => $hotspot['bt_difference'],
                    'pixel_count' => $hotspot['pixel_count'] ?? 1,
                    'region' => $hotspot['region'] ?? null,
                ]
            );

            if ($record->wasRecentlyCreated) {
                $saved++;
            } else {
                $updated++;
            }
        }

        $this->info('Import Himawari selesai.');
        $this->line("Data baru    : {$saved}");
        $this->line("Data diperbarui: {$updated}");
        $this->line("Total JSON   : " . count($data));

        return self::SUCCESS;
    }
}