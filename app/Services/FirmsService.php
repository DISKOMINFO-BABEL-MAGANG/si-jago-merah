<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class FirmsService
{
    protected string $mapKey;

    public function __construct()
    {
        $this->mapKey = config('services.firms.map_key');
    }

    public function fetchHotspots(
        string $source,
        string $area = 'world',
        int $days = 1,
        ?string $date = null
    ): array {
        $url = "https://firms.modaps.eosdis.nasa.gov/api/area/csv/{$this->mapKey}/{$source}/{$area}/{$days}";

if ($date !== null) {
    $url .= "/{$date}";
}

        $response = Http::timeout(60)->get($url);

        if ($response->failed()) {
            throw new \Exception(
                'Gagal mengambil data NASA FIRMS: ' . $response->body()
            );
        }

        return $this->csvToArray($response->body());
    }

    protected function csvToArray(string $csv): array
    {
        $lines = preg_split('/\r\n|\r|\n/', trim($csv));

        if (empty($lines)) {
            return [];
        }

        $headers = str_getcsv(array_shift($lines));

        $data = [];

        foreach ($lines as $line) {
            if (trim($line) === '') {
                continue;
            }

            $row = str_getcsv($line);

            if (count($row) !== count($headers)) {
                continue;
            }

            $data[] = array_combine($headers, $row);
        }

        return $data;
    }
}