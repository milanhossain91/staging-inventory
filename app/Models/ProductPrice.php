<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProductPrice extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id', 'quantity', 'trade_price',  'vat_percent',  'vat', 'cost_price_without_tax', 'selling_price',  'wholesale', 'wholesale_type',
        'disable_from_price_rules', 'allow_price_override_regardless_of_permissions', 'prices_include_tax',
        'only_allow_items_to_be_sold_in_whole_numbers', 'change_cost_price_during_sale', 'override_default_commission',
        'override_default_tax', 'is_editable_in_sale'
    ];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}

