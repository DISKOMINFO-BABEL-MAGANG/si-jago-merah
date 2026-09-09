<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PosDamkar extends Model
{
    protected $table = 'pos_damkar';

    public $timestamps = false;

    protected $fillable = [
        'nama_pos',
        'alamat',
        'no_telepon',
        'latitude',
        'longitude',
        'dibuat_pada',
    ];

    public function personil(): HasMany
    {
        return $this->hasMany(Personil::class, 'pos_id');
    }

    public function kendaraan(): HasMany
    {
        return $this->hasMany(Kendaraan::class, 'pos_id');
    }

    public function kejadian(): HasMany
    {
        return $this->hasMany(Kejadian::class, 'pos_id');
    }

    public function kegiatanEdukasi(): HasMany
    {
        return $this->hasMany(KegiatanEdukasi::class, 'pos_id');
    }
}