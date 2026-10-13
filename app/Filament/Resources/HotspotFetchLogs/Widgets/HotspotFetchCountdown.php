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

    $minute = $now->minute;

    $nextMinute = (int) (ceil(($minute + 1) / 10) * 10);

    if ($nextMinute >= 60) {
        return $now->copy()
            ->addHour()
            ->startOfHour()
            ->toIso8601String();
    }

    return $now->copy()
        ->setMinute($nextMinute)
        ->setSecond(0)
        ->toIso8601String();
}
}