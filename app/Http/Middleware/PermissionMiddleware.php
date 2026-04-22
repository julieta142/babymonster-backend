<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class PermissionMiddleware
{
    public function handle(Request $request, Closure $next, $permission)
    {
        if (!$request->user()) {
            return response()->json(['message' => 'Unauthenticated'], 401);
        }

        if (!$request->user()->hasPermission($permission)) {
            return response()->json(['message' => 'Forbidden - Insufficient permission'], 403);
        }

        return $next($request);
    }
}
