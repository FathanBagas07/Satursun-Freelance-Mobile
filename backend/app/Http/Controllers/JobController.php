<?php

namespace App\Http\Controllers;

use App\Models\Job;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class JobController extends Controller
{
    public function store(Request $request)
    {
        // Validasi Input
        $validator = Validator::make($request->all(), [
            'judul' => 'required|string|max:255',
            'lokasi' => 'required|string',
            'kategori' => 'required|string',
            'deskripsi' => 'required|string',
            'budget' => 'required|numeric',
            'tenggat_waktu' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal',
                'errors' => $validator->errors()
            ], 422);
        }

        // Simpan ke Database
        // Asumsi: User sudah login via Sanctum token
        $job = Job::create([
            'user_id' => $request->user()->id, 
            'judul' => $request->judul,
            'lokasi' => $request->lokasi,
            'kategori' => $request->kategori,
            'deskripsi' => $request->deskripsi,
            'budget' => $request->budget,
            'tenggat_waktu' => $request->tenggat_waktu,
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Pekerjaan berhasil diposting',
            'data' => $job
        ], 201);
    }
}