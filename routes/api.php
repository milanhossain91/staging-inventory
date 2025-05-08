<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\RolesController;
use App\Http\Controllers\Api\PermissionsController;

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\SubCategoryController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\CustomerController;

use App\Http\Controllers\SalesAddController;
use App\Http\Controllers\SalesManageController;
use App\Http\Controllers\PurchaseAddController;
use App\Http\Controllers\PurchaseManageController;

use App\Http\Controllers\PurchaseController;

use App\Http\Controllers\SalesController;

// Public Routes
Route::post('/register', [UserController::class, 'register']);
Route::post('/login', [UserController::class, 'login']);

// Protected Routes
Route::middleware(['auth:sanctum'])->group(function () {

    Route::post('/logout', [UserController::class, 'logout']);
    Route::get('/loggeduser', [UserController::class, 'logged_user']);
    Route::post('/changepassword', [UserController::class, 'change_password']);

    //List
    Route::get('/role_list', [UserController::class, 'role_list']);
    Route::get('/permission_list', [UserController::class, 'permission_list']);
    Route::get('/user_list', [UserController::class, 'user_list']);
    Route::get('/all_user_list', [UserController::class, 'all_user_list']);

    Route::get('/user_show/{id}', [UserController::class, 'show']);

    //User Update
    Route::get('/user_edit/{id}', [UserController::class, 'user_edit']);
    Route::put('/user_update/{id}', [UserController::class, 'user_update']);

    Route::get('/role_wise_user', [UserController::class, 'role_wise_user']);

    //User Update
    Route::put('/user_update/{id}', [UserController::class, 'user_update']);

    //User Delete
    Route::delete('/user_delete/{id}', [UserController::class, 'user_delete']);

    //Assign Permission
    Route::put('/assign_permission/{id}', [UserController::class, 'assign_permission']);

    //role & permission
    Route::resource('roles', RolesController::class);
    Route::resource('permissions', PermissionsController::class);

    //Inventory

    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('subcategories', SubCategoryController::class);

    Route::get('category_wise_subcategory', [SubCategoryController::class, 'categoryWiseSubcategory']);

    Route::apiResource('products', ProductController::class);

    Route::get('/purchase/products/search', [ProductController::class, 'productSearch']);



    Route::get('products_all', [ProductController::class, 'productsAll']);

    Route::apiResource('suppliers', SupplierController::class);
    Route::get('customers_all', [CustomerController::class, 'customersAll']);

    Route::apiResource('customers', CustomerController::class);

    Route::get('supplier_all', [SupplierController::class, 'supplierAll']);

    Route::apiResource('sales_add', SalesAddController::class);
    Route::apiResource('sales_manage', SalesManageController::class);
    Route::apiResource('purchase_add', PurchaseAddController::class);
    Route::apiResource('purchase_manage', PurchaseManageController::class);




    Route::apiResource('purchase', PurchaseController::class);


    Route::get('purchasesdatewisesearch', [PurchaseController::class, 'purchasesdatewisesearch']);

    Route::apiResource('sales', SalesController::class);

    Route::get('salesdatewisesearch', [SalesController::class, 'salesDateWiseSearch']);

    Route::get('purchasesdatewisesearch', [PurchaseController::class, 'purchasesDateWiseSearch']);

});
