<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DetailEvakuasi extends Model
{
    protected $table = 'detail_evakuasi';

    protected $primaryKey = 'kejadian_id';

    public $incrementing = false;

    public $timestamps = false;

    protected $fillable = [
        'kejadian_id',
        'objek_evakuasi',
    ];

    public function kejadian(): BelongsTo
    {
        return $this->belongsTo(
            Kejadian::class,
            'kejadian_id'
        );
    }
}