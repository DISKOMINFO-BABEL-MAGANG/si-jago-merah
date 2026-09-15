<?php

namespace App\Filament\Resources\Kejadians\Pages;

use App\Filament\Resources\Kejadians\KejadianResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManageKejadians extends ManageRecords
{
    protected static string $resource = KejadianResource::class;

    protected function getHeaderActions(): array
    {
        return [CreateAction::make()];
    }
}
