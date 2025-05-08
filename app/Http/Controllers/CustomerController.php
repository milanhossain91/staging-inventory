<?php

namespace App\Http\Controllers;

use App\Models\Customer;

use Exception;

use Illuminate\Http\Request;

use App\Http\Resources\CustomerResource;

class CustomerController extends Controller
{
    public function Customer_all()
    {
        $Customer = Customer::all();
        return response()->json($Customer);
    }



    public function index(Request $request)
    {
        $query = Customer::query();

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


    public function customersAll(){
        try {
            $data = Customer::all();

            if ($data->isEmpty()) {
                return response()->json([
                    'message' => 'No customers found.',
                    'data' => []
                ], 404);  // Optionally use 200 with an empty array if preferred
            }

            return response()->json([
                'data' => $data
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to retrieve customers.',
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        $Customer = Customer::create($request->all());
        return response()->json($Customer, 201);
    }

    public function show($id)
    {
        try {
            $Customer = Customer::where('id', $id)->first();

            return new CustomerResource($Customer);
        } catch (Exception $e) {
            return $this->responseWithError($e->getMessage());
        }
    }



    public function update(Request $request, $id)
    {
        $Customer = Customer::findOrFail($id);
        $Customer->update($request->all());
        return response()->json($Customer, 200);
    }

    public function destroy($id)
    {
        Customer::findOrFail($id)->delete();
        return response()->json('Customer deleted successfully', 200);
    }
}
