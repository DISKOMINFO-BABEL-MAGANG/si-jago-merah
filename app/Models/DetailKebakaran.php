<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DetailKebakaran extends Model
{
    protected $table = 'detail_kebakaran';

    // Primary key tabel ini adalah kejadian_id (bukan id auto-increment).
    protected $primaryKey = 'kejadian_id';

    public $incrementing = false;

    protected $keyType = 'int';

    public $timestamps = false;

    protected $fillable = [
        'kejadian_id',
        'objek_terbakar',   // lahan | hutan | rumah
        'luas_area_ha',
    ];

    protected $casts = [
        'luas_area_ha' => 'float',
    ];

    public function kejadian(): BelongsTo
    {
        return $this->belongsTo(Kejadian::class, 'kejadian_id');
    }
}