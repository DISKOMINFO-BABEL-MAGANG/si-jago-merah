<?php

namespace App\Filament\Resources\Hotspots\Pages;

use App\Filament\Resources\Hotspots\HotspotResource;
use App\Filament\Imports\HotspotImporter;
use Filament\Actions\CreateAction;
use Filament\Actions\ImportAction;
use Filament\Resources\Pages\ListRecords;

class ListHotspots extends ListRecords
{
    protected static string $resource = HotspotResource::class;

    protected function getHeaderActions(): array
    {
        return [
            ImportAction::make('importSIPONGI')
                ->label('Import SIPONGI')
                ->importer(HotspotImporter::class),

            CreateAction::make(),
        ];
    }
}