<?php

namespace App\Http\Controllers;

use App\Models\Supplier;

use Exception;

use Illuminate\Http\Request;

use App\Http\Resources\SupplierResource;

class SupplierController extends Controller
{
    public function Supplier_all()
    {
        $Supplier = Supplier::all();
        return response()->json($Supplier);
    }

    public function index(Request $request)
    {
        $query = Supplier::query();

        // Search filter
        if ($request->has('q')) {
            $query->where(function ($q) use ($request) {
                $q->where('name', 'LIKE', '%' . $request->q . '%')
                    ->orWhere('address', 'LIKE', '%' . $request->q . '%')
                    ->orWhere('phone', 'LIKE', '%' . $request->q . '%')
                    ->orWhere('email', 'LIKE', '%' . $request->q . '%');
            });
        }

        // Sorting
        $sortBy = $request->get('sortBy', 'name'); // Default sorting column
        $orderBy = $request->get('orderBy', 'asc'); // Default sorting order
        $query->orderBy($sortBy, $orderBy);

        // Pagination
        $perPage = $request->get('per_page', 10);
        $customers = $query->paginate($perPage);

        return response()->json([
            'data' => $customers->items(),
            'total' => $customers->total(),
            'current_page' => $customers->currentPage(),
            'per_page' => $customers->perPage(),
        ], 200);
    }

    public function supplierAll(){
        try {
            $data = Supplier::all();

            if ($data->isEmpty()) {
                return response()->json([
                    'message' => 'No supplier found.',
                    'data' => []
                ], 404);  // Optionally use 200 with an empty array if preferred
            }

            return response()->json([
                'data' => $data
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to retrieve supplier.',
                'message' => $e->getMessage()
            ], 500);
        }
    }



    public function store(Request $request)
    {
        $Supplier = Supplier::create($request->all());
        return response()->json($Supplier, 201);
    }

    public function show($id)
    {
        try {
            $Supplier = Supplier::where('id', $id)->first();

            return new SupplierResource($Supplier);
        } catch (Exception $e) {
            return $this->responseWithError($e->getMessage());
        }
    }



    public function update(Request $request, $id)
    {
        $Supplier = Supplier::findOrFail($id);
        $Supplier->update($request->all());
        return response()->json($Supplier, 200);
    }

    public function destroy($id)
    {
        Supplier::findOrFail($id)->delete();
        return response()->json('Supplier deleted successfully', 200);
    }
}
