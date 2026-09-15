<?php

namespace App\Filament\Resources\LaporanWargas\Pages;

use App\Filament\Resources\LaporanWargas\LaporanWargaResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManageLaporanWargas extends ManageRecords
{
    protected static string $resource = LaporanWargaResource::class;
    protected function getHeaderActions(): array { return [CreateAction::make()]; }
}
