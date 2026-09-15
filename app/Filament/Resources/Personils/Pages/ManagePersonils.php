<?php

namespace App\Filament\Resources\Personils\Pages;

use App\Filament\Resources\Personils\PersonilResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManagePersonils extends ManageRecords
{
    protected static string $resource = PersonilResource::class;
    protected function getHeaderActions(): array { return [CreateAction::make()]; }
}
