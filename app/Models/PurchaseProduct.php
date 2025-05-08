<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PurchaseProduct extends Model
{
    use HasFactory;

    protected $table = 'purchase_products';

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
        'without_dis_total',
        'discount_percent',
        'discount_amount',
        'getis_percent',
        'getis_amount',
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

    protected $guarded = [];

    // get product total
    public function productTotal()
    {
        return $this->quantity * $this->purchase_price;
    }

    /**
     * Get the purchase for this product.
     */
    public function purchase()
    {
        return $this->belongsTo(Purchase::class, 'purchase_id');
    }

    /**
     * Get the product.
     */
    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function packSize()
    {
        return $this->hasOne(ProductPackSize::class, 'id', 'pack_size_id');
    }
}
