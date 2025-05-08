<?php

namespace App\Http\Controllers;

use Exception;
use App\Models\Product;
use App\Rules\MinTotal;
use App\Models\SalesManageManageManageManage;
use App\Models\SalesManageManageAdd;
use Illuminate\Http\Request;
use App\Models\SalesManage;
use App\Models\SalesAdd;
use App\Rules\SalesManageManageTotalPaid;
use App\Models\AccountTransaction;
use App\Http\Controllers\Controller;
use App\Notifications\SalesManageManageNotification;
use App\Http\Resources\SalesListResource;
use App\Http\Resources\PurchaseProductResource;
use App\Http\Resources\PurchaseProductsResource;
use App\Notifications\SalesManageManagePaymentNotification;
use Illuminate\Support\Facades\DB;

class SalesController extends Controller
{
    // define middleware
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        // Initialize the query with eager loading
        $query = SalesManage::with(['customer', 'salesAdd']);

        // Apply search filter on the customer's name
        if ($request->has('q')) {
            $searchQuery = $request->input('q');
            $query->whereHas('customer', function ($q) use ($searchQuery) {
                $q->where('name', 'LIKE', '%' . $searchQuery . '%');
            });
        }

        // Sorting by customer name or other fields
        $sortBy = $request->get('sortBy');
        $orderBy = $request->get('orderBy', 'asc');
        if ($sortBy === 'name') {
            $query->join('customers', 'sales_manage.customer_id', '=', 'customers.id')
                ->select('sales_manage.*')
                ->orderBy('customers.name', $orderBy);
        } else {
            $query->orderBy($sortBy ?? 'id', $orderBy);
        }

        // Pagination settings
        $perPage = $request->get('per_page', 10);
        $products = $query->paginate($perPage);

        // Return paginated data in response
        return response()->json([
            'data' => $products->items(),
            'total' => $products->total(),
            'current_page' => $products->currentPage(),
            'per_page' => $products->perPage(),
        ], 200);
    }


    public function salesDateWiseSearch(Request $request)
    {
        $request->validate([
            'date_from' => 'required|date',
            'date_to' => 'required|date|after_or_equal:date_from',
        ]);

        $date_from = $request->date_from;
        $date_to = $request->date_to;

        $sales = SalesAdd::with(['salesManage.customer', 'salesManage', 'product', 'product.category', 'product.subCategory'])
            ->whereBetween('created_at', [$date_from, $date_to])
            ->get();

        $salesData = $sales->map(function ($sale) {
            return [
                'date' => $sale->created_at->format('Y-m-d'),
                'customer_id' => $sale->salesManage->customer->id ?? null,
                'customer_name' => $sale->salesManage->customer->name ?? null,
                'sales_details' => [
                    'subcategory' => $sale->product->subCategory->name ?? null,
                    'category' => $sale->product->category->name ?? null,
                    'product_name' => $sale->product->name ?? null,
                    'quantity' => $sale->quantity,
                    'unit_price' => $sale->sales_price,
                    'subtotal' => $sale->quantity * $sale->sales_price,
                    'stock' => $sale->product->quantity ?? null,
                    'sold' => $sale->quantity,
                    'remaining' => $sale->product->inventory_count ?? null,
                    'status' => $sale->status ?? null,
                ],
                'gross_amount' => $sale->salesManage->gross_amount ?? null,
                'discount' => $sale->salesManage->discount ?? null,
                'net_amount' => $sale->salesManage->net_amount ?? null,
                'paid_amount' => $sale->salesManage->paidamount ?? null,
                'due_amount' => $sale->salesManage->dueamount ?? null,
            ];
        });

        return response()->json(['data' => $salesData]);
    }



    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        try {
            // Generate purchase code
            $code = 1;
            $lastPurchase = SalesManage::latest()->first();
            if ($lastPurchase) {
                $code = $lastPurchase->purchase_no + 1;
            }

            // Decode selected products if it's a string
            $SalesDetails = is_string($request->input('cart'))
                ? json_decode($request->input('cart'), true)
                : $request->input('cart');
                
                

            // Ensure SalesDetails is not empty
            if (empty($SalesDetails)) {
                return $this->responseWithError('No products selected for purchase.');
            }

            // Create purchase
            $purchase = SalesManage::create([
                'customer_id' => $request->customer_id ?? null,
                'purchase_no' => $code, // Use generated purchase code
                'date' => $request->date ?? null,
                'gross_amount' => $request->gross_amount ?? null,
                'net_amount' => $request->net_amount ?? null,
                'discount' => $request->discount ?? null,
                'paidamount' => $request->paidAmount ?? null,
                'dueamount' => $request->dueAmount ?? null,
            ]);

            // Store purchase products
            foreach ($SalesDetails as $selectedProduct) {
                // Check if the product ID exists
                if (!isset($selectedProduct['product_id'])) {
                    return $this->responseWithError('Product ID is missing in one or more selected products.');
                }

                $product = Product::find($selectedProduct['product_id']);
                
               // dd($product);
                if ($product) {
                    // Calculate new purchase price for product
                    $totalQty = $product->quantity - $selectedProduct['quantity'];

                    // Update product stock
                    $product->update([
                        'quantity' => $totalQty
                    ]);

                    // Add to sales details (ensure product_id and related fields are correct)
                    SalesAdd::create([
                        'sales_manage_id' => $purchase->id, 
                        'product_id' => $selectedProduct['product_id'], 
                        'quantity' => $selectedProduct['quantity'],
                        'sales_price' => $selectedProduct['sell_price'] ?? null,
                    ]);
                } else {
                    return $this->responseWithError("Product with ID {$selectedProduct['product_id']} not found.");
                }
            }

            return $this->responseWithSuccess('Purchase added successfully', [
                'id' => $purchase->id,
            ]);
        } catch (Exception $e) {
            return $this->responseWithError($e->getMessage());
        }
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
            // Fetch sales record along with related customer and sales items (with products)
            $salesmanage = SalesManage::where('id', $id)
                ->with('customer', 'salesAdd.product')
                ->firstOrFail();

            return $this->responseWithSuccess($salesmanage);
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
        try {
            $purchase = SalesManage::where('id', $id)->with('supplier', 'purchaseProducts', 'salesAdds')->firstOrFail();


            // Ensure selectedProducts is an array
            if (is_string($request->selectedProducts)) {
                $selectedProducts = json_decode($request->selectedProducts, true);
            } else {
                $selectedProducts = $request->selectedProducts;
            }

            if (!is_array($selectedProducts)) {
                return $this->responseWithError('Selected products must be an array.');
            }

            // Delete current products
            $purchase->purchaseProducts->each->delete();

            // Store SalesManageManage products
            foreach ($selectedProducts as $key => $selectedProduct) {
                $product = Product::where('id', $selectedProduct['id'])->firstOrFail();

                 // Calculate new purchase price for product
                 $currentStockPrice = $product->inventory_count * $product->buyprice;
                 $newStockPrice = $selectedProduct['qty'] * $selectedProduct['purchase_price'];
                 $totalStockPrice = $currentStockPrice + $newStockPrice;
                 $totalQty = $product->inventory_count + $selectedProduct['qty'];
                 $unitCost = $totalStockPrice / $totalQty;

                 $newInventory = $product->inventory_count - $selectedProduct['qty'] + $selectedProduct['qty'];

                 // Update product stock and purchase price
                 $product->update([
                     'buyprice' => $unitCost,
                     'inventory_count' => $newInventory,
                 ]);


                // Store products
                SalesAdd::create([
                    'purchase_manage_id' => $purchase->id,
                    'product_id' => $product->id,
                    'product_quantity' => $selectedProduct['qty'],
                    'quantity' => $selectedProduct['qty'],
                    'purchase_price' => $selectedProduct['purchase_price'],
                    'sales_price' => $selectedProduct['sales_price'],
                    'amount' => $selectedProduct['amount'],
                ]);
            }

            // Update SalesManageManage
            $purchase->update([
                'supplier_id' => $request->supplier_id,
                'date' => $request->date,
                'gross_amount' => $request->gross_amount,
                'discount' => $request->discount,
                'net_amount' => $request->net_amount,
                'paidamount' => $request->paidamount,
                'dueamount' => $request->dueamount
            ]);

         //   dd($unitCost);

            return $this->responseWithSuccess('SalesManageManage updated successfully', [
                'id' => $purchase->id,
            ]);
        } catch (\Exception $e) {
            return $this->responseWithError($e->getMessage());
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
        try {
            // Find the purchase with related purchase adds
            $sales = salesManage::where('id', $id)->with('salesAdd')->first();

            if (!$sales) {
                return $this->responseWithError('Sales not found!');
            }

            // Delete related sales adds
            $sales->salesAdd()->delete();

            // Delete purchase
            $sales->delete();

            return $this->responseWithSuccess('Sales deleted successfully!');
        } catch (Exception $e) {
            return $this->responseWithError($e->getMessage());
        }
    }




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
}
