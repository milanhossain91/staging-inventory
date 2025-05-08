<?php

namespace App\Http\Controllers;
use App\Models\SubCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SubCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function subcategory_all()
    {
           $sub_categories = DB::table('sub_categories')
           ->leftJoin('categories', 'sub_categories.categories_id', '=', 'categories.id')
           ->select('sub_categories.*', 'categories.name as category_name')
           ->get();
           return response()->json($sub_categories);
    }

    public function index(Request $request)
    {
        $query = DB::table('sub_categories')
            ->leftJoin('categories', 'sub_categories.categories_id', '=', 'categories.id')
            ->select('sub_categories.*', 'categories.name as category_name');

        // Search filter
        if ($request->has('search')) { // Change 'q' to 'search'
            $query->where(function ($q) use ($request) {
                $q->where('name', 'LIKE', '%' . $request->search . '%'); // Change 'q' to 'search'
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



    public function store(Request $request)
    {
        //dd($request->all());
        $subcategory = SubCategory::create($request->all());
        return response()->json($subcategory, 201);
    }

    public function show($id)
    {
        $subcategory = DB::table('sub_categories')
            ->leftJoin('categories', 'sub_categories.categories_id', '=', 'categories.id')
            ->select('sub_categories.*', 'categories.name as category_name')
            ->where('sub_categories.id', $id) // Filter by subcategory ID
            ->first();

      //  dd($subcategory);

        if ($subcategory) {
            return response()->json($subcategory);
        } else {
            return response()->json(['error' => 'Subcategory not found.'], 404);
        }
    }



    public function update(Request $request, $id)
    {
        $subcategory = SubCategory::findOrFail($id);
        $subcategory->update($request->all());
        return response()->json($subcategory, 200);
    }

    public function destroy($id)
    {
        SubCategory::findOrFail($id)->delete();
        return response()->json('Subcategory deleted successfully', 200);
    }

    public function categoryWiseSubcategory(Request $request){
        $categories_id = $request->categories_id;
        $categories = SubCategory::with('categories')->where('categories_id', $categories_id)->get();
        return response()->json($categories);
    }
}
