<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class KejadianRegu extends Model
{
    protected $table = 'kejadian_regu';

    public $timestamps = false;

    protected $fillable = [
        'kejadian_id',
        'personil_id',
    ];

    public function kejadian(): BelongsTo
    {
        return $this->belongsTo(
            Kejadian::class,
            'kejadian_id'
        );
    }

    public function personil(): BelongsTo
    {
        return $this->belongsTo(
            Personil::class,
            'personil_id'
        );
    }
}