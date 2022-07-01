<?php

use App\Http\Controllers\ApparelController;
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

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/apparel',[ApparelController::class,'index']);
Route::get('/apparel/show/{apparel}',[ApparelController::class,'show']);
Route::post('/apparel/store',[ApparelController::class,'store']);
Route::put('/apparel/update/{apparel}',[ApparelController::class,'update']);
Route::delete('/apparel/delete/{apparel}',[ApparelController::class,'destroy']);
