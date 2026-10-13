<?php

namespace App\Filament\Resources\HimawariFetchLogs\Pages;

use App\Filament\Resources\HimawariFetchLogs\HimawariFetchLogResource;
use App\Filament\Resources\HimawariFetchLogs\Widgets\HimawariFetchCountdown;
use Filament\Resources\Pages\ListRecords;

class ListHimawariFetchLogs extends ListRecords
{
    protected static string $resource = HimawariFetchLogResource::class;

    protected function getHeaderWidgets(): array
    {
        return [
            HimawariFetchCountdown::class,
        ];
    }
}
