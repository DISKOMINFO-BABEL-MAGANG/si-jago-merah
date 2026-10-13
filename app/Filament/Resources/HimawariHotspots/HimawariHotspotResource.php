<?php

namespace App\Filament\Resources\HimawariHotspots;

use App\Filament\Resources\HimawariHotspots\Pages\CreateHimawariHotspot;
use App\Filament\Resources\HimawariHotspots\Pages\EditHimawariHotspot;
use App\Filament\Resources\HimawariHotspots\Pages\ListHimawariHotspots;
use App\Filament\Resources\HimawariHotspots\Pages\ViewHimawariHotspot;
use App\Filament\Resources\HimawariHotspots\Schemas\HimawariHotspotForm;
use App\Filament\Resources\HimawariHotspots\Schemas\HimawariHotspotInfolist;
use App\Filament\Resources\HimawariHotspots\Tables\HimawariHotspotsTable;
use App\Models\HimawariHotspot;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class HimawariHotspotResource extends Resource
{
    protected static ?string $model = HimawariHotspot::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    public static function form(Schema $schema): Schema
    {
        return HimawariHotspotForm::configure($schema);
    }

    public static function infolist(Schema $schema): Schema
    {
        return HimawariHotspotInfolist::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return HimawariHotspotsTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListHimawariHotspots::route('/'),
            'create' => CreateHimawariHotspot::route('/create'),
            'view' => ViewHimawariHotspot::route('/{record}'),
            'edit' => EditHimawariHotspot::route('/{record}/edit'),
        ];
    }
}
