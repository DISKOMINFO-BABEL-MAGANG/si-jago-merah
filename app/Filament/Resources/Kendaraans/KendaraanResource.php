<?php

namespace App\Filament\Resources\Kendaraans;

use App\Filament\Resources\Kendaraans\Pages\ManageKendaraans;
use App\Models\Kendaraan;
use BackedEnum;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use UnitEnum;

class KendaraanResource extends Resource
{
    protected static ?string $model = Kendaraan::class;
    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
    protected static ?string $navigationLabel = 'Kendaraan';
    protected static string|UnitEnum|null $navigationGroup = 'Sumber Daya';
    protected static ?int $navigationSort = 3;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            TextInput::make('no_lambung'), TextInput::make('plat_nomor'), TextInput::make('jenis'),
            Select::make('status')->options(['siap' => 'Siap', 'perbaikan' => 'Perbaikan', 'rusak' => 'Rusak'])->required()->default('siap'),
            Select::make('pos_id')->relationship('pos', 'nama_pos')->searchable()->preload()->label('Pos damkar'),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->columns([
            TextColumn::make('no_lambung')->label('No. lambung')->placeholder('-')->searchable(), TextColumn::make('plat_nomor')->label('Plat nomor')->placeholder('-')->searchable(), TextColumn::make('jenis')->placeholder('-'),
            TextColumn::make('pos.nama_pos')->label('Pos')->placeholder('-'),
            TextColumn::make('status')->badge()->color(fn (string $state) => match ($state) {'siap' => 'success', 'perbaikan' => 'warning', default => 'danger'}),
        ])->filters([SelectFilter::make('status')->options(['siap' => 'Siap', 'perbaikan' => 'Perbaikan', 'rusak' => 'Rusak'])])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array { return ['index' => ManageKendaraans::route('/')]; }
}
