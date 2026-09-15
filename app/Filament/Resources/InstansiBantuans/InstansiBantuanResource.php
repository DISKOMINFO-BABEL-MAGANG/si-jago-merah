<?php

namespace App\Filament\Resources\InstansiBantuans;

use App\Filament\Resources\InstansiBantuans\Pages\ManageInstansiBantuans;
use App\Models\InstansiBantuan;
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

class InstansiBantuanResource extends Resource
{
    protected static ?string $model = InstansiBantuan::class;
    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;
    protected static ?string $navigationLabel = 'Instansi Bantuan';
    protected static string|UnitEnum|null $navigationGroup = 'Sumber Daya';
    protected static ?int $navigationSort = 4;

    public static function form(Schema $schema): Schema
    {
        return $schema->components([
            TextInput::make('nama_instansi')->required(),
            TextInput::make('jenis')->placeholder('Contoh: BPBD, PMI, Kepolisian'),
        ])->columns(2);
    }

    public static function table(Table $table): Table
    {
        return $table->columns([
            TextColumn::make('nama_instansi')->label('Nama instansi')->searchable()->sortable(),
            TextColumn::make('jenis')->placeholder('-')->searchable(),
            TextColumn::make('kejadian_count')->counts('kejadian')->label('Bantuan kejadian'),
        ])->recordActions([EditAction::make(), DeleteAction::make()]);
    }

    public static function getPages(): array { return ['index' => ManageInstansiBantuans::route('/')]; }
}
