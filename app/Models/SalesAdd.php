<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SalesAdd extends Model
{
    use HasFactory;

    protected $table = 'sales_add';

    protected $fillable = ['sales_manage_id', 'product_id', 'quantity', 'sales_price'];

    public function salesManage()
    {
        return $this->belongsTo(SalesManage::class, 'sales_manage_id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }
}

