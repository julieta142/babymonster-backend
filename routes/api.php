<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\UserManagementController;
use App\Http\Controllers\RolePermissionController;
use App\Http\Controllers\VideoController;
use App\Http\Controllers\ProfileController;
use App\Http\Middleware\SuperadminMiddleware;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\AlbumController;
use App\Http\Controllers\Auth\GoogleAuthController;
use App\Http\Controllers\PerformanceController;
use App\Http\Controllers\TourController;
use App\Http\Controllers\ShowController;
use App\Http\Controllers\SupportController;
use App\Models\SupportMessage;
use App\Models\User;

Route::get('/sanctum/csrf-cookie', function () {
    return response()->json(['message' => 'CSRF cookie set']);
})->middleware('web');

Route::get('/user/status', function(Request $request) {
    $user = User::where('email', $request->email)->first();

    if (!$user) {
        return response()->json(['exists' => false]);
    }

    $rejectedMessage = SupportMessage::where('user_id', $user->id)
        ->where('status', 'rejected')
        ->first();

    return response()->json([
        'exists' => true,
        'is_blocked' => $user->is_blocked,
        'has_rejected_message' => !!$rejectedMessage,
        'rejection_reason' => $rejectedMessage?->rejection_reason
    ]);
});
Route::get('/auth/google', [GoogleAuthController::class, 'redirectToGoogle']);
Route::get('/auth/google/callback', [GoogleAuthController::class, 'handleGoogleCallback']);


Route::post('/login', [AuthenticatedSessionController::class, 'store']);
Route::post('/register', [RegisteredUserController::class, 'store']);

Route::post('/support/message', [SupportController::class, 'sendMessage']);

Route::get('/videos', [VideoController::class, 'index']);
Route::get('/videos/{id}', [VideoController::class, 'show']);

Route::get('/news', [NewsController::class, 'index']);
Route::get('/news/{slug}', [NewsController::class, 'show']);

Route::get('/albums', [AlbumController::class, 'index']);
Route::get('/albums/{id}', [AlbumController::class, 'show']);
Route::get('/albums/{albumId}/videos/{videoId}/download', [AlbumController::class, 'downloadAudio']);

Route::get('/performances', [PerformanceController::class, 'index']);
Route::get('/performances/{id}', [PerformanceController::class, 'show']);
Route::get('/performances/category/{category}', [PerformanceController::class, 'getByCategory']);
Route::get('/performances-categories', [PerformanceController::class, 'getCategories']);

Route::get('/tours', [TourController::class, 'index']);
Route::get('/tours/{id}', [TourController::class, 'show']);

Route::get('/shows', [ShowController::class, 'index']);
Route::get('/shows/{id}', [ShowController::class, 'show']);


Route::prefix('albums/{albumId}/videos/{videoId}')->group(function () {
    Route::get('/lyrics', [AlbumController::class, 'getLyrics']);
    Route::post('/lyrics', [AlbumController::class, 'saveLyrics'])->middleware('auth');
});

Route::middleware(['auth:sanctum'])->group(function () {
    Route::post('/logout', [AuthenticatedSessionController::class, 'destroy']);

    Route::post('/profile', [ProfileController::class, 'update']);
    Route::post('/profile/avatar', [ProfileController::class, 'updateAvatar']);
    Route::post('/change-password', [ProfileController::class, 'changePassword']);

    Route::get('/user', function (Request $request) {
        $user = $request->user();
        if ($user) {
            $user->load('roles.permissions');
            $allPermissions = $user->getAllPermissions()->pluck('name');

            return response()->json([
                'success' => true,
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'is_blocked' => $user->is_blocked,
                    'gender' => $user->gender,
                    'bio' => $user->bio,
                    'is_private' => $user->is_private,
                    'avatar' => $user->avatar,
                    'avatar_url' => $user->avatar_url,
                    'background_url' => $user->background_url,
                    'created_at' => $user->created_at,
                    'updated_at' => $user->updated_at,
                    'roles' => $user->roles->map(function ($role) {
                        return [
                            'id' => $role->id,
                            'name' => $role->name,
                            'display_name' => $role->display_name,
                            'description' => $role->description,
                            'permissions' => $role->permissions->map(function ($permission) {
                                return [
                                    'id' => $permission->id,
                                    'name' => $permission->name,
                                    'display_name' => $permission->display_name,
                                    'group' => $permission->group
                                ];
                            })
                        ];
                    }),
                    'permissions' => $allPermissions,
                    'is_superadmin' => $user->hasRole('superadmin')
                ],
                'permissions' => $allPermissions
            ]);
        }
        return response()->json(['success' => false, 'message' => 'Unauthenticated'], 401);
    });

    Route::post('/auth/google/disconnect', [GoogleAuthController::class, 'disconnectGoogle']);
    Route::post('/auth/set-username', [GoogleAuthController::class, 'setUsername']);
    Route::get('/auth/login-history', [GoogleAuthController::class, 'getLoginHistory']);

    Route::post('/videos', [VideoController::class, 'store']);
    Route::put('/videos/{id}', [VideoController::class, 'update']);
    Route::delete('/videos/{id}', [VideoController::class, 'destroy']);
    Route::get('/my-videos', [VideoController::class, 'myVideos']);
    Route::post('/videos/{id}/upload-video', [VideoController::class, 'uploadVideo']);
    Route::post('/videos/{id}/upload-thumbnail', [VideoController::class, 'uploadThumbnail']);

    Route::post('/news', [NewsController::class, 'addNews']);
    Route::put('/news/{newsId}', [NewsController::class, 'updateNews']);
    Route::delete('/news/{newsId}', [NewsController::class, 'deleteNews']);

    Route::post('/albums', [AlbumController::class, 'store']);
    Route::put('/albums/{id}', [AlbumController::class, 'update']);
    Route::delete('/albums/{id}', [AlbumController::class, 'destroy']);
    Route::post('/albums/{albumId}/videos', [AlbumController::class, 'addVideo']);
    Route::put('/albums/{albumId}/videos/{videoId}', [AlbumController::class, 'updateVideo']);
    Route::delete('/albums/{albumId}/videos/{videoId}', [AlbumController::class, 'deleteVideo']);
    Route::post('/albums/{albumId}/videos/{videoId}/audio', [AlbumController::class, 'uploadAudio']);
    Route::delete('/albums/{albumId}/videos/{videoId}/audio', [AlbumController::class, 'deleteAudio']);

    Route::post('/performances', [PerformanceController::class, 'store']);
    Route::put('/performances/{id}', [PerformanceController::class, 'update']);
    Route::delete('/performances/{id}', [PerformanceController::class, 'destroy']);

    Route::post('/shows', [ShowController::class, 'store']);
    Route::put('/shows/{id}', [ShowController::class, 'update']);
    Route::delete('/shows/{id}', [ShowController::class, 'destroy']);

    Route::post('/tours', [TourController::class, 'store']);
    Route::put('/tours/{id}', [TourController::class, 'update']);
    Route::delete('/tours/{id}', [TourController::class, 'destroy']);
    Route::post('/tours/{tourId}/countries', [TourController::class, 'addCountry']);
    Route::put('/tours/{tourId}/countries/{countryId}', [TourController::class, 'updateCountry']);
    Route::delete('/tours/{tourId}/countries/{countryId}', [TourController::class, 'deleteCountry']);
    Route::post('/tours/{tourId}/videos', [TourController::class, 'addVideo']);
    Route::delete('/tours/{tourId}/videos/{videoId}', [TourController::class, 'deleteVideo']);
    Route::post('/tours/{tourId}/images', [TourController::class, 'addImage']);
    Route::delete('/tours/{tourId}/images/{imageId}', [TourController::class, 'deleteImage']);

    Route::prefix('admin')->middleware([SuperadminMiddleware::class])->group(function () {
        Route::get('/support/messages', [SupportController::class, 'getMessages']);
        Route::get('/support/messages/{id}', [SupportController::class, 'getMessage']);
        Route::post('/support/messages/{id}/respond', [SupportController::class, 'respondToMessage']);
        Route::delete('/support/messages/{id}', [SupportController::class, 'deleteMessage']);
        Route::get('/support/unread-count', [SupportController::class, 'getUnreadCount']);

        Route::get('/users', [UserManagementController::class, 'index']);
        Route::get('/users/{user}', [UserManagementController::class, 'show']);
        Route::post('/users/{user}/block', [UserManagementController::class, 'blockUser']);
        Route::post('/users/{user}/unblock', [UserManagementController::class, 'unblockUser']);
        Route::post('/users/{user}/assign-role', [UserManagementController::class, 'assignRole']);
        Route::delete('/users/{user}/remove-role', [UserManagementController::class, 'removeRole']);

        Route::get('/roles', [RolePermissionController::class, 'getRoles']);
        Route::post('/roles', [RolePermissionController::class, 'createRole']);
        Route::delete('/roles/{role}', [RolePermissionController::class, 'deleteRole']);

        Route::get('/permissions', [RolePermissionController::class, 'getPermissions']);
        Route::post('/permissions', [RolePermissionController::class, 'createPermission']);
        Route::delete('/permissions/{permission}', [RolePermissionController::class, 'deletePermission']);

        Route::post('/roles/{role}/assign-permission', [RolePermissionController::class, 'assignPermissionToRole']);
        Route::delete('/roles/{role}/remove-permission', [RolePermissionController::class, 'removePermissionFromRole']);
        Route::post('/roles/{role}/sync-permissions', [RolePermissionController::class, 'syncRolePermissions']);
    });
});

