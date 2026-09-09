<?php

namespace App\Filament\Resources\Hotspots\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class HotspotInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('latitude')
                    ->numeric(),
                TextEntry::make('longitude')
                    ->numeric(),
                TextEntry::make('source')
                    ->placeholder('-'),
                TextEntry::make('region')
                    ->placeholder('-'),
                TextEntry::make('bright_ti4')
                    ->numeric()
                    ->placeholder('-'),
                TextEntry::make('scan')
                    ->numeric()
                    ->placeholder('-'),
                TextEntry::make('track')
                    ->numeric()
                    ->placeholder('-'),
                TextEntry::make('acq_date')
                    ->date()
                    ->placeholder('-'),
                TextEntry::make('acq_time')
                    ->placeholder('-'),
                TextEntry::make('satellite')
                    ->placeholder('-'),
                TextEntry::make('instrument')
                    ->placeholder('-'),
                TextEntry::make('confidence')
                    ->placeholder('-'),
                TextEntry::make('version')
                    ->placeholder('-'),
                TextEntry::make('bright_ti5')
                    ->numeric()
                    ->placeholder('-'),
                TextEntry::make('frp')
                    ->numeric()
                    ->placeholder('-'),
                TextEntry::make('daynight')
                    ->placeholder('-'),
                TextEntry::make('created_at')
                    ->dateTime()
                    ->placeholder('-'),
                TextEntry::make('updated_at')
                    ->dateTime()
                    ->placeholder('-'),
            ]);
    }
}
