<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SalesManage extends Model
{
    use HasFactory;

    protected $table = 'sales_manage';

    protected $fillable = ['customer_id', 'date', 'gross_amount', 'discount', 'net_amount', 'paidamount', 'dueamount'];

    public function salesAdd()
    {
        return $this->hasMany(SalesAdd::class, 'sales_manage_id');
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
