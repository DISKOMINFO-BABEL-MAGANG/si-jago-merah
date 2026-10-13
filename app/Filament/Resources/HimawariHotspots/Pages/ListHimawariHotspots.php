<?php

namespace App\Filament\Resources\HimawariHotspots\Pages;

use App\Filament\Resources\HimawariHotspots\HimawariHotspotResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ListRecords;

class ListHimawariHotspots extends ListRecords
{
    protected static string $resource = HimawariHotspotResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),
        ];
    }
}
