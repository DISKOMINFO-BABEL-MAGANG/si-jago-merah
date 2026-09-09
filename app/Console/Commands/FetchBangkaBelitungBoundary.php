<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;

class FetchBangkaBelitungBoundary extends Command
{
    protected $signature = 'gis:fetch-boundary';

    protected $description = 'Mengambil batas administrasi kabupaten/kota Provinsi Kepulauan Bangka Belitung dari BIG';

    public function handle(): int
    {
        $this->info('Mengambil boundary Kepulauan Bangka Belitung dari BIG...');

        $url = 'https://geoservices.big.go.id/rbi/rest/services/BATASWILAYAH/BATAS_WILAYAH/MapServer/12/query';

        $response = Http::timeout(60)->get($url, [
            'where' => "wadmpr='Kepulauan Bangka Belitung'",
            'outFields' => '*',
            'returnGeometry' => 'true',
            'outSR' => '4326',
            'f' => 'geojson',
            'resultRecordCount' => 1000,
        ]);

        if ($response->failed()) {
            $this->error('Gagal mengambil boundary dari BIG.');
            $this->error($response->body());

            return self::FAILURE;
        }

        $geojson = $response->json();

        $featureCount = count($geojson['features'] ?? []);

        if ($featureCount === 0) {
            $this->error('Tidak ditemukan polygon Kepulauan Bangka Belitung.');

            return self::FAILURE;
        }

        Storage::disk('local')->put(
            'geo/bangka-belitung.geojson',
            json_encode(
                $geojson,
                JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE
            )
        );

        $this->info(
            "Berhasil mendapatkan {$featureCount} polygon wilayah Babel."
        );

        $this->info(
            'GeoJSON disimpan di: storage/app/private/geo/bangka-belitung.geojson'
        );

        return self::SUCCESS;
    }
}