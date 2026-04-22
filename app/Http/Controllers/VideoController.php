<?php

namespace App\Http\Controllers;

use App\Models\Video;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class VideoController extends Controller
{
    public function index()
    {
        $videos = Video::with('user:id,name')->orderBy('created_at', 'desc')->get();

        return response()->json([
            'success' => true,
            'data' => $videos
        ]);
    }

    public function show($id)
    {
        $video = Video::with('user:id,name')->findOrFail($id);
        $video->increment('views');

        return response()->json([
            'success' => true,
            'data' => $video
        ]);
    }

    public function store(Request $request)
    {
        if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
            return response()->json([
                'success' => false,
                'message' => 'Only administrators can add videos'
            ], 403);
        }

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'youtube_url' => 'required|url'
        ]);

        $youtubeId = Video::extractYouTubeId($validated['youtube_url']);
        if (!$youtubeId) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid YouTube URL. Please use a valid YouTube link.'
            ], 422);
        }

        $video = Video::create([
            'title' => $validated['title'],
            'description' => $validated['description'],
            'youtube_url' => $validated['youtube_url'],
            'youtube_id' => $youtubeId,
            'user_id' => Auth::id(),
            'views' => 0
        ]);

        return response()->json([
            'success' => true,
            'data' => $video->load('user:id,name'),
            'message' => 'MV added successfully!'
        ], 201);
    }

    public function update(Request $request, $id)
    {
        try {
            $user = Auth::user();
            $video = Video::findOrFail($id);

            if (!$user->hasRole('superadmin') && !$user->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can edit videos'
                ], 403);
            }

            $validator = validator($request->all(), [
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
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
                'description' => $request->description
            ];

            if ($request->has('youtube_url')) {
                $youtubeId = Video::extractYouTubeId($request->youtube_url);
                if (!$youtubeId) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Invalid YouTube URL'
                    ], 422);
                }
                $updateData['youtube_url'] = $request->youtube_url;
                $updateData['youtube_id'] = $youtubeId;
            }

            $video->update($updateData);

            return response()->json([
                'success' => true,
                'message' => 'MV updated successfully',
                'data' => $video->fresh()
            ]);

        } catch (\Exception $e) {
            Log::error('Video update error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to update MV: ' . $e->getMessage()
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            $user = Auth::user();
            $video = Video::findOrFail($id);

            if (!$user->hasRole('superadmin') && !$user->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete videos'
                ], 403);
            }

            $video->delete();

            return response()->json([
                'success' => true,
                'message' => 'MV deleted successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Video delete error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete MV: ' . $e->getMessage()
            ], 500);
        }
    }

    public function myVideos()
    {
        $videos = Video::where('user_id', Auth::id())
            ->with('user:id,name')
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $videos
        ]);
    }
}
