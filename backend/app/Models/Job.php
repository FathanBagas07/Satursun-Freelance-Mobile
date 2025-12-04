<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Job extends Model
{
    use HasFactory;

    // Menentukan kolom mana saja yang boleh diisi (mass assignable)
    protected $fillable = [
        'user_id',
        'judul',
        'lokasi',
        'kategori',
        'deskripsi',
        'budget',
        'tenggat_waktu',
        'status',
    ];

    // Relasi ke User (Setiap Job dimiliki oleh satu User/Klien)
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}