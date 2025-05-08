<?php

namespace App\Http\Controllers;

use App\Models\Category;

use Illuminate\Http\Request;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $query = Category::query();

        // Search filter
        if ($request->has('q')) {
            $query->where(function ($q) use ($request) {
                $q->where('name', 'LIKE', '%' . $request->q . '%');
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


    public function category_all()
    {
        $category = Category::all();
        return response()->json($category);
    }

    public function store(Request $request)
    {
        $category = Category::create($request->all());
        return response()->json($category, 201);
    }

    public function show($id)
    {
        $category = Category::findOrFail($id);
        return response()->json($category);
    }

    public function update(Request $request, $id)
    {

        $category = Category::findOrFail($id);
        $category->update($request->all());
        return response()->json($category, 200);
    }

    public function destroy($id)
    {
        //dd($id);
        Category::findOrFail($id)->delete();
        return response()->json('Category deleted successfully', 200);
    }


}
