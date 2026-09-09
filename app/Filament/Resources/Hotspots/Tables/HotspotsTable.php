<?php

namespace App\Filament\Resources\Hotspots\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\ViewAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class HotspotsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('latitude')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('longitude')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('source')
                    ->searchable(),
                TextColumn::make('region')
                    ->searchable(),
                TextColumn::make('bright_ti4')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('scan')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('track')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('acq_date')
                    ->date()
                    ->sortable(),
                TextColumn::make('acq_time')
                    ->searchable(),
                TextColumn::make('satellite')
                    ->searchable(),
                TextColumn::make('instrument')
                    ->searchable(),
                TextColumn::make('confidence')
                    ->searchable(),
                TextColumn::make('version')
                    ->searchable(),
                TextColumn::make('bright_ti5')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('frp')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('daynight')
                    ->searchable(),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('updated_at')
                    ->dateTime()
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
