<?php

namespace App\Filament\Resources\HotspotFetchLogs\Widgets;

use Filament\Widgets\Widget;

class HotspotFetchCountdown extends Widget
{
    protected string $view = 'filament.resources.hotspot-fetch-logs.widgets.hotspot-fetch-countdown';

    protected int|string|array $columnSpan = 'full';

    public function getNextFetchTime(): string
    {
        $now = now();

        $nextHour = $now->copy()
            ->addHour()
            ->startOfHour();

        return $nextHour->toIso8601String();
    }
}