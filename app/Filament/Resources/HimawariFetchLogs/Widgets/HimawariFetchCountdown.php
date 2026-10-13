<?php

namespace App\Filament\Resources\HimawariFetchLogs\Widgets;

use Filament\Widgets\Widget;

class HimawariFetchCountdown extends Widget
{
    protected string $view = 'filament.resources.himawari-fetch-logs.widgets.himawari-fetch-countdown';

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
