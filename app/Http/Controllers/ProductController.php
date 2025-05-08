<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Models\Product;
use App\Models\ProductPackSize;
use App\Models\ProductPrice;
use App\Models\ProductImage;

use Intervention\Image\Facades\Image as Image;

use App\Http\Resources\ProductListingResource;
use App\Http\Resources\ProductResource;

class ProductController extends Controller
{
       /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

     public function index(Request $request)
     {
         $query = Product::with(['category', 'supplier', 'subCategory', 'packSizes', 'prices', 'images']);


         // Search filter
         if ($request->has('search')) {
             $query->where('name', 'LIKE', '%' . $request->search . '%');
         }

         // Sorting
         $sortBy = $request->get('sortBy', 'name');
         $orderBy = $request->get('orderBy', 'asc');
         $query->orderBy($sortBy, $orderBy);

         // Pagination
         $perPage = $request->get('per_page', 10);
         $products = $query->paginate($perPage);

         // Transform data to include image URLs
         $data = $products->map(function ($product) {
             return array_merge($product->toArray(), [
                 'image_url' => $product->image ? asset('/images/products/' . $product->image) : ''
             ]);
         });

         // Return paginated data
         return response()->json([
             'data' => $data,
             'total' => $products->total(),
             'current_page' => $products->currentPage(),
             'per_page' => $products->perPage(),
         ], 200);
     }


     public function productsAll(){
        try {
            $data = Product::with(['category', 'subCategory'])->get();

            if ($data->isEmpty()) {
                return response()->json([
                    'message' => 'No products found.',
                    'data' => []
                ], 404);  // Optionally use 200 with an empty array if preferred
            }

            return response()->json([
                'data' => $data
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to retrieve products.',
                'message' => $e->getMessage()
            ], 500);
        }
    }


    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

     public function store(Request $request)
     {
         DB::beginTransaction();
         try {
             // Decode JSON strings into arrays if needed
             $productData = is_string($request->input('products')) ? json_decode($request->input('products'), true) : $request->input('products');
             $packSizeData = is_string($request->input('product_pack_sizes')) ? json_decode($request->input('product_pack_sizes'), true) : $request->input('product_pack_sizes');
             $productPricesData = is_string($request->input('product_prices')) ? json_decode($request->input('product_prices'), true) : $request->input('product_prices');

             // CREATE OR UPDATE PRODUCT
             if ($productData) {
                 $product = isset($productData['id']) ? Product::findOrFail($productData['id']) : new Product();
                 $product->categories_id = $productData['categories_id'] ?? null;
                 $product->subcategories_id = $productData['subcategories_id'] ?? null;
                 $product->suppliers_id = $productData['suppliers_id'] ?? null;
                 $product->name = $productData['name'] ?? null;
                 $product->batch_no = $productData['batch_no'] ?? null;
                 $product->tags = $productData['tags'] ?? null;
                 $product->manufacturer_id = $productData['manufacturer_id'] ?? null;
                 $product->description = $productData['description'] ?? null;
                 $product->generic_id = $productData['generic_id'] ?? null;
                 $product->is_ecommerce_item = isset($productData['is_ecommerce_item']) && $productData['is_ecommerce_item'] ? 1 : 0;
                 $product->is_barcoded = isset($productData['is_barcoded']) && $productData['is_barcoded'] ? 1 : 0;
                 $product->save();
             } else {
                 return response()->json(['message' => 'Product data is required'], 400);
             }

             // CREATE OR UPDATE PRODUCT PACK SIZE
             if ($packSizeData) {
                 ProductPackSize::updateOrCreate(
                     ['product_id' => $product->id],
                     [
                         'name' => $packSizeData['name'] ?? null,
                         'quantity' => $packSizeData['quantity'] ?? null,
                         'tp' => $packSizeData['tp'] ?? null,
                         'vat_percent' => $packSizeData['vat_percent'] ?? null,
                         'vat' => $packSizeData['vat'] ?? null,
                         'selling_price' => $packSizeData['selling_price'] ?? null,
                         'default_unit' => isset($packSizeData['default_unit']) && $packSizeData['default_unit'] ? 1 : 0,
                     ]
                 );
             }

             // CREATE OR UPDATE PRODUCT PRICES
             if ($productPricesData) {
                 ProductPrice::updateOrCreate(
                     ['product_id' => $product->id],
                     [
                         'quantity' => $productPricesData['quantity'] ?? null,
                         'trade_price' => $productPricesData['trade_price'] ?? null,
                         'vat_percent' => $productPricesData['vat_percent'] ?? null,
                         'vat' => $productPricesData['vat'] ?? null,
                         'cost_price_without_tax' => $productPricesData['cost_price_without_tax'] ?? null,
                         'selling_price' => $productPricesData['selling_price'] ?? null,
                         'wholesale' => $productPricesData['wholesale'] ?? null,
                         'wholesale_type' => $productPricesData['wholesale_type'] ?? null,
                         'disable_from_price_rules' => isset($productPricesData['disable_from_price_rules']) && $productPricesData['disable_from_price_rules'] ? 1 : 0,
                         'is_editable_in_sale' => isset($productPricesData['is_editable_in_sale']) && $productPricesData['is_editable_in_sale'] ? 1 : 0,
                     ]
                 );
             }

             // DELETE OLD IMAGES AND UPLOAD NEW ONES
             if ($request->hasFile('product_images')) {
                 // Delete existing images
                 $existingProductImages = ProductImage::where('product_id', $product->id)->get();
                 foreach ($existingProductImages as $existingImage) {
                     Storage::disk('public')->delete($existingImage->path);
                     $existingImage->delete();
                 }

                 // Upload new images
                 foreach ($request->file('product_images') as $image) {
                     $path = $image->store('product_images', 'public');
                     ProductImage::create([
                         'product_id' => $product->id,
                         'path' => $path
                     ]);
                 }
             }

             if ($request->hasFile('product_images')) {
                // Log request data (optional debugging)
                \Log::info('Product images detected', ['files' => $request->file('product_images')]);

                // Delete existing images
                $existingProductImages = ProductImage::where('product_id', $product->id)->get();
                foreach ($existingProductImages as $existingImage) {
                    Storage::disk('public')->delete($existingImage->path);
                    $existingImage->delete();
                }

                // Upload new images
                foreach ($request->file('product_images') as $image) {
                    if ($image->isValid()) {
                        $filename = time() . '_' . $image->getClientOriginalName();
                        $path = $image->storeAs('product_images', $filename, 'public');

                        // Save image path to the database
                        ProductImage::create([
                            'product_id' => $product->id,
                            'path' => 'storage/' . $path // Store as `storage/product_images/filename.jpg`
                        ]);

                        \Log::info('Image uploaded successfully', ['path' => $path]);
                    } else {
                        \Log::error('Invalid image file detected');
                    }
                }
            }


             // Fetch Product with Relations
             $products = Product::with('category', 'supplier', 'subCategory', 'packSizes', 'prices', 'images')->where('id', $product->id)->first();

             DB::commit();

             return response()->json(['message' => 'Product added successfully', 'status' => 'success', 'product' => $products], 201);
         } catch (Exception $e) {
             DB::rollback();
             return response()->json(['message' => 'Error: ' . $e->getMessage()], 500);
         }
     }

    // public function store(Request $request)
    // {
    //     DB::beginTransaction();
    //     try {

    //         $productData = $this->decodeJsonInput($request->input('products'));
    //         $packSizeData = $this->decodeJsonInput($request->input('product_pack_sizes'));
    //         $productPricesData = $this->decodeJsonInput($request->input('product_prices'));
    //         $existingProductImages = $this->decodeJsonInput($request->input('product_images'));

    //         $product = $this->createOrUpdateProduct($productData, $request);

    //         if ($packSizeData) {
    //             $this->createOrUpdatePackSize($packSizeData, $product);
    //         }

    //         if ($productPricesData) {
    //             $this->createOrUpdateProductPrices($productPricesData, $product);
    //         }


    //         if ($request->hasFile('product_images')) {
    //             $this->handleProductImages($request, $product);
    //         }

    //         // $products = Product::with('category', 'supplier')->where('id', $product->id)->first();
    //         // $products->tags = isset($products->tags) ? unserialize($products->tags) : [];

    //         DB::commit();

    //         return response()->json([
    //             'message' => 'Product added successfully',
    //             'status' => 'success'
    //         ]);
    //     } catch (Exception $e) {
    //         DB::rollback();
    //         return response()->json([
    //             'message' => $e->getMessage(),
    //             'status' => 'error'
    //         ], 500);
    //     }
    // }

    // private function decodeJsonInput($input)
    // {
    //     if (is_string($input)) {
    //         return json_decode($input, true);
    //     }
    //     return $input;
    // }

    // private function createOrUpdateProduct($productData, $request)
    // {
    //     if ($productData) {
    //         if (isset($productData['id'])) {
    //             $product = Product::findOrFail($productData['id']);
    //             $product->update([
    //                 'categories_id' => $productData['categories_id'] ?? null,
    //                 'subcategories_id' => $productData['subcategories_id'] ?? null,
    //                 'suppliers_id' => $productData['suppliers_id'] ?? null,
    //                 'name' => $productData['name'] ?? null,
    //                 'product_id' => $productData['batch_no'] ?? null,
    //                 'tags' => $productData['tags'] ?? null,
    //                 'manufacturer_id' => $productData['manufacturer_id'] ?? null,
    //                 'description' => $productData['description'] ?? null,
    //                 'generic_id' => $productData['generic_id'] ?? null,
    //                 'is_ecommerce_item' => isset($productData['is_ecommerce_item']) && $productData['is_ecommerce_item'] ? 1 : 0,
    //                 'is_barcoded' => isset($productData['is_barcoded']) && $productData['is_barcoded'] ? 1 : 0,
    //             ]);
    //         } else {
    //             $product = new Product();
    //             $product->batch_no = $productData['batch_no'] ?? null;
    //             $product->categories_id = $productData['categories_id'] ?? null;
    //             $product->subcategories_id = $productData['subcategories_id'] ?? null;
    //             $product->suppliers_id = $productData['suppliers_id'] ?? null;
    //             $product->name = $productData['name'] ?? null;
    //             $product->product_id = $productData['product_id'] ?? null;
    //             $product->tags = $productData['tags'] ?? null;
    //             $product->manufacturer_id = $productData['manufacturer_id'] ?? null;
    //             $product->description = $productData['description'] ?? null;
    //             $product->generic_id = $productData['generic_id'] ?? null;
    //             $product->is_ecommerce_item = isset($productData['is_ecommerce_item']) && $productData['is_ecommerce_item'] ? 1 : 0;
    //             $product->is_barcoded = isset($productData['is_barcoded']) && $productData['is_barcoded'] ? 1 : 0;
    //             $product->save();
    //         }
    //     } else {
    //         if (isset($request->product_id)) {
    //             $product = Product::find($request->product_id);
    //             if (!$product) {
    //                 throw new Exception('Product not found');
    //             }
    //         } else {
    //             throw new Exception('Product ID is required');
    //         }
    //     }
    //     return $product;
    // }

    // private function createOrUpdatePackSize($packSizeData, $product)
    // {
    //     $packSizeData['product_id'] = $product->id;
    //     ProductPackSize::updateOrCreate(
    //         ['product_id' => $packSizeData['product_id']],
    //         [
    //             'product_id' => $packSizeData['product_id'] ?? null,
    //             'name' => $packSizeData['name'] ?? null,
    //             'quantity' => $packSizeData['quantity'] ?? null,
    //             'tp' => $packSizeData['tp'] ?? null,
    //             'vat_percent' => $packSizeData['vat_percent'] ?? null,
    //             'vat' => $packSizeData['vat'] ?? null,
    //             'selling_price' => $packSizeData['selling_price'] ?? null,
    //             'default_unit' => isset($packSizeData['default_unit']) && $packSizeData['default_unit'] ? 1 : 0,
    //         ]
    //     );
    // }

    // private function createOrUpdateProductPrices($productPricesData, $product)
    // {
    //     $productPricesData['product_id'] = $product->id;
    //     $product->status = 1;
    //     $product->update();

    //     ProductPrice::updateOrCreate(
    //         ['product_id' => $productPricesData['product_id']],
    //         [
    //             'product_id' => $productPricesData['product_id'] ?? null,
    //             'cost_price_without_tax' => $productPricesData['cost_price_without_tax'] ?? null,
    //             'selling_price' => $productPricesData['selling_price'] ?? null,
    //             'trade_price' => $productPricesData['trade_price'] ?? null,
    //             'vat' => $productPricesData['vat'] ?? null,
    //             'wholesale' => $productPricesData['wholesale'] ?? null,
    //             'wholesale_type' => $productPricesData['wholesale_type'] ?? null,
    //             'disable_from_price_rules' => isset($productPricesData['disable_from_price_rules']) && $productPricesData['disable_from_price_rules'] ? 1 : 0,
    //             'allow_price_override_regardless_of_permissions' => isset($productPricesData['allow_price_override_regardless_of_permissions']) && $productPricesData['allow_price_override_regardless_of_permissions'] ? 1 : 0,
    //             'prices_include_tax' => isset($productPricesData['prices_include_tax']) && $productPricesData['prices_include_tax'] ? 1 : 0,
    //             'only_allow_items_to_be_sold_in_whole_numbers' => isset($productPricesData['only_allow_items_to_be_sold_in_whole_numbers']) && $productPricesData['only_allow_items_to_be_sold_in_whole_numbers'] ? 1 : 0,
    //             'change_cost_price_during_sale' => isset($productPricesData['change_cost_price_during_sale']) && $productPricesData['change_cost_price_during_sale'] ? 1 : 0,
    //             'override_default_commission' => isset($productPricesData['override_default_commission']) && $productPricesData['override_default_commission'] ? 1 : 0,
    //             'override_default_tax' => isset($productPricesData['override_default_tax']) && $productPricesData['override_default_tax'] ? 1 : 0,
    //             'is_editable_in_sale' => isset($productPricesData['is_editable_in_sale']) && $productPricesData['is_editable_in_sale'] ? 1 : 0,
    //         ]
    //     );
    // }

    // private function handleProductImages($request, $product)
    // {
    //     $existingProductImages = $product->images()->get();
    //     foreach ($existingProductImages as $existingImage) {
    //         if (Storage::disk('public')->exists($existingImage->path)) {
    //             Storage::disk('public')->delete($existingImage->path);
    //         }
    //         $existingImage->delete();
    //     }

    //     foreach ($request->file('product_images') as $image) {
    //         $path = $image->store('product_images', 'public');
    //         ProductImage::create([
    //             'product_id' => $product->id,
    //             'path' => $path
    //         ]);
    //     }
    // }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try {
            $product = Product::where('id', $id)->with(['category', 'supplier', 'subCategory', 'packSizes', 'prices', 'images'])->first();

            if (!$product) {
                return response()->json([
                    'success' => false,
                    'message' => 'Product not found',
                ], 404);
            }

            // Add the image URL to the product array if the image exists
            $productData = $product->toArray();
            $productData['image_url'] = $product->image ? asset('/images/products/' . $product->image) : '';

            return response()->json([
                'success' => true,
                'data' => $productData,
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'An error occurred: ' . $e->getMessage(),
            ], 500);
        }
    }



    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        DB::beginTransaction();
        try {
            $product = Product::findOrFail($id);

            // Decode JSON data if necessary
            $productData = is_string($request->input('products')) ? json_decode($request->input('products'), true) : $request->input('products');
            $packSizeData = is_string($request->input('product_pack_sizes')) ? json_decode($request->input('product_pack_sizes'), true) : $request->input('product_pack_sizes');
            $productPricesData = is_string($request->input('product_prices')) ? json_decode($request->input('product_prices'), true) : $request->input('product_prices');

            // UPDATE PRODUCT
            if ($productData) {
                $product->update([
                    'categories_id' => $productData['categories_id'] ?? $product->categories_id,
                    'subcategories_id' => $productData['subcategories_id'] ?? $product->subcategories_id,
                    'suppliers_id' => $productData['suppliers_id'] ?? $product->suppliers_id,
                    'name' => $productData['name'] ?? $product->name,
                    'batch_no' => $productData['batch_no'] ?? $product->batch_no,
                    'tags' => $productData['tags'] ?? $product->tags,
                    'manufacturer_id' => $productData['manufacturer_id'] ?? $product->manufacturer_id,
                    'description' => $productData['description'] ?? $product->description,
                    'generic_id' => $productData['generic_id'] ?? $product->generic_id,
                    'is_ecommerce_item' => isset($productData['is_ecommerce_item']) ? (int) $productData['is_ecommerce_item'] : $product->is_ecommerce_item,
                    'is_barcoded' => isset($productData['is_barcoded']) ? (int) $productData['is_barcoded'] : $product->is_barcoded,
                ]);
            }

            // UPDATE PRODUCT PACK SIZE
            if ($packSizeData) {
                ProductPackSize::updateOrCreate(
                    ['product_id' => $product->id],
                    [
                        'name' => $packSizeData['name'] ?? null,
                        'quantity' => $packSizeData['quantity'] ?? null,
                        'tp' => $packSizeData['tp'] ?? null,
                        'vat_percent' => $packSizeData['vat_percent'] ?? null,
                        'vat' => $packSizeData['vat'] ?? null,
                        'selling_price' => $packSizeData['selling_price'] ?? null,
                        'default_unit' => isset($packSizeData['default_unit']) ? (int) $packSizeData['default_unit'] : 0,
                    ]
                );
            }

            // UPDATE PRODUCT PRICES
            if ($productPricesData) {
                ProductPrice::updateOrCreate(
                    ['product_id' => $product->id],
                    [
                        'quantity' => $productPricesData['quantity'] ?? null,
                        'trade_price' => $productPricesData['trade_price'] ?? null,
                        'vat_percent' => $productPricesData['vat_percent'] ?? null,
                        'vat' => $productPricesData['vat'] ?? null,
                        'cost_price_without_tax' => $productPricesData['cost_price_without_tax'] ?? null,
                        'selling_price' => $productPricesData['selling_price'] ?? null,
                        'wholesale' => $productPricesData['wholesale'] ?? null,
                        'wholesale_type' => $productPricesData['wholesale_type'] ?? null,
                        'disable_from_price_rules' => isset($productPricesData['disable_from_price_rules']) ? (int) $productPricesData['disable_from_price_rules'] : 0,
                        'is_editable_in_sale' => isset($productPricesData['is_editable_in_sale']) ? (int) $productPricesData['is_editable_in_sale'] : 0,
                    ]
                );
            }

            // UPDATE PRODUCT IMAGES
            if ($request->hasFile('product_images')) {
                // Delete existing images
                $existingProductImages = ProductImage::where('product_id', $product->id)->get();
                foreach ($existingProductImages as $existingImage) {
                    Storage::disk('public')->delete($existingImage->path);
                    $existingImage->delete();
                }

                // Upload new images
                foreach ($request->file('product_images') as $image) {
                    if ($image->isValid()) {
                        $filename = time() . '_' . $image->getClientOriginalName();
                        $path = $image->storeAs('product_images', $filename, 'public');
                        ProductImage::create([
                            'product_id' => $product->id,
                            'path' => 'storage/' . $path,
                        ]);
                    }
                }
            }

            // Fetch updated product with relations
            $updatedProduct = Product::with('category', 'supplier', 'subCategory', 'packSizes', 'prices', 'images')->where('id', $product->id)->first();

            DB::commit();

            return response()->json(['message' => 'Product updated successfully', 'status' => 'success', 'product' => $updatedProduct], 200);
        } catch (Exception $e) {
            DB::rollback();
            return response()->json(['message' => 'Error: ' . $e->getMessage()], 500);
        }
    }

    public function productSearch(Request $request)
    {
        $search = explode('-end-', $request->term)[0];
        $term = trim($search);
        $supplier_id = $request->supplier_id;

        // Split by space to support multiple keywords like "Rice চাল"
        $keywords = preg_split('/[\s\-–]+/u', $term);

        $products = Product::with([
            'category',
            'supplier',
            'subCategory',
            'packSizes',
            'prices',
            'images',
        ])
        ->where(function ($query) use ($keywords) {
            foreach ($keywords as $word) {
                $query->where(function ($q) use ($word) {
                    $q->where('name', 'LIKE', '%' . $word . '%')
                    ->orWhere('product_id', 'LIKE', '%' . $word . '%')
                    ->orWhereHas('category', function ($subQuery) use ($word) {
                        $subQuery->where('name', 'LIKE', '%' . $word . '%');
                    });
                });
            }
        })
        ->when($supplier_id, function ($query) use ($supplier_id) {
            $query->where('supplier_id', $supplier_id);
        })
        ->whereHas('packSizes')
        ->whereHas('prices')
        ->orderBy('name', 'ASC')
        ->take(30)
        ->get();

        $products = collect($products)->map(function ($q) {
            if (isset($q->prices)) {
                $q->prices->trade_price = isset($q->packSizes->name) && $q->packSizes->name == 'Pack'
                    ? $q->packSizes->tp
                    : $q->prices->trade_price;
                $q->prices->vat = isset($q->packSizes->name) && $q->packSizes->name == 'Pack'
                    ? $q->packSizes->vat
                    : $q->prices->vat;
            }
            return $q;
        });

        return ['products' => $products, 'search' => $search];
    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function allProducts()
    {
        $products = Product::with('proSubCategory.category', 'productUnit', 'productTax',
        'productBrand', 'productTax')->where('status', 1)->latest()->get();

        return ProductSelectResource::collection($products);
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

    public function destroy($id)
    {
        Product::findOrFail($id)->delete();
        return response()->json('Product deleted successfully', 200);
    }

}
