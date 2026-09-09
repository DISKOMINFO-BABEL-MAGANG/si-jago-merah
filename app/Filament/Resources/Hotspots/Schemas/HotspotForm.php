<?php

namespace App\Filament\Resources\Hotspots\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class HotspotForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('latitude')
                    ->required()
                    ->numeric(),
                TextInput::make('longitude')
                    ->required()
                    ->numeric(),
                TextInput::make('source'),
                TextInput::make('region'),
                TextInput::make('bright_ti4')
                    ->numeric(),
                TextInput::make('scan')
                    ->numeric(),
                TextInput::make('track')
                    ->numeric(),
                DatePicker::make('acq_date'),
                TextInput::make('acq_time'),
                TextInput::make('satellite')
                    ->tel(),
                TextInput::make('instrument'),
                TextInput::make('confidence'),
                TextInput::make('version'),
                TextInput::make('bright_ti5')
                    ->numeric(),
                TextInput::make('frp')
                    ->numeric(),
                TextInput::make('daynight'),
            ]);
    }
}
