<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Product;
use App\Models\Purchase;
use Illuminate\Http\Request;
use App\Models\PurchasePayment;
use App\Models\PurchaseProduct;
use App\Models\PurchaseBonusProduct;
use App\Models\StockBatch;
use App\Models\MrrBalance;
use App\Models\SupplierBalance;
use App\Rules\PurchaseTotalPaid;
use App\Models\AccountTransaction;
use App\Http\Controllers\Controller;
use App\Notifications\PurchaseNotification;
use App\Http\Resources\PurchaseListResource;
use App\Http\Resources\PurchaseProductsResource;
use App\Http\Resources\PurchaseProductsEditResource;
use App\Notifications\PurchasePaymentNotification;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Supplier;
use App\Models\SupplierTransaction;
use App\Models\MrrTransaction;
use App\Models\Mrr;
use App\Models\ProductPackSize;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;

class PurchaseController extends Controller
{
    // define middleware
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $perPage = $request->perPage ?? 15;
        $search = $request->search;

        $query = Purchase::with('supplier', 'purchaseProducts');

        if ($search) {
            $query->whereHas('purchaseProducts', function ($q) use ($search) {
                $q->where('product_name', 'like', '%' . $search . '%');
            });
        }

        $purchases = $query->latest()->paginate($perPage);

        if ($purchases->isEmpty()) {
            return response()->json(['message' => 'Purchase not found'], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $purchases
        ], 200);
    }



    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {


        DB::beginTransaction();
        try {

            // $request->validate([
            //     'file' => 'nullable|mimes:jpeg,png,jpg,gif,pdf',
            // ], [
            //     'file.mimes' => 'The file must be an image (jpeg, png, jpg, gif) or a PDF.',
            // ]);

            $purchaseData = $request->except('purchase_products');

            if (is_string($request->purchase_products)) {
                $purchaseProductsData = json_decode($request->purchase_products, true);
            } else {
                $purchaseProductsData = $request->purchase_products;
            }

            if (is_string($request->bonus_products)) {
                $bonusProductsData = json_decode($request->bonus_products, true);
            } else {
                $bonusProductsData = $request->bonus_products;
            }


            $purchase = new Purchase();
            $purchase->purchase_code = $this->generate_purchase_code();
            $purchase->supplier_id = $purchaseData['supplier_id'] ?? null;
            $purchase->getis_percent = $purchaseData['getis_percent'] ?? null;
            $purchase->amount = $purchaseData['amount'] ?? null;
            $purchase->mrr_id = $purchaseData['mrr_id'] ?? null;
            $purchase->sub_total = $purchaseData['sub_total'] ?? null;
            $purchase->total_trade_price = $purchaseData['total_trade_price'] ?? null;
            $purchase->total_vat = $purchaseData['total_vat'] ?? null;
            $purchase->total = $purchaseData['total'] ?? null;
            $purchase->amount_due = $purchaseData['amount_due'] ?? null;
            $purchase->purchase_date = $purchaseData['purchase_date'] ?? null;
            $purchase->paid_amount = $purchaseData['paid_amount'] ?? null;
            $purchase->payment_method_id = $purchaseData['payment_method_id'] ?? null;
            $purchase->note = $purchaseData['note'] ?? null;
            $purchase->branch_id = $purchaseData['branch_id'] ?? null;
            $purchase->discount_entire_purchase = $purchaseData['discount_entire_purchase'] ?? 0;
            $purchase->discount_all_percent = $purchaseData['discount_all_percent'] ?? 0;
            $purchase->invoice_no = $purchaseData['invoice_no'] ?? null;
            $purchase->created_by = Auth::id() ?? null;

            // if ($request->hasFile('file')) {
            //     $file = $request->file('file');
            //     $uniqueFileName = uniqid() . '_' . time() . '.' . $file->getClientOriginalExtension();
            //     $filePath = $file->storeAs('uploads/purchase_files', $uniqueFileName, 'public');
            //     $purchase->file = $filePath;
            // }

            $purchase->save();




            $purchaseProductIds = collect($purchaseProductsData)->pluck('product_id');
            $bonusProductIds = collect($bonusProductsData)->pluck('product_id');

            $productIds = $purchaseProductIds->union($bonusProductIds);

            $latestProducts = PurchaseProduct::query()
                ->whereIn('product_id', $productIds)
                ->orderBy('product_id')
                ->orderBy('id', 'desc')
                ->get()
                ->unique('product_id');

            $latestProducts = $latestProducts->groupBy('product_id');


            foreach ($purchaseProductsData as $product) {
                $product['purchase_id'] = $purchase->id;


                $pack_size =  ProductPackSize::findOrFail($product['pack_size_id']);

                $pack_size->update([
                    'quantity' => $pack_size->quantity + $product['quantity'],
                    'tp' => $product['tp'],
                    'vat' => $product['vat'],
                ]);

                $purchase_product = new PurchaseProduct();
                $purchase_product->product_id = $product['product_id'];
                $purchase_product->product_name = $product['product_name'] ?? null;
                $purchase_product->pack_size_id = $product['pack_size_id'] ?? null;
                $purchase_product->tp = $product['tp'] ?? null;
                $purchase_product->vat = $product['vat'] ?? null;
                $purchase_product->cost = $product['cost'] ?? null;
                $purchase_product->received_quantity =  $product['quantity'];
                $purchase_product->quantity = (isset($pack_size->name) && $pack_size->name == 'Pack') ? $product['quantity'] * $pack_size->quantity : $product['quantity'];
                $purchase_product->without_dis_total = $product['without_dis_total'] ?? 0;
                $purchase_product->discount_percent = $product['discount_percent'] ?? 0;
                $purchase_product->discount_amount = $product['discount_amount'] ?? 0;
                $purchase_product->getis_percent = $product['getis_percent'] ?? 0;
                $purchase_product->getis_amount = $product['getis_amount'] ?? 0;
                $purchase_product->total = $product['total'] ?? 0;
                $purchase_product->size = $product['size'] ?? null;
                $purchase_product->generic_name = $product['generic_name'] ?? null;
                $purchase_product->serial = $product['serial'] ?? null;
                $purchase_product->stock = $product['stock'] ?? null;
                $purchase_product->cost_price_preview = $product['cost_price_preview'] ?? null;
                $purchase_product->item_id = $product['item_id'] ?? null;

                if (isset($latestProducts[$product['product_id']][0]) && $latestProducts[$product['product_id']][0]->tp == $product['tp']) {
                    $purchase_product->batch_no = $latestProducts[$product['product_id']][0]->batch_no ?? null;
                } else {
                    $purchase_product->batch_no = $this->generate_batch_no();
                }

                $purchase_product->expiry_date = $product['expiry_date'] ?? null;
                $purchase_product->purchase_id = $product['purchase_id'] ?? null;
                $purchase_product->save();

            }
            if (isset($bonusProductsData)) {
                foreach ($bonusProductsData as $product) {
                    $product['purchase_id'] = $purchase->id;

                    $pack_size =  ProductPackSize::findOrFail($product['pack_size_id']);

                    $pack_size->update([
                        'quantity' => $pack_size->quantity + $product['quantity'],
                        'tp' => $product['tp'],
                        'vat' => $product['vat'],
                    ]);

                    $purchase_bonus_product = new PurchaseBonusProduct();
                    $purchase_bonus_product->product_id = $product['product_id'];
                    $purchase_bonus_product->product_name = $product['product_name'] ?? null;
                    $purchase_bonus_product->pack_size_id = $product['pack_size_id'] ?? null;
                    $purchase_bonus_product->tp =  0;
                    $purchase_bonus_product->vat = $product['vat'] ?? null;
                    $purchase_bonus_product->cost = $product['cost'] ?? null;
                    $purchase_bonus_product->received_quantity =  $product['quantity'];
                    $purchase_bonus_product->quantity = (isset($pack_size->name) && $pack_size->name == 'Pack') ? $product['quantity'] * $pack_size->quantity : $product['quantity'];
                    $purchase_bonus_product->total = $product['total'] ?? 0;
                    $purchase_bonus_product->size = $product['size'] ?? null;
                    $purchase_bonus_product->generic_name = $product['generic_name'] ?? null;
                    $purchase_bonus_product->serial = $product['serial'] ?? null;
                    $purchase_bonus_product->stock = $product['stock'] ?? null;
                    $purchase_bonus_product->cost_price_preview = $product['cost_price_preview'] ?? null;
                    $purchase_bonus_product->item_id = $product['item_id'] ?? null;

                    if (isset($latestProducts[$product['product_id']][0]) && $latestProducts[$product['product_id']][0]->tp == $product['tp']) {
                        $purchase_bonus_product->batch_no = $latestProducts[$product['product_id']][0]->batch_no ?? null;
                    } else {
                        $purchase_bonus_product->batch_no = $this->generate_batch_no();
                    }

                    $purchase_bonus_product->expiry_date = $product['expiry_date'] ?? null;
                    $purchase_bonus_product->purchase_id = $product['purchase_id'] ?? null;
                    $purchase_bonus_product->save();
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Purchase added successfully',
                'purchase' => $purchase,
            ]);
            // return $this->responseWithSuccess('Purchase added successfully', [
            //     'purchase' => $purchase,
            // ]);
        } catch (Exception $e) {
            DB::rollback();
            return $this->responseWithError($e->getMessage());
        }
    }

    // public function store(Request $request)
    // {
    //     DB::beginTransaction();

    //     try {
    //         // Validate the request
    //         $request->validate([
    //             'file' => 'nullable|mimes:jpeg,png,jpg,gif,pdf',
    //         ], [
    //             'file.mimes' => 'The file must be an image (jpeg, png, jpg, gif) or a PDF.',
    //         ]);

    //         // Extract and process data
    //         $purchaseData = $request->except('purchase_products', 'bonus_products');

    //         $purchaseProductsData = is_string($request->purchase_products)
    //             ? json_decode($request->purchase_products, true)
    //             : $request->purchase_products;

    //         $bonusProductsData = is_string($request->bonus_products)
    //             ? json_decode($request->bonus_products, true)
    //             : $request->bonus_products;

    //         // Create a new purchase record
    //         $purchase = new Purchase();
    //         $purchase->purchase_code = $this->generate_purchase_code();
    //         $purchase->supplier_id = $purchaseData['supplier_id'] ?? null;
    //         $purchase->getis_percent = $purchaseData['getis_percent'] ?? null;
    //         $purchase->amount = $purchaseData['amount'] ?? null;
    //         $purchase->mrr_id = $purchaseData['mrr_id'] ?? null;
    //         $purchase->sub_total = $purchaseData['sub_total'] ?? null;
    //         $purchase->total_trade_price = $purchaseData['total_trade_price'] ?? null;
    //         $purchase->total_vat = $purchaseData['total_vat'] ?? null;
    //         $purchase->total = $purchaseData['total'] ?? null;
    //         $purchase->amount_due = $purchaseData['amount_due'] ?? null;
    //         $purchase->purchase_date = $purchaseData['purchase_date'] ?? null;
    //         $purchase->paid_amount = $purchaseData['paid_amount'] ?? null;
    //         $purchase->payment_method_id = $purchaseData['payment_method_id'] ?? null;
    //         $purchase->note = $purchaseData['note'] ?? null;
    //         $purchase->branch_id = $purchaseData['branch_id'] ?? null;
    //         $purchase->discount_entire_purchase = $purchaseData['discount_entire_purchase'] ?? 0;
    //         $purchase->discount_all_percent = $purchaseData['discount_all_percent'] ?? 0;
    //         $purchase->invoice_no = $purchaseData['invoice_no'] ?? null;
    //         $purchase->created_by = Auth::id() ?? null;

    //         // Handle file upload
    //         if ($request->hasFile('file')) {
    //             $file = $request->file('file');
    //             $uniqueFileName = uniqid() . '_' . time() . '.' . $file->getClientOriginalExtension();
    //             $filePath = $file->storeAs('uploads/purchase_files', $uniqueFileName, 'public');
    //             $purchase->file = $filePath;
    //         }

    //         $purchase->save();

    //         // Get the latest product batches for efficient batch assignment
    //         $productIds = collect($purchaseProductsData)
    //             ->merge($bonusProductsData ?? [])
    //             ->pluck('product_id')
    //             ->unique();

    //         $latestProducts = PurchaseProduct::query()
    //             ->whereIn('product_id', $productIds)
    //             ->orderBy('product_id')
    //             ->orderBy('id', 'desc')
    //             ->get()
    //             ->unique('product_id')
    //             ->groupBy('product_id');

    //         // Process purchase products in chunks
    //         collect($purchaseProductsData)->chunk(20)->each(function ($chunk) use ($purchase, $latestProducts) {
    //             $bulkInsertData = [];

    //             foreach ($chunk as $product) {
    //                 $pack_size = ProductPackSize::findOrFail($product['pack_size_id']);

    //                 $bulkInsertData[] = [
    //                     'purchase_id' => $purchase->id,
    //                     'product_id' => $product['product_id'],
    //                     'product_name' => $product['product_name'] ?? null,
    //                     'pack_size_id' => $product['pack_size_id'] ?? null,
    //                     'tp' => $product['tp'] ?? null,
    //                     'vat' => $product['vat'] ?? null,
    //                     'cost' => $product['cost'] ?? null,
    //                     'received_quantity' => $product['quantity'],
    //                     'quantity' => (isset($pack_size->name) && $pack_size->name == 'Pack')
    //                         ? $product['quantity'] * $pack_size->quantity
    //                         : $product['quantity'],
    //                     'without_dis_total' => $product['without_dis_total'] ?? 0,
    //                     'discount_percent' => $product['discount_percent'] ?? 0,
    //                     'discount_amount' => $product['discount_amount'] ?? 0,
    //                     'getis_percent' => $product['getis_percent'] ?? 0,
    //                     'getis_amount' => $product['getis_amount'] ?? 0,
    //                     'total' => $product['total'] ?? 0,
    //                     'batch_no' => isset($latestProducts[$product['product_id']][0])
    //                         && $latestProducts[$product['product_id']][0]->tp == $product['tp']
    //                         ? $latestProducts[$product['product_id']][0]->batch_no
    //                         : $this->generate_batch_no(),
    //                     'expiry_date' => $product['expiry_date'] ?? null,
    //                     'created_at' => now(),
    //                     'updated_at' => now(),
    //                 ];
    //             }

    //             PurchaseProduct::insert($bulkInsertData);
    //         });

    //         // Process bonus products similarly
    //         if (!empty($bonusProductsData)) {
    //             collect($bonusProductsData)->chunk(20)->each(function ($chunk) use ($purchase, $latestProducts) {
    //                 $bulkInsertData = [];

    //                 foreach ($chunk as $product) {
    //                     $pack_size = ProductPackSize::findOrFail($product['pack_size_id']);

    //                     $bulkInsertData[] = [
    //                         'purchase_id' => $purchase->id,
    //                         'product_id' => $product['product_id'],
    //                         'product_name' => $product['product_name'] ?? null,
    //                         'pack_size_id' => $product['pack_size_id'] ?? null,
    //                         'tp' => 0,
    //                         'vat' => $product['vat'] ?? null,
    //                         'cost' => $product['cost'] ?? null,
    //                         'received_quantity' => $product['quantity'],
    //                         'quantity' => (isset($pack_size->name) && $pack_size->name == 'Pack')
    //                             ? $product['quantity'] * $pack_size->quantity
    //                             : $product['quantity'],
    //                         'total' => $product['total'] ?? 0,
    //                         'batch_no' => isset($latestProducts[$product['product_id']][0])
    //                             && $latestProducts[$product['product_id']][0]->tp == $product['tp']
    //                             ? $latestProducts[$product['product_id']][0]->batch_no
    //                             : $this->generate_batch_no(),
    //                         'expiry_date' => $product['expiry_date'] ?? null,
    //                         'created_at' => now(),
    //                         'updated_at' => now(),
    //                     ];
    //                 }

    //                 PurchaseBonusProduct::insert($bulkInsertData);
    //             });
    //         }

    //         DB::commit();

    //         return response()->json([
    //             'success' => true,
    //             'message' => 'Purchase added successfully',
    //             'purchase' => $purchase,
    //         ]);
    //     } catch (Exception $e) {
    //         DB::rollback();
    //         return response()->json([
    //             'success' => false,
    //             'message' => $e->getMessage(),
    //         ], 500);
    //     }
    // }

    private function generate_purchase_code()
    {
        do {
            $purchase_code = date('ymd') . rand(1000, 9999);
            $exists = Purchase::where('purchase_code', $purchase_code)->exists();
        } while ($exists);

        return $purchase_code;
    }
    private function generate_batch_no()
    {
        do {
            $batch_no = date('ymd') . rand(1000, 9999);
            $exists = PurchaseProduct::where('batch_no', $batch_no)->exists();
        } while ($exists);

        return $batch_no;
    }


    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            $purchase = Purchase::with(
                'supplier',
                'purchaseProducts',
                'purchaseProducts.purchase',
                'purchaseProducts.packSize',
                'purchaseProducts.product',
                'purchaseProducts.product.images',
                'purchaseProducts.product.category',
                'purchaseProducts.product.subCategory',
                'user'
            )->where('id', $id)->first();

            if (!$purchase) {
                return response()->json(['message' => 'Purchase not found'], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $purchase
            ], 200);

        } catch (Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function purchasesEdit(Request $request)
    {

        try {
            $purchase = Purchase::with(['purchaseProducts.ProductPackSize', 'purchaseBonusProducts.ProductPackSize', 'stockBatches', 'supplier', 'mrr', 'branch', 'paymentMethod', 'user', 'suspendRequestUser'])->where('id', $request->id)->first();
            return $purchase;
        } catch (Exception $e) {
            return $this->responseWithError($e->getMessage());
        }
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, $id)
    {
        DB::beginTransaction();
        try {
            $request->validate([
                'file' => 'nullable|mimes:jpeg,png,jpg,gif,pdf',
            ], [
                'file.mimes' => 'The file must be an image (jpeg, png, jpg, gif) or a PDF.',
            ]);


            //$bonusProductsData = (array) (json_decode($request->input('bonus_products'), true) ?? []);

            $purchase = Purchase::findOrFail($id);

            // Get all data except the nested 'purchase_products'
            $purchaseData = $request->except('purchase_products', 'bonus_products');

            // Get and decode the products arrays safely
            $purchaseProductsData = json_decode($request->input('purchase_products'), true) ?? [];
            $bonusProductsData = json_decode($request->input('bonus_products'), true) ?? [];

            // Optional: Ensure they are arrays
            $purchaseProductsData = is_array($purchaseProductsData) ? $purchaseProductsData : [];
            $bonusProductsData = is_array($bonusProductsData) ? $bonusProductsData : [];



          // Update purchase fields
            $purchase->supplier_id = $purchaseData['supplier_id'] ?? null;
            $purchase->getis_percent = $purchaseData['getis_percent'] ?? null;
            $purchase->amount = $purchaseData['amount'] ?? null;
            $purchase->mrr_id = $purchaseData['mrr_id'] ?? null;
            $purchase->sub_total = $purchaseData['sub_total'] ?? null;
            $purchase->total_trade_price = $purchaseData['total_trade_price'] ?? null;
            $purchase->total_vat = $purchaseData['total_vat'] ?? null;
            $purchase->total = $purchaseData['total'] ?? null;
            $purchase->amount_due = $purchaseData['amount_due'] ?? null;
            $purchase->purchase_date = $purchaseData['purchase_date'] ?? null;
            $purchase->paid_amount = $purchaseData['paid_amount'] ?? null;
            $purchase->payment_method_id = $purchaseData['payment_method_id'] ?? null;
            $purchase->note = $purchaseData['note'] ?? null;
            $purchase->branch_id = $purchaseData['branch_id'] ?? null;
            $purchase->discount_entire_purchase = $purchaseData['discount_entire_purchase'] ?? 0;
            $purchase->discount_all_percent = $purchaseData['discount_all_percent'] ?? 0;
            $purchase->invoice_no = $purchaseData['invoice_no'] ?? null;
           // $purchase->updated_by = Auth::id() ?? null;

            if ($request->hasFile('file')) {
                // Delete old file if exists
                if ($purchase->file && Storage::disk('public')->exists($purchase->file)) {
                    Storage::disk('public')->delete($purchase->file);
                }

                $file = $request->file('file');
                $uniqueFileName = uniqid() . '_' . time() . '.' . $file->getClientOriginalExtension();
                $filePath = $file->storeAs('uploads/purchase_files', $uniqueFileName, 'public');
                $purchase->file = $filePath;
            }

            $purchase->save();

            // Delete old related products
            PurchaseProduct::where('purchase_id', $purchase->id)->delete();
            PurchaseBonusProduct::where('purchase_id', $purchase->id)->delete();

            $purchaseProductIds = collect($purchaseProductsData)->pluck('product_id');
            $bonusProductIds = collect($bonusProductsData)->pluck('product_id');
            $productIds = $purchaseProductIds->union($bonusProductIds);

            $latestProducts = PurchaseProduct::query()
                ->whereIn('product_id', $productIds)
                ->orderBy('product_id')
                ->orderBy('id', 'desc')
                ->get()
                ->unique('product_id')
                ->groupBy('product_id');

            foreach ($purchaseProductsData as $product) {
                $product['purchase_id'] = $purchase->id;

                $pack_size = ProductPackSize::findOrFail($product['pack_size_id']);

                $pack_size->update([
                    'quantity' => $pack_size->quantity + $product['quantity'],
                    'tp' => $product['tp'],
                    'vat' => $product['vat'],
                ]);

                $purchase_product = new PurchaseProduct();
                $purchase_product->purchase_id = $purchase->id;
                $purchase_product->product_id = $product['product_id'];
                $purchase_product->product_name = $product['product_name'] ?? null;
                $purchase_product->pack_size_id = $product['pack_size_id'] ?? null;
                $purchase_product->tp = $product['tp'] ?? null;
                $purchase_product->vat = $product['vat'] ?? null;
                $purchase_product->cost = $product['cost'] ?? null;
                $purchase_product->received_quantity = $product['quantity'];
                $purchase_product->quantity = ($pack_size->name == 'Pack') ? $product['quantity'] * $pack_size->quantity : $product['quantity'];
                $purchase_product->without_dis_total = $product['without_dis_total'] ?? 0;
                $purchase_product->discount_percent = $product['discount_percent'] ?? 0;
                $purchase_product->discount_amount = $product['discount_amount'] ?? 0;
                $purchase_product->getis_percent = $product['getis_percent'] ?? 0;
                $purchase_product->getis_amount = $product['getis_amount'] ?? 0;
                $purchase_product->total = $product['total'] ?? 0;
                $purchase_product->size = $product['size'] ?? null;
                $purchase_product->generic_name = $product['generic_name'] ?? null;
                $purchase_product->serial = $product['serial'] ?? null;
                $purchase_product->stock = $product['stock'] ?? null;
                $purchase_product->cost_price_preview = $product['cost_price_preview'] ?? null;
                $purchase_product->item_id = $product['item_id'] ?? null;

                $purchase_product->batch_no = (isset($latestProducts[$product['product_id']][0]) && $latestProducts[$product['product_id']][0]->tp == $product['tp'])
                    ? $latestProducts[$product['product_id']][0]->batch_no
                    : $this->generate_batch_no();

                $purchase_product->expiry_date = $product['expiry_date'] ?? null;
                $purchase_product->save();
            }

            if (isset($bonusProductsData)) {
                foreach ($bonusProductsData as $product) {
                    $product['purchase_id'] = $purchase->id;

                    $pack_size = ProductPackSize::findOrFail($product['pack_size_id']);

                    $pack_size->update([
                        'quantity' => $pack_size->quantity + $product['quantity'],
                        'tp' => $product['tp'],
                        'vat' => $product['vat'],
                    ]);

                    $purchase_bonus_product = new PurchaseBonusProduct();
                    $purchase_bonus_product->purchase_id = $purchase->id;
                    $purchase_bonus_product->product_id = $product['product_id'];
                    $purchase_bonus_product->product_name = $product['product_name'] ?? null;
                    $purchase_bonus_product->pack_size_id = $product['pack_size_id'] ?? null;
                    $purchase_bonus_product->tp = 0;
                    $purchase_bonus_product->vat = $product['vat'] ?? null;
                    $purchase_bonus_product->cost = $product['cost'] ?? null;
                    $purchase_bonus_product->received_quantity = $product['quantity'];
                    $purchase_bonus_product->quantity = ($pack_size->name == 'Pack') ? $product['quantity'] * $pack_size->quantity : $product['quantity'];
                    $purchase_bonus_product->total = $product['total'] ?? 0;
                    $purchase_bonus_product->size = $product['size'] ?? null;
                    $purchase_bonus_product->generic_name = $product['generic_name'] ?? null;
                    $purchase_bonus_product->serial = $product['serial'] ?? null;
                    $purchase_bonus_product->stock = $product['stock'] ?? null;
                    $purchase_bonus_product->cost_price_preview = $product['cost_price_preview'] ?? null;
                    $purchase_bonus_product->item_id = $product['item_id'] ?? null;

                    $purchase_bonus_product->batch_no = (isset($latestProducts[$product['product_id']][0]) && $latestProducts[$product['product_id']][0]->tp == $product['tp'])
                        ? $latestProducts[$product['product_id']][0]->batch_no
                        : $this->generate_batch_no();

                    $purchase_bonus_product->expiry_date = $product['expiry_date'] ?? null;
                    $purchase_bonus_product->save();
                }
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Purchase updated successfully',
                'purchase' => $purchase,
            ]);

        } catch (Exception $e) {
            DB::rollback();
            return $this->responseWithError($e->getMessage());
        }
    }

    public function requestToSuspend($id)
    {
        DB::beginTransaction();
        try {
            $purchase = Purchase::findOrFail($id);
            if (isset($purchase->verify_status) && $purchase->verify_status != '0') {
                return response()->json(['success' => false, 'message' => 'Purchase cannot be Request to suspend Because already Action Done']);
            }

            $purchase->update([
                'suspend_request' => 1,
                'suspend_request_by' => Auth::id() ?? null,
            ]);


            // Commit the transaction
            DB::commit();

            return response()->json(['success' => true, 'message' => 'Purchase Suspend Request successfully Sent', 'purchase' => $purchase]);
        } catch (\Exception $e) {
            // Rollback the transaction on error
            DB::rollBack();

            return response()->json(['success' => false, 'message' => 'Error updating purchase Suspend Request', 'error' => $e->getMessage()]);
        }
    }
    public function suspended($id)
    {
        DB::beginTransaction();
        try {
            $purchase = Purchase::findOrFail($id);
            if (isset($purchase->verify_status) && $purchase->verify_status != '0') {
                return response()->json(['success' => false, 'message' => 'Purchase cannot be Suspended Because already Action Done']);
            }

            $purchase->update([
                'verify_status' => 2,
                'suspended_by' => Auth::id() ?? null,
            ]);


            // Commit the transaction
            DB::commit();

            return response()->json(['success' => true, 'message' => 'Purchase Suspended successfully', 'purchase' => $purchase]);
        } catch (\Exception $e) {
            // Rollback the transaction on error
            DB::rollBack();

            return response()->json(['success' => false, 'message' => 'Error updating purchase', 'error' => $e->getMessage()]);
        }
    }



    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::beginTransaction();
        try {
            // Find the purchase
            $purchase = Purchase::findOrFail($id);

            // First, handle the product pack sizes (revert the quantities)
            foreach ($purchase->purchaseProducts as $product) {
                if ($product->pack_size_id) {
                    $pack_size = ProductPackSize::find($product->pack_size_id);
                    if ($pack_size) {
                        $pack_size->quantity -= $product->received_quantity;
                        $pack_size->save();
                    }
                }
            }

            foreach ($purchase->purchaseBonusProducts as $product) {
                if ($product->pack_size_id) {
                    $pack_size = ProductPackSize::find($product->pack_size_id);
                    if ($pack_size) {
                        $pack_size->quantity -= $product->received_quantity;
                        $pack_size->save();
                    }
                }
            }

            // Delete all related records
            $purchase->purchaseProducts()->delete();
            $purchase->purchaseBonusProducts()->delete();

            // Finally delete the purchase itself
            $purchase->delete();

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Purchase deleted successfully'
            ]);

        } catch (Exception $e) {
            DB::rollback();
            return response()->json([
                'success' => false,
                'message' => 'Error deleting purchase: ' . $e->getMessage()
            ], 500);
        }
    }


    /**
     * search resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Resources\Json\AnonymousResourceCollection
     */
    public function search(Request $request)
    {
        $term = $request->term;
        $query = Purchase::with('supplier', 'purchasePayments', 'user');

        if ($request->startDate && $request->endDate) {
            $query = $query->whereBetween('purchase_date', [$request->startDate, $request->endDate]);
        }

        $query = $query->where(function ($query) use ($term) {
            $query->where('purchase_no', 'LIKE', '%' . $term . '%')
                ->orWhere('sub_total', 'LIKE', '%' . $term . '%')
                ->orWhere('transport', 'LIKE', '%' . $term . '%')
                ->orWhere('discount', 'LIKE', '%' . $term . '%')
                ->orWhere('po_reference', 'LIKE', '%' . $term . '%')
                ->orWhere('payment_terms', 'LIKE', '%' . $term . '%')
                ->orWhereHas('supplier', function ($newQuery) use ($term) {
                    $newQuery->where('name', 'LIKE', '%' . $term . '%')
                        ->orWhere('company_name', 'LIKE', '%' . $term . '%');
                    //  ->orWhere('phone', 'LIKE', '%'.$term.'%');
                });
        });

        return PurchaseListResource::collection($query->latest()->paginate($request->perPage));
    }

    // notify supplier

    // store purchase payment

    private function responseWithSuccess($message)
    {
        return response()->json([
            'success' => true,
            'message' => $message,
        ]);
    }

    // Method to return an error response
    private function responseWithError($message)
    {
        return response()->json([
            'success' => false,
            'message' => $message,
        ]);
    }

    public function allPurchasesPaginated(Request $request)
    {
        $search = $request->input('search', '');

        $query = Purchase::with(
            // 'purchaseProducts',
            // 'stockBatches',
            'mrr',
            'supplier',
            'paymentMethod',
            'branch'
        )
            ->where('verify_status', '!=', 2);

        if ($search) {
            // $query->where('purchase_code', 'LIKE', '%' . $search . '%')
            //     ->orWhere('note', 'LIKE', '%' . $search . '%');

            $query->whereHas('supplier', function ($supplierQuery) use ($search) {
                $supplierQuery->where('company_name', 'LIKE', '%' . $search . '%');
            })->orWhereHas('mrr', function ($mrrQuery) use ($search) {
                $mrrQuery->where('name', 'LIKE', '%' . $search . '%');
            });

            // $query->where(function ($q) use ($search) {
            //     $q->where('purchase_code', 'LIKE', '%' . $search . '%')
            //         ->orWhere('note', 'LIKE', '%' . $search . '%')
            //         ->orWhereHas('supplier', function ($supplierQuery) use ($search) {
            //             $supplierQuery->where('company_name', 'LIKE', '%' . $search . '%');
            //         });
            // });
        }
        $perPage = $request->input('paginate', 10);
        $purchases = $query->latest()->paginate($perPage);

        $response = $purchases->toArray();
        $response['search'] = $search;

        return response()->json($response);
    }
    public function allVerifyPurchasesPaginated(Request $request)
    {


        $data['total'] = Purchase::where('verify_status', 0)->sum('total');
        $data['amount_due'] = Purchase::where('verify_status', 0)->sum('amount_due');
        $data['paid_amount'] = Purchase::where('verify_status', 0)->sum('paid_amount');


        $search = $request->input('search', '');

        $query = Purchase::with('purchaseProducts', 'stockBatches', 'mrr', 'supplier', 'paymentMethod', 'branch', 'suspendRequestUser')
            ->where(function ($query) {
                $query->where('verify_status', 0)
                    ->orWhereNull('verify_status');
            });

        if ($search) {
            $query->where('purchase_code', 'LIKE', '%' . $search . '%')
                ->orWhere('note', 'LIKE', '%' . $search . '%');
        }
        $perPage = $request->input('paginate', 10);
        $data['purchases'] = $query->latest()->paginate($perPage);

        return response()->json($data);
    }

    public function productSearch(Request $request)
    {
        // $term = rtrim($request->term, "-end-");

        $search = explode('-end-', $request->term)[0];
        $term = $search;



        $branch_id = $request->branch_id;
        $supplier_id = $request->supplier_id;

        $products = Product::with([
            'category',
            'supplier',
            'packSize',
            'productVariationAttributes',
            'productVariations',
            'productPrices',
            'productInventories',
            'productLocations',
            'productImages',
            'stockBatches' => function ($query) use ($branch_id) {
                $query->where('balanced_quantity', '>', 0);
                // ->whereHas('purchase', function ($purchaseQuery) use ($branch_id) {
                //     $purchaseQuery->where('branch_id', $branch_id);
                // })

            }
        ])
            ->where(function ($query) use ($term) {
                $query->where('name', 'LIKE', $term . '%')
                    ->orWhere('product_id', 'LIKE', $term . '%')
                    ->orWhereHas('category', function ($newQuery) use ($term) {
                        $newQuery->where('name', 'LIKE', $term . '%');
                    });
            })
            ->when($supplier_id, function ($query) use ($supplier_id) {
                $query->where('supplier_id', $supplier_id);
            })
            ->whereHas('packSize')
            ->whereHas('productPrices')
            ->orderBy('name', 'ASC')
            ->take(30)
            ->get();

        $products = collect($products)->map(function ($q) {
            if (isset($q->productPrices)) {
                $q->productPrices->trade_price = isset($q->packSize->name) && $q->packSize->name == 'Pack' ? $q->packSize->tp : $q->productPrices->trade_price;
                $q->productPrices->vat = isset($q->packSize->name) && $q->packSize->name == 'Pack' ? $q->packSize->vat : $q->productPrices->vat;
            }
            return $q;
        });
        return ['products' => $products, 'search' => $search];
    }
}
