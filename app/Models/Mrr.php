<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Cviebrock\EloquentSluggable\Sluggable;
use Illuminate\Database\Eloquent\SoftDeletes;

class Mrr extends Model
{
    // Notifiable
    use SoftDeletes, HasFactory;

    protected $guarded = [];

    public function supplier()
    {
        return $this->hasOne(Supplier::class, 'id', 'supplier_id');
    }
    // public function mrrBalance()
    // {
    //     return $this->hasMany(MrrBalance::class, 'mrr_id', 'id');
    // }
}
