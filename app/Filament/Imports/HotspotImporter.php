<?php

namespace App\Filament\Imports;

use App\Models\Hotspot;
use Carbon\Carbon;
use Filament\Actions\Imports\ImportColumn;
use Filament\Actions\Imports\Importer;
use Filament\Actions\Imports\Models\Import;
use Illuminate\Support\Number;

class HotspotImporter extends Importer
{
    protected static ?string $model = Hotspot::class;

    public static function getColumns(): array
    {
        return [
            ImportColumn::make('latitude')
                ->label('Latitude')
                ->requiredMapping()
                ->rules([
                    'required',
                ]),

            ImportColumn::make('longitude')
                ->label('Longitude')
                ->requiredMapping()
                ->rules([
                    'required',
                ]),

            ImportColumn::make('region')
                ->label('Kab Kota')
                ->requiredMapping()
                ->rules([
                    'required',
                    'string',
                ]),

            ImportColumn::make('acq_date')
                ->label('Tanggal')
                ->requiredMapping()
                ->rules([
                    'required',
                ]),

            ImportColumn::make('acq_time')
                ->label('Waktu')
                ->requiredMapping()
                ->rules([
                    'required',
                ]),

            ImportColumn::make('satellite')
                ->label('Satelit')
                ->requiredMapping()
                ->rules([
                    'required',
                    'string',
                ]),

            ImportColumn::make('confidence')
                ->label('Confidence')
                ->requiredMapping()
                ->rules([
                    'required',
                ]),
        ];
    }

    public function resolveRecord(): Hotspot
    {
        $record = new Hotspot();

        $record->source = 'SIPONGI';

        return $record;
    }

    protected function beforeFill(): void
    {
        /*
         * ==========================================================
         * 1. NORMALISASI LATITUDE
         * ==========================================================
         *
         * SIPONGI menggunakan koma sebagai pemisah desimal.
         *
         * Contoh:
         * -2,08946
         *
         * Menjadi:
         * -2.08946
         */

        if ($this->data['latitude'] ?? null) {
            $this->data['latitude'] = str_replace(
                ',',
                '.',
                trim((string) $this->data['latitude'])
            );
        }

        /*
         * ==========================================================
         * 2. NORMALISASI LONGITUDE
         * ==========================================================
         *
         * Contoh:
         * 106,07045
         *
         * Menjadi:
         * 106.07045
         */

        if ($this->data['longitude'] ?? null) {
            $this->data['longitude'] = str_replace(
                ',',
                '.',
                trim((string) $this->data['longitude'])
            );
        }

        /*
         * ==========================================================
         * 3. NORMALISASI TANGGAL
         * ==========================================================
         *
         * Format SIPONGI:
         * 06-09-2026
         *
         * Database:
         * 2026-09-06
         */

        if ($this->data['acq_date'] ?? null) {
            try {
                $date = trim((string) $this->data['acq_date']);

                $this->data['acq_date'] = Carbon::createFromFormat(
                    'd-m-Y',
                    $date
                )->format('Y-m-d');
            } catch (\Throwable) {
                // Validation akan menangani data tanggal yang tidak valid.
            }
        }

        /*
         * ==========================================================
         * 4. NORMALISASI WAKTU
         * ==========================================================
         *
         * Format SIPONGI:
         * 13:12 WIB
         *
         * Database:
         * 1312
         */

        if ($this->data['acq_time'] ?? null) {
            $time = trim((string) $this->data['acq_time']);

            // Hapus tulisan WIB.
            $time = preg_replace(
                '/\s*WIB\s*/i',
                '',
                $time
            );

            if (
                preg_match(
                    '/^(\d{1,2}):(\d{2})$/',
                    $time,
                    $matches
                )
            ) {
                $hour = str_pad(
                    $matches[1],
                    2,
                    '0',
                    STR_PAD_LEFT
                );

                $minute = $matches[2];

                $this->data['acq_time'] = $hour . $minute;
            }
        }

        /*
         * ==========================================================
         * 5. NORMALISASI CONFIDENCE
         * ==========================================================
         *
         * SIPONGI:
         * Low
         * Medium
         * High
         *
         * Database hotspot:
         * numeric
         *
         * Konversi:
         * Low    = 30
         * Medium = 65
         * High   = 90
         */

        if ($this->data['confidence'] ?? null) {
            $confidence = strtolower(
                trim((string) $this->data['confidence'])
            );

            $this->data['confidence'] = match ($confidence) {
                'low' => 30,
                'medium' => 65,
                'high' => 90,

                default => is_numeric($confidence)
                    ? (int) $confidence
                    : null,
            };
        }
    }

    public static function getCompletedNotificationBody(
        Import $import
    ): string {
        $body = 'Import hotspot SIPONGI selesai. '
            . Number::format($import->successful_rows)
            . ' '
            . str('data')->plural($import->successful_rows)
            . ' berhasil diimport.';

        if ($failedRowsCount = $import->getFailedRowsCount()) {
            $body .= ' '
                . Number::format($failedRowsCount)
                . ' '
                . str('data')->plural($failedRowsCount)
                . ' gagal diimport.';
        }

        return $body;
    }
}