<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::redirect('/.well-known/change-password', '/settings/password');

Auth::routes(['verify' => true]);

Route::prefix('auth')->group(function () {
    Route::get('{provider}', 'Auth\AuthController@redirectToProvider')->name('auth.provider');
    Route::get('{provider}/callback', 'Auth\AuthController@handleProviderCallback');
});

Route::middleware(['auth'])->group(function () {
    Route::prefix('settings')->group(function () {
        Route::get('account', 'UserController@edit')->name('users.edit');
        Route::get('my-posts', 'UserController@my_posts')->name('my_posts');
        Route::get('edit-my-post/{title}/{id}', 'PostController@edit')->name('edit-my-post');
        Route::match(['put', 'patch'], 'account', 'UserController@update')->name('users.update');

        Route::get('password', 'UserPasswordController@edit')->name('users.password');
        Route::match(['put', 'patch'], 'password', 'UserPasswordController@update')->name('users.password.update');
    });

});
