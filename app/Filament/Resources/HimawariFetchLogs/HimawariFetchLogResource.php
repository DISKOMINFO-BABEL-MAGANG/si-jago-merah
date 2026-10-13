<?php

namespace App\Filament\Resources\HimawariFetchLogs;

use App\Filament\Resources\HimawariFetchLogs\Pages\ListHimawariFetchLogs;
use App\Models\HimawariFetchLog;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use UnitEnum;

class HimawariFetchLogResource extends Resource
{
    protected static ?string $model = HimawariFetchLog::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $navigationLabel = 'Log Fetch Hotspot Himawari';

    protected static ?string $modelLabel = 'log fetch hotspot Himawari';

    protected static ?string $pluralModelLabel = 'log fetch hotspot Himawari';

    protected static string|UnitEnum|null $navigationGroup = 'Pemantauan';

    protected static ?int $navigationSort = 3;

    public static function table(Table $table): Table
    {
        return $table
            ->defaultSort('started_at', 'desc')
            ->columns([
                TextColumn::make('started_at')
                    ->label('Mulai')
                    ->dateTime('d M Y, H:i:s')
                    ->sortable(),
                TextColumn::make('observation_time')
                    ->label('Observasi Satelit')
                    ->dateTime('d M Y, H:i')
                    ->timezone('Asia/Jakarta')
                    ->suffix(' WIB')
                    ->placeholder('-')
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
                TextColumn::make('total_fetched')
                    ->label('Terdeteksi')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('total_saved')
                    ->label('Tersimpan')
                    ->numeric()
                    ->sortable(),
                TextColumn::make('total_updated')
                    ->label('Diperbarui')
                    ->numeric()
                    ->sortable(),
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
                    'running' => 'Sedang berjalan',
                ]),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => ListHimawariFetchLogs::route('/'),
        ];
    }
}
