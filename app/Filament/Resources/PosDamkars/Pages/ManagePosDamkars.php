<?php

namespace App\Filament\Resources\PosDamkars\Pages;

use App\Filament\Resources\PosDamkars\PosDamkarResource;
use Filament\Actions\CreateAction;
use Filament\Resources\Pages\ManageRecords;

class ManagePosDamkars extends ManageRecords
{
    protected static string $resource = PosDamkarResource::class;
    protected function getHeaderActions(): array { return [CreateAction::make()]; }
}
