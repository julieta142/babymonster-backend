<?php

namespace App\Http\Controllers;

use App\Models\Album;
use App\Models\AlbumVideo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use App\Models\User;
use Illuminate\Support\Facades\Validator;


class AlbumController extends Controller
{
    public function index()
    {
        try {
            $albums = Album::with('user:id,name')
                ->orderBy('order')
                ->orderBy('release_date', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $albums
            ]);
        } catch (\Exception $e) {
            Log::error('Album index error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch albums'
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $album = Album::with(['user:id,name', 'videos'])
                ->findOrFail($id);

            return response()->json([
                'success' => true,
                'data' => $album
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Album not found'
            ], 404);
        }
    }

    public function store(Request $request)
    {
        try {
            if (!Auth::check()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthenticated'
                ], 401);
            }


            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can create albums'
                ], 403);
            }

            $validated = $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'release_date' => 'nullable|date',
                'rating' => 'nullable|integer|min:0|max:5',
                'order' => 'nullable|integer',
                'album_art' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:5120'
            ]);

            $albumData = [
                'title' => $validated['title'],
                'description' => $validated['description'] ?? null,
                'release_date' => $validated['release_date'] ?? null,
                'rating' => $validated['rating'] ?? null,
                'order' => $validated['order'] ?? 0,
                'user_id' => Auth::id(),
                'artist' => 'BABYMONSTER'
            ];

            if ($request->hasFile('album_art')) {
                $file = $request->file('album_art');
                $filename = time() . '_album_' . uniqid() . '.' . $file->getClientOriginalExtension();
                $path = $file->storeAs('album_arts', $filename, 'public');
                $albumData['album_art'] = $path;
            }

            $album = Album::create($albumData);

            return response()->json([
                'success' => true,
                'data' => $album,
                'message' => 'Album created successfully'
            ], 201);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Album store error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to create album: ' . $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can update albums'
                ], 403);
            }

            $album = Album::findOrFail($id);

            $validated = $request->validate([
                'title' => 'sometimes|string|max:255',
                'description' => 'nullable|string',
                'release_date' => 'nullable|date',
                'rating' => 'nullable|integer|min:0|max:5',
                'order' => 'nullable|integer',
                'album_art' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:5120'
            ]);

            $updateData = [];

            if ($request->has('title')) $updateData['title'] = $validated['title'];
            if ($request->has('description')) $updateData['description'] = $validated['description'];
            if ($request->has('release_date')) $updateData['release_date'] = $validated['release_date'];
            if ($request->has('rating')) $updateData['rating'] = $validated['rating'];
            if ($request->has('order')) $updateData['order'] = $validated['order'];

            if ($request->hasFile('album_art')) {
                if ($album->album_art && Storage::disk('public')->exists($album->album_art)) {
                    Storage::disk('public')->delete($album->album_art);
                }

                $file = $request->file('album_art');
                $filename = time() . '_album_' . uniqid() . '.' . $file->getClientOriginalExtension();
                $path = $file->storeAs('album_arts', $filename, 'public');
                $updateData['album_art'] = $path;
            }

            $album->update($updateData);

            return response()->json([
                'success' => true,
                'data' => $album->fresh(),
                'message' => 'Album updated successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Album update error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to update album'
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete albums'
                ], 403);
            }

            $album = Album::findOrFail($id);

            if ($album->album_art && Storage::disk('public')->exists($album->album_art)) {
                Storage::disk('public')->delete($album->album_art);
            }

            foreach ($album->videos as $video) {
                if ($video->audio_file && Storage::disk('public')->exists($video->audio_file)) {
                    Storage::disk('public')->delete($video->audio_file);
                }
                $video->delete();
            }

            $album->delete();

            return response()->json([
                'success' => true,
                'message' => 'Album deleted successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Album delete error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete album'
            ], 500);
        }
    }

public function addVideo(Request $request, $albumId)
{
    try {
        if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
            return response()->json([
                'success' => false,
                'message' => 'Only administrators can add videos to albums'
            ], 403);
        }

        $album = Album::findOrFail($albumId);

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'youtube_url' => 'nullable|string',
            'track_number' => 'nullable|integer',
            'duration' => 'nullable|integer'
        ]);

        // Handle YouTube URL - explicitly set to null if empty
        $youtubeUrl = null;
        $youtubeId = null;

        if (!empty($validated['youtube_url']) && $validated['youtube_url'] !== 'null') {
            $youtubeUrl = $validated['youtube_url'];
            $youtubeId = AlbumVideo::extractYouTubeId($youtubeUrl);
            if (!$youtubeId) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid YouTube URL format'
                ], 422);
            }
        }

        $video = AlbumVideo::create([
            'album_id' => $albumId,
            'title' => $validated['title'],
            'youtube_url' => $youtubeUrl, 
            'youtube_id' => $youtubeId,
            'track_number' => $validated['track_number'] ?? 0,
            'duration' => $validated['duration'] ?? null
        ]);

        return response()->json([
            'success' => true,
            'data' => $video,
            'message' => 'Track added to album successfully'
        ], 201);

    } catch (\Exception $e) {
        Log::error('Add video to album error: ' . $e->getMessage());
        Log::error('Stack trace: ' . $e->getTraceAsString());
        return response()->json([
            'success' => false,
            'message' => 'Failed to add track to album: ' . $e->getMessage()
        ], 500);
    }
}

    public function updateVideo(Request $request, $albumId, $videoId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can update album tracks'
                ], 403);
            }

            $video = AlbumVideo::where('album_id', $albumId)->findOrFail($videoId);

            $validated = $request->validate([
                'title' => 'sometimes|string|max:255',
                'youtube_url' => 'sometimes|url',
                'track_number' => 'nullable|integer',
                'duration' => 'nullable|integer'
            ]);

            $updateData = [];

            if ($request->has('title')) $updateData['title'] = $validated['title'];
            if ($request->has('track_number')) $updateData['track_number'] = $validated['track_number'];
            if ($request->has('duration')) $updateData['duration'] = $validated['duration'];

            if ($request->has('youtube_url')) {
                $youtubeId = AlbumVideo::extractYouTubeId($validated['youtube_url']);
                if (!$youtubeId) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Invalid YouTube URL'
                    ], 422);
                }
                $updateData['youtube_url'] = $validated['youtube_url'];
                $updateData['youtube_id'] = $youtubeId;
            }

            $video->update($updateData);

            return response()->json([
                'success' => true,
                'data' => $video,
                'message' => 'Track updated successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Update album video error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to update track'
            ], 500);
        }
    }

    public function deleteVideo($albumId, $videoId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete album tracks'
                ], 403);
            }

            $video = AlbumVideo::where('album_id', $albumId)->findOrFail($videoId);

            if ($video->audio_file && Storage::disk('public')->exists($video->audio_file)) {
                Storage::disk('public')->delete($video->audio_file);
            }

            $video->delete();

            return response()->json([
                'success' => true,
                'message' => 'Track removed from album successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Delete album video error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to remove track from album'
            ], 500);
        }
    }

    public function uploadAudio(Request $request, $albumId, $videoId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can upload audio files'
                ], 403);
            }

            $video = AlbumVideo::where('album_id', $albumId)->findOrFail($videoId);

            $request->validate([
                'audio' => 'required|file|mimes:mp3,wav,m4a,ogg|max:20480'
            ]);

            if ($video->audio_file && Storage::disk('public')->exists($video->audio_file)) {
                Storage::disk('public')->delete($video->audio_file);
            }

            $file = $request->file('audio');
            $originalName = $file->getClientOriginalName();
            $filename = time() . '_' . uniqid() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('album_audios', $filename, 'public');

            $video->update([
                'audio_file' => $path,
                'audio_file_name' => $originalName
            ]);

            return response()->json([
                'success' => true,
                'data' => $video,
                'message' => 'Audio uploaded successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Upload audio error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to upload audio: ' . $e->getMessage()
            ], 500);
        }
    }

    public function deleteAudio($albumId, $videoId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete audio files'
                ], 403);
            }

            $video = AlbumVideo::where('album_id', $albumId)->findOrFail($videoId);

            if ($video->audio_file && Storage::disk('public')->exists($video->audio_file)) {
                Storage::disk('public')->delete($video->audio_file);
            }

            $video->update([
                'audio_file' => null,
                'audio_file_name' => null
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Audio removed successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Delete audio error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete audio'
            ], 500);
        }
    }

    public function downloadAudio($albumId, $videoId)
    {
        try {
            $video = AlbumVideo::where('album_id', $albumId)->findOrFail($videoId);

            if (!$video->audio_file || !Storage::disk('public')->exists($video->audio_file)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Audio file not found'
                ], 404);
            }

            $fileName = $video->audio_file_name ?? $video->title . '.mp3';

            return Storage::disk('public')->download($video->audio_file, $fileName);
        } catch (\Exception $e) {
            Log::error('Download audio error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to download audio'
            ], 500);
        }
    }


    public function getLyrics($albumId, $videoId)
    {
        try {
            $album = Album::findOrFail($albumId);
            $video = $album->videos()->findOrFail($videoId);

            return response()->json([
                'success' => true,
                'lyrics_original' => $video->lyrics_original,
                'lyrics_romanized' => $video->lyrics_romanized,
                'has_lyrics' => !empty($video->lyrics_original) || !empty($video->lyrics_romanized)
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch lyrics',
            ], 404);
        }
    }

    public function saveLyrics(Request $request, $albumId, $videoId)
    {
        try {
            $validator = Validator::make($request->all(), [
                'lyrics_original' => 'nullable|string|max:50000',
                'lyrics_romanized' => 'nullable|string|max:50000'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'errors' => $validator->errors()
                ], 422);
            }

            $album = Album::findOrFail($albumId);
            $video = $album->videos()->findOrFail($videoId);

            if ($request->has('lyrics_original')) {
                $video->lyrics_original = $request->lyrics_original;
            }
            if ($request->has('lyrics_romanized')) {
                $video->lyrics_romanized = $request->lyrics_romanized;
            }

            $video->save();

            return response()->json([
                'success' => true,
                'message' => 'Lyrics saved successfully',
                'lyrics_original' => $video->lyrics_original,
                'lyrics_romanized' => $video->lyrics_romanized
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to save lyrics',
            ], 500);
        }
    }
}
