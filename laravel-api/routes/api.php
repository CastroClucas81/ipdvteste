<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\CostCenterController;
use App\Http\Controllers\DepartamentController;
use App\Http\Controllers\OfficeController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('login', [AuthController::class, 'login']);

Route::post('office', [OfficeController::class, 'store']);
Route::post('departament', [DepartamentController::class, 'store']);
Route::post('cost-center', [CostCenterController::class, 'store']);
Route::post('user', [UserController::class, 'store']);
Route::post('import-users', [UserController::class, 'import']);


Route::post('office-edit', [OfficeController::class, 'edit']);
Route::post('departament-edit', [DepartamentController::class, 'edit']);
Route::post('cost-center-edit', [CostCenterController::class, 'edit']);
Route::post('user-edit', [UserController::class, 'edit']);

Route::delete('office-delete/{id}', [OfficeController::class, 'delete']);
Route::delete('departament-delete/{id}', [DepartamentController::class, 'delete']);
Route::delete('cost-center-delete/{id}', [CostCenterController::class, 'delete']);
Route::delete('user-delete/{id}', [UserController::class, 'delete']);

Route::get('get-departaments', [DepartamentController::class, 'getAll']);
Route::get('get-cost-center', [CostCenterController::class, 'getAll']);
Route::get('get-offices', [OfficeController::class, 'getAll']);

Route::get('users-all', [UserController::class, 'usersAll']);

Route::get('all-user-for-departament/results', [UserController::class, 'userForDepartament']);
Route::get('all_departament-for-cost-center/results', [DepartamentController::class, 'departamentForCostCenter']);
Route::get('all_cost_centers/results', [CostCenterController::class, 'allCostsCentersPaginate']);
Route::get('all_offices/results', [OfficeController::class, 'allOfficesPaginate']);
Route::get('all_departaments/results', [DepartamentController::class, 'allDepartamentsPaginate']);
/*
Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});
*/