<?php

namespace App\Filament\Resources\HimawariHotspots\Schemas;

use Filament\Infolists\Components\TextEntry;
use Filament\Schemas\Schema;

class HimawariHotspotInfolist
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextEntry::make('latitude')
                    ->numeric(),
                TextEntry::make('longitude')
                    ->numeric(),
                TextEntry::make('source'),
                TextEntry::make('satellite'),
                TextEntry::make('instrument'),
                TextEntry::make('acq_date')
                    ->date(),
                TextEntry::make('acq_time'),
                TextEntry::make('bt07')
                    ->numeric(),
                TextEntry::make('bt14')
                    ->numeric(),
                TextEntry::make('bt_difference')
                    ->numeric(),
                TextEntry::make('pixel_count')
                    ->numeric(),
                TextEntry::make('region')
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
