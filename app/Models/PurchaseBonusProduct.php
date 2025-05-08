<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PurchaseBonusProduct extends Model
{
    use HasFactory;

    protected $fillable = [
        'purchase_id',
        'product_id',
        'product_name',
        'pack_size_id',
        'tp',
        'vat',
        'cost',
        'received_quantity',
        'quantity',
        'total',
        'size',
        'generic_name',
        'serial',
        'stock',
        'cost_price_preview',
        'item_id',
        'batch_no',
        'expiry_date',
    ];

    public function purchase()
    {
        return $this->belongsTo(Purchase::class);
    }

    public function packSize()
    {
        return $this->belongsTo(ProductPackSize::class);
    }
}
