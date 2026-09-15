<?php

namespace App\Filament\Resources\InstansiBantuans\Pages;

use App\Filament\Resources\InstansiBantuans\InstansiBantuanResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManageInstansiBantuans extends ManageRecords
{
    protected static string $resource = InstansiBantuanResource::class;
    protected function getHeaderActions(): array { return [CreateAction::make()]; }
}
