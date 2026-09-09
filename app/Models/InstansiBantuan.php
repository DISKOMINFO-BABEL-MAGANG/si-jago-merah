<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class InstansiBantuan extends Model
{
    protected $table = 'instansi_bantuan';

    public $timestamps = false;

    protected $fillable = [
        'nama_instansi',
        'jenis',
    ];

    public function kejadian(): BelongsToMany
    {
        return $this->belongsToMany(
            Kejadian::class,
            'kejadian_bantuan',
            'instansi_id',
            'kejadian_id'
        )->withPivot('keterangan');
    }
}