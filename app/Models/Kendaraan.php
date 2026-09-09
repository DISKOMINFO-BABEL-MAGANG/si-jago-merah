<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Kendaraan extends Model
{
    protected $table = 'kendaraan';

    public $timestamps = false;

    protected $fillable = [
        'no_lambung',
        'plat_nomor',
        'jenis',
        'status',
        'pos_id',
    ];

    public function pos(): BelongsTo
    {
        return $this->belongsTo(PosDamkar::class, 'pos_id');
    }

    public function kejadian(): BelongsToMany
    {
        return $this->belongsToMany(
            Kejadian::class,
            'kejadian_kendaraan',
            'kendaraan_id',
            'kejadian_id'
        );
    }
}