<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Cviebrock\EloquentSluggable\Sluggable;

class Product extends Model
{
    use HasFactory;
  //  use Sluggable;

    protected $fillable = [
        'categories_id', 'subcategories_id', 'suppliers_id', 'name', 'product_id', 'tags', 'manufacturer_id', 'description', 'batch_no', 'generic_id', 'is_ecommerce_item', 'is_barcoded'
    ];

    // public function sluggable(): array
    // {
    //     return [
    //         'slug' => [
    //             'source' => 'name' // change 'name' to your field name
    //         ]
    //     ];
    // }

    public function packSizes()
    {
        return $this->hasMany(ProductPackSize::class);
    }

    public function prices()
    {
        return $this->hasOne(ProductPrice::class);
    }

    public function images()
    {
        return $this->hasMany(ProductImage::class);
    }


    public function category()
    {
        return $this->belongsTo(Category::class, 'categories_id');
    }

    public function subCategory()
    {
        return $this->belongsTo(SubCategory::class, 'subcategories_id');
    }

    public function supplier()
    {
        return $this->belongsTo(Supplier::class, 'suppliers_id');
    }
}
