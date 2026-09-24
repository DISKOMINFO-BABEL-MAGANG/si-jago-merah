<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class FirmsService
{
    protected string $mapKey;

    public function __construct()
    {
        $this->mapKey = (string) config('services.firms.map_key');
    }

    public function fetchHotspots(
        string $source,
        string $area = 'world',
        int $days = 2,
        ?string $date = null
    ): array {
        if ($this->mapKey === '') {
            throw new \Exception('FIRMS map key kosong. Cek .env dan config/services.php.');
        }

        $url = "https://firms.modaps.eosdis.nasa.gov/api/area/csv/{$this->mapKey}/{$source}/{$area}/{$days}";

        if ($date !== null) {
            $url .= "/{$date}";
        }

        $response = Http::timeout(60)->get($url);

        if ($response->failed()) {
            throw new \Exception(
                "HTTP {$response->status()}: " . substr($response->body(), 0, 500)
            );
        }

        return $this->csvToArray($response->body());
    }

    protected function csvToArray(string $csv): array
    {
        // Hapus BOM jika ada
        $csv = preg_replace('/^\xEF\xBB\xBF/', '', trim($csv));

        if ($csv === '') {
            return [];
        }

        $lines = preg_split('/\r\n|\r|\n/', $csv);

        $headers = str_getcsv(array_shift($lines));

        // Respons valid harus punya kolom latitude & longitude.
        // Kalau tidak, kemungkinan itu pesan error dari FIRMS.
        if (!in_array('latitude', $headers, true)
            || !in_array('longitude', $headers, true)) {
            throw new \Exception(
                'Respons FIRMS bukan CSV valid: ' . substr($csv, 0, 500)
            );
        }

        $data = [];

        foreach ($lines as $line) {
            if (trim($line) === '') {
                continue;
            }

            $row = str_getcsv($line);

            if (count($row) !== count($headers)) {
                Log::warning('Baris CSV FIRMS dilewati (jumlah kolom berbeda)', [
                    'line' => $line,
                ]);
                continue;
            }

            $data[] = array_combine($headers, $row);
        }

        return $data;
    }
}