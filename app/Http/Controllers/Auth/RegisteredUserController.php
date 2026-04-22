<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Http\Requests\RegisterRequest;

class RegisteredUserController extends Controller
{
    public function store(RegisterRequest $request): JsonResponse
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'gender' => $request->gender,
            'is_private' => false,
        ]);


        $user->assignRole('user');

        event(new Registered($user));

        Auth::login($user);

        return response()->json([
            'success' => true,
            'user' => $user,
        ]);
    }
}
