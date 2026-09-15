<?php

namespace App\Filament\Resources\PendaftaranEdukasis\Pages;

use App\Filament\Resources\PendaftaranEdukasis\PendaftaranEdukasiResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManagePendaftaranEdukasis extends ManageRecords
{
    protected static string $resource = PendaftaranEdukasiResource::class;
    protected function getHeaderActions(): array { return [CreateAction::make()]; }
}
