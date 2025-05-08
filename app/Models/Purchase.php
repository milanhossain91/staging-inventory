<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Purchase extends Model
{
    use HasFactory;

    protected $fillable = [
        'purchase_code',
        'supplier_id',
        'getis_percent',
        'amount',
        'mrr_id',
        'sub_total',
        'total_trade_price',
        'total_vat',
        'total',
        'amount_due',
        'purchase_date',
        'paid_amount',
        'payment_method_id',
        'note',
        'branch_id',
        'discount_entire_purchase',
        'discount_all_percent',
        'invoice_no',
        'created_by',
        'file',
    ];

    protected $guarded = [];


    /**
     * Return the sluggable configuration array for this model.
     *
     * @return array
     */


    /**
     * Get the purchase due.
     *
     * @return string
     */
    public function getCalculatedDueAttribute()
    {
        return $this->totalDue();
    }

    /**
     * Get the purchase tax.
     *
     * @return string
     */
    public function getCalculatedTaxAttribute()
    {
        return $this->taxAmount();
    }

    /**
     * Get the purchase total.
     *
     * @return string
     */
    public function getCalculatedTotalAttribute()
    {
        return $this->purchaseTotal();
    }

    // calculate tax
    public function taxAmount()
    {
        $taxRate = $this->purchaseTax;
        $totalTax = 0;
        $subTotal = $this->sub_total;
        if (isset($taxRate) && $taxRate->rate > 0) {
            if (isset($this->purchaseReturn)) {
                $subTotal = $this->sub_total - $this->purchaseReturn->total_return;
            }
            $totalTax = ($taxRate->rate / 100) * $subTotal;
        }

        return $totalTax;
    }

    // purchase total
    public function purchaseTotal()
    {
        $costOfProductReturn = isset($this->purchaseReturn) ? $this->purchaseReturn->total_return : 0;

        return $this->sub_total + $this->taxAmount() + $this->transport - $this->discount - $costOfProductReturn;
    }


    public function purchaseTotalPaid()
    {
        $totalPaid = $this->sum('amount');

        return $totalPaid;
    }



    public function totalDue()
    {
        $due = $this->purchaseTotal() - $this->purchaseTotalPaid();

        return $due >= 0 ? $due : 0;
    }

    /**
     * Get the supplier for this purchase.
     */
    public function supplier()
    {
        return $this->belongsTo(Supplier::class, 'supplier_id');
    }
    public function mrr()
    {
        return $this->belongsTo(Mrr::class, 'mrr_id');
    }

    public function purchaseProducts()
    {
        return $this->hasMany(PurchaseProduct::class, 'purchase_id');
    }

    public function purchaseBonusProducts()
    {
        return $this->hasMany(PurchaseBonusProduct::class, 'purchase_id');
    }

    public function stockBatches()
    {
        return $this->hasMany(StockBatch::class, 'purchase_id');
    }
    public function paymentMethod()
    {
        return $this->hasOne(PaymentMethod::class, 'id', 'payment_method_id');
    }
    public function branch()
    {
        return $this->hasOne(Branch::class, 'id', 'branch_id');
    }

    /**
     * Get the tax for this purchase.
     */
    public function purchaseTax()
    {
        return $this->belongsTo(VatRate::class, 'tax_id');
    }

    /**
     * Get the user who had created this purchase.
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
    public function suspendRequestUser()
    {
        return $this->belongsTo(User::class, 'suspend_request_by');
    }
}
