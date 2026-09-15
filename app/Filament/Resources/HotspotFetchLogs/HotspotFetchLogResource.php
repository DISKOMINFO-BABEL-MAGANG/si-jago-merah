<?php

namespace App\Filament\Resources\HotspotFetchLogs;

use App\Filament\Resources\HotspotFetchLogs\Pages\ListHotspotFetchLogs;
use App\Models\HotspotFetchLog;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use UnitEnum;

class HotspotFetchLogResource extends Resource
{
    protected static ?string $model = HotspotFetchLog::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $navigationLabel = 'Log Fetch Hotspot';

    protected static ?string $modelLabel = 'log fetch hotspot';

    protected static ?string $pluralModelLabel = 'log fetch hotspot';

    protected static string|UnitEnum|null $navigationGroup = 'Pemantauan';

    protected static ?int $navigationSort = 2;

    public static function table(Table $table): Table
    {
        return $table
            ->defaultSort('started_at', 'desc')
            ->columns([
                TextColumn::make('started_at')
                    ->label('Mulai')
                    ->dateTime('d M Y, H:i:s')
                    ->sortable(),
                TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'success' => 'success',
                        'partial' => 'warning',
                        'failed' => 'danger',
                        default => 'gray',
                    }),
                TextColumn::make('total_fetched')->label('Diterima')->numeric(),
                TextColumn::make('total_saved')->label('Tersimpan')->numeric(),
                TextColumn::make('total_duplicates')->label('Duplikat')->numeric(),
                TextColumn::make('total_outside_area')->label('Di luar area')->numeric(),
                TextColumn::make('finished_at')
                    ->label('Selesai')
                    ->dateTime('d M Y, H:i:s')
                    ->placeholder('-')
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('message')
                    ->label('Keterangan')
                    ->limit(70)
                    ->tooltip(fn (?string $state): ?string => $state)
                    ->placeholder('-'),
            ])
            ->filters([
                SelectFilter::make('status')->options([
                    'success' => 'Berhasil',
                    'partial' => 'Sebagian berhasil',
                    'failed' => 'Gagal',
                ]),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => ListHotspotFetchLogs::route('/'),
        ];
    }
}
