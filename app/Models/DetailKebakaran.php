<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DetailKebakaran extends Model
{
    protected $table = 'detail_kebakaran';

    protected $primaryKey = 'kejadian_id';

    public $incrementing = false;

    public $timestamps = false;

    protected $fillable = [
        'kejadian_id',
        'objek_terbakar',
    ];

    public function kejadian(): BelongsTo
    {
        return $this->belongsTo(
            Kejadian::class,
            'kejadian_id'
        );
    }
}