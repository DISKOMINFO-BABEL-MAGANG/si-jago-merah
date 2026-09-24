<?php

namespace App\Filament\Resources\HotspotFetchLogs\Pages;

use App\Filament\Resources\HotspotFetchLogs\HotspotFetchLogResource;
use App\Filament\Resources\HotspotFetchLogs\Widgets\HotspotFetchCountdown;
use Filament\Resources\Pages\ListRecords;

class ListHotspotFetchLogs extends ListRecords
{
    protected static string $resource = HotspotFetchLogResource::class;

    protected function getHeaderWidgets(): array
    {
        return [
            HotspotFetchCountdown::class,
        ];
    }
}