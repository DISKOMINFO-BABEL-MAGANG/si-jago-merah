<?php

namespace App\Filament\Resources\HimawariHotspots\Schemas;

use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Filament\Schemas\Schema;

class HimawariHotspotForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('latitude')
                    ->label('Latitude')
                    ->required()
                    ->numeric(),

                TextInput::make('longitude')
                    ->label('Longitude')
                    ->required()
                    ->numeric(),

                TextInput::make('source')
                    ->label('Sumber')
                    ->required()
                    ->default('HIMAWARI9'),

                TextInput::make('satellite')
                    ->label('Satelit')
                    ->required()
                    ->default('H09'),

                TextInput::make('instrument')
                    ->label('Instrumen')
                    ->required()
                    ->default('AHI'),

                DatePicker::make('acq_date')
                    ->label('Tanggal Observasi')
                    ->required(),

                TextInput::make('acq_time')
                    ->label('Waktu Observasi (UTC)')
                    ->required()
                    ->maxLength(4)
                    ->placeholder('1000'),

                TextInput::make('bt07')
                    ->label('BT07 (K)')
                    ->required()
                    ->numeric(),

                TextInput::make('bt14')
                    ->label('BT14 (K)')
                    ->required()
                    ->numeric(),

                TextInput::make('bt_difference')
                    ->label('Selisih BT07 - BT14 (K)')
                    ->required()
                    ->numeric(),

                TextInput::make('pixel_count')
                    ->label('Jumlah Pixel')
                    ->required()
                    ->numeric()
                    ->integer()
                    ->default(1)
                    ->minValue(1),

                TextInput::make('region')
                    ->label('Wilayah')
                    ->nullable(),
            ]);
    }
}