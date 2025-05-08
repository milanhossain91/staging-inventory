<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductPackSize extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id', 'name', 'quantity', 'tp', 'vat_percent', 'vat', 'selling_price', 'default_unit'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}

