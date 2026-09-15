<?php

namespace App\Filament\Resources\PosDamkars;

use App\Filament\Resources\PosDamkars\Pages\ManagePosDamkars;
use App\Models\PosDamkar;
use BackedEnum;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\TextInput;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use UnitEnum;

class PosDamkarResource extends Resource
{
    protected static ?string $model = PosDamkar::class;
    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
    protected static ?string $navigationLabel = 'Pos Damkar';
    protected static string|UnitEnum|null $navigationGroup = 'Sumber Daya';
    protected static ?int $navigationSort = 1;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            TextInput::make('nama_pos')->required(), TextInput::make('no_telepon')->tel(),
            TextInput::make('alamat')->columnSpanFull(), TextInput::make('latitude')->numeric(), TextInput::make('longitude')->numeric(),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->columns([
            TextColumn::make('nama_pos')->label('Nama pos')->searchable()->sortable(),
            TextColumn::make('alamat')->limit(45)->searchable()->placeholder('-'),
            TextColumn::make('no_telepon')->label('Telepon')->placeholder('-'),
            TextColumn::make('personil_count')->counts('personil')->label('Personil'),
            TextColumn::make('kendaraan_count')->counts('kendaraan')->label('Kendaraan'),
        ])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array { return ['index' => ManagePosDamkars::route('/')]; }
}
