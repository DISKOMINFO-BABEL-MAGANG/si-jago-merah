<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Personil extends Model
{
    protected $table = 'personil';

    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'nama',
        'nrp',
        'jabatan',
        'no_hp',
        'pos_id',
        'status',
        'dibuat_pada',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function pos(): BelongsTo
    {
        return $this->belongsTo(PosDamkar::class, 'pos_id');
    }

    public function kejadian(): BelongsToMany
    {
        return $this->belongsToMany(
            Kejadian::class,
            'kejadian_regu',
            'personil_id',
            'kejadian_id'
        );
    }

    public function kegiatanEdukasi(): BelongsToMany
    {
        return $this->belongsToMany(
            KegiatanEdukasi::class,
            'kegiatan_edukasi_personil',
            'personil_id',
            'kegiatan_id'
        )->withPivot('peran');
    }
}