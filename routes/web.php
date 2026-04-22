<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\GoogleAuthController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

Route::get('/', function () {
    return ['Laravel' => app()->version()];
});

// Google OAuth Routes
Route::get('/auth/google', [GoogleAuthController::class, 'redirectToGoogle'])->name('google.redirect');
Route::get('/auth/google/callback', [GoogleAuthController::class, 'handleGoogleCallback'])->name('google.callback');

// Handle callback with /api prefix (some requests might come here)
Route::get('/api/auth/google/callback', [GoogleAuthController::class, 'handleGoogleCallback']);

require __DIR__.'/auth.php';
