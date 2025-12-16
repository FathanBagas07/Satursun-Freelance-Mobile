<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $uid = $request->get('firebase_uid');
    
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email',
            'username' => 'required|string|unique:users',
        ]);
    
        $user = User::firstOrCreate(
            ['firebase_uid' => $uid],
            [
                'name' => $validated['name'],
                'email' => $validated['email'],
                'username' => $validated['username'],
            ]
        );
    
        return response()->json([
            'message' => 'User created',
            'user' => $user,
        ]);
    }
}