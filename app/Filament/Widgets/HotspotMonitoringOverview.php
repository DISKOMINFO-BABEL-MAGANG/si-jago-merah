<?php

namespace App\Filament\Widgets;

use App\Models\Hotspot;
use App\Models\HotspotFetchLog;
use App\Models\Kejadian;
use App\Models\LaporanWarga;
use Filament\Widgets\StatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class HotspotMonitoringOverview extends StatsOverviewWidget
{
    protected ?string $heading = 'Ringkasan Pemantauan Hotspot';

    protected ?string $description = 'Pembaruan otomatis setiap 60 detik.';

    protected ?string $pollingInterval = '60s';

    protected function getStats(): array
    {
        $latestFetch = HotspotFetchLog::latest('started_at')->first();
        $today = now()->toDateString();

        return [
            Stat::make('Hotspot hari ini', Hotspot::whereDate('acq_date', $today)->count())
                ->description('Berdasarkan tanggal akuisisi')
                ->color('warning'),
            Stat::make('Total hotspot', Hotspot::count())
                ->description('Seluruh data tersimpan')
                ->color('primary'),
            Stat::make('Fetch terakhir', $latestFetch?->started_at?->diffForHumans() ?? 'Belum pernah')
                ->description($latestFetch ? "Status: {$latestFetch->status}" : 'Menunggu scheduler berjalan')
                ->color(match ($latestFetch?->status) {
                    'success' => 'success',
                    'partial' => 'warning',
                    'failed' => 'danger',
                    default => 'gray',
                }),
            Stat::make('Data tersimpan terakhir', $latestFetch?->total_saved ?? 0)
                ->description('Pada proses fetch terakhir')
                ->color('success'),
            Stat::make('Kejadian tercatat', Kejadian::count())
                ->description('Seluruh kejadian operasional')
                ->color('primary'),
            Stat::make('Laporan warga baru', LaporanWarga::where('status', 'baru')->count())
                ->description('Perlu diverifikasi atau ditindaklanjuti')
                ->color('warning'),
        ];
    }
}
