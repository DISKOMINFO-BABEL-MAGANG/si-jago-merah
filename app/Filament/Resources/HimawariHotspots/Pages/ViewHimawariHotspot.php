<?php

namespace App\Filament\Resources\HimawariHotspots\Pages;

use App\Filament\Resources\HimawariHotspots\HimawariHotspotResource;
use Filament\Actions\EditAction;
use Filament\Resources\Pages\ViewRecord;

class ViewHimawariHotspot extends ViewRecord
{
    protected static string $resource = HimawariHotspotResource::class;

    protected function getHeaderActions(): array
    {
        return [
            EditAction::make(),
        ];
    }
}
