<?php

namespace App\Http\Controllers;

use App\Models\Shows;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class ShowController extends Controller
{
    public function index()
    {
        $shows = Shows::with('user:id,name')
            ->orderBy('show_date', 'desc')
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $shows
        ]);
    }

    public function show($id)
    {
        $show = Shows::with('user:id,name')->findOrFail($id);

        return response()->json([
            'success' => true,
            'data' => $show
        ]);
    }

    public function store(Request $request)
    {
        if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
            return response()->json([
                'success' => false,
                'message' => 'Only administrators can add shows'
            ], 403);
        }

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'category' => 'nullable|string|max:255',
            'show_date' => 'nullable|date',
            'youtube_url' => 'required|url'
        ]);

        $youtubeId = Shows::extractYouTubeId($validated['youtube_url']);
        if (!$youtubeId) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid YouTube URL. Please use a valid YouTube URL'
            ], 422);
        }

        $show = Shows::create([
            'title' => $validated['title'],
            'category' => $validated['category'] ?? null,
            'show_date' => $validated['show_date'] ?? null,
            'youtube_url' => $validated['youtube_url'],
            'youtube_id' => $youtubeId,
            'user_id' => Auth::id()
        ]);

        return response()->json([
            'success' => true,
            'data' => $show
        ]);
    }

    public function update(Request $request, $id)
    {
        try {
            $user = Auth::user();
            $show = Shows::findOrFail($id);

            if (!$user->hasRole('superadmin') && !$user->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can edit shows'
                ], 403);
            }

            $validator = validator($request->all(), [
                'title' => 'required|string|max:255',
                'category' => 'nullable|string|max:255',
                'show_date' => 'nullable|date',
                'youtube_url' => 'sometimes|url'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $updateData = [
                'title' => $request->title,
                'category' => $request->category,
                'show_date' => $request->show_date
            ];

            if ($request->has('youtube_url') && $request->youtube_url !== $show->youtube_url) {
                $youtubeId = Shows::extractYouTubeId($request->youtube_url);
                if (!$youtubeId) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Invalid YouTube URL'
                    ], 422);
                }
                $updateData['youtube_url'] = $request->youtube_url;
                $updateData['youtube_id'] = $youtubeId;
            }

            $show->update($updateData);

            return response()->json([
                'success' => true,
                'message' => 'Show updated successfully',
                'data' => $show->fresh()
            ]);
        } catch (\Exception $e) {
            Log::error('Show update error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to update show: ' . $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $user = Auth::user();
            $show = Shows::findOrFail($id);

            if (!$user->hasRole('superadmin') && !$user->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete shows'
                ], 403);
            }

            $show->delete();

            return response()->json([
                'success' => true,
                'message' => 'Show deleted successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Show deletion error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete show: ' . $e->getMessage()
            ], 500);
        }
    }
}