<?php

namespace App\Filament\Resources\HimawariHotspots\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Support\Enums\FontWeight;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class HimawariHotspotsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('acq_date')
                    ->label('Tanggal')
                    ->date('d M Y')
                    ->sortable(),

                TextColumn::make('acq_time')
                    ->label('Waktu UTC')
                    ->sortable(),

                TextColumn::make('latitude')
                    ->label('Latitude')
                    ->numeric(decimalPlaces: 6)
                    ->sortable(),

                TextColumn::make('longitude')
                    ->label('Longitude')
                    ->numeric(decimalPlaces: 6)
                    ->sortable(),

                TextColumn::make('bt07')
                    ->label('BT07')
                    ->numeric(decimalPlaces: 2)
                    ->suffix(' K')
                    ->sortable(),

                TextColumn::make('bt14')
                    ->label('BT14')
                    ->numeric(decimalPlaces: 2)
                    ->suffix(' K')
                    ->sortable(),

                TextColumn::make('bt_difference')
                    ->label('Selisih BT')
                    ->numeric(decimalPlaces: 2)
                    ->suffix(' K')
                    ->sortable()
                    ->weight(FontWeight::Bold),

                TextColumn::make('pixel_count')
                    ->label('Pixel')
                    ->numeric()
                    ->sortable(),

                TextColumn::make('region')
                    ->label('Wilayah')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('satellite')
                    ->label('Satelit')
                    ->badge(),

                TextColumn::make('instrument')
                    ->label('Instrumen')
                    ->badge(),

                TextColumn::make('source')
                    ->label('Sumber')
                    ->badge()
                    ->searchable(),

                TextColumn::make('created_at')
                    ->label('Dibuat')
                    ->dateTime('d M Y H:i')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),

                TextColumn::make('updated_at')
                    ->label('Diperbarui')
                    ->dateTime('d M Y H:i')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->recordActions([
                ViewAction::make(),
                EditAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }
}