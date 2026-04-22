<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class SuperadminMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        $user = $request->user();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated'
            ], 401);
        }

        if (!$user->hasRole('superadmin')) {
            return response()->json([
                'success' => false,
                'message' => 'Forbidden - Superadmin access required'
            ], 403);
        }

        return $next($request);
    }
}
