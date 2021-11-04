<?php

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

Route::prefix('v1')->namespace('Api\V1')->group(function () {
    Route::middleware(['auth:api'])->group(function () {
        // Posts
        Route::apiResource('posts', 'PostController')->only(['update', 'store', 'destroy']);
        Route::post('/posts/{post}/likes', 'PostLikeController@store')->name('posts.likes.store');
        Route::delete('/posts/{post}/likes', 'PostLikeController@destroy')->name('posts.likes.destroy');

        // Users
        Route::apiResource('users', 'UserController')->only('update');
    });

    Route::post('/authenticate', 'Auth\AuthenticateController@authenticate')->name('authenticate');


    // Posts
    Route::apiResource('posts', 'PostController')->only(['index', 'show']);
    Route::apiResource('users.posts', 'UserPostController')->only('index');

    // Users
    Route::apiResource('users', 'UserController')->only(['index', 'show']);
});
