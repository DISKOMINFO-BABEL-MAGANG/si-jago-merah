<?php

namespace App\Filament\Resources\Personils;

use App\Filament\Resources\Personils\Pages\ManagePersonils;
use App\Models\Personil;
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

class PersonilResource extends Resource
{
    protected static ?string $model = Personil::class;
    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
    protected static ?string $navigationLabel = 'Personil';
    protected static string|UnitEnum|null $navigationGroup = 'Sumber Daya';
    protected static ?int $navigationSort = 2;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            TextInput::make('nama')->required(), TextInput::make('nrp'), TextInput::make('jabatan'), TextInput::make('no_hp')->tel(),
            Select::make('pos_id')->relationship('pos', 'nama_pos')->searchable()->preload()->label('Pos damkar'),
            Select::make('status')->options(['aktif' => 'Aktif', 'nonaktif' => 'Nonaktif'])->default('aktif')->required(),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->columns([
            TextColumn::make('nama')->searchable()->sortable(), TextColumn::make('nrp')->placeholder('-')->searchable(), TextColumn::make('jabatan')->placeholder('-'),
            TextColumn::make('pos.nama_pos')->label('Pos')->placeholder('-'),
            TextColumn::make('status')->badge()->color(fn (string $state) => $state === 'aktif' ? 'success' : 'gray'),
        ])->filters([SelectFilter::make('status')->options(['aktif' => 'Aktif', 'nonaktif' => 'Nonaktif'])])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array { return ['index' => ManagePersonils::route('/')]; }
}
