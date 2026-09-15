<?php

namespace App\Filament\Resources\KegiatanEdukasis\Pages;

use App\Filament\Resources\KegiatanEdukasis\KegiatanEdukasiResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManageKegiatanEdukasis extends ManageRecords
{
    protected static string $resource = KegiatanEdukasiResource::class;
    protected function getHeaderActions(): array { return [CreateAction::make()]; }
}
