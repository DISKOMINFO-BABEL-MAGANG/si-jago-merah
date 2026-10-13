<?php

namespace App\Filament\Resources\HimawariHotspots\Pages;

use App\Filament\Resources\HimawariHotspots\HimawariHotspotResource;
use Filament\Actions\DeleteAction;
use Filament\Actions\ViewAction;
use Filament\Resources\Pages\EditRecord;

class EditHimawariHotspot extends EditRecord
{
    protected static string $resource = HimawariHotspotResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ViewAction::make(),
            DeleteAction::make(),
        ];
    }
}
