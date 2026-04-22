<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\News;
use App\Models\NewsPhoto;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;

class NewsController extends Controller
{
    public function index()
    {
        try {
            $news = News::with('photos')
                ->orderBy('news_date', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $news
            ]);
        } catch (\Exception $e) {
            \Log::error('News fetch error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch news'
            ], 500);
        }
    }

    public function show($slug)
    {
        try {
            // Find by slug (not by ID)
            $newsItem = News::with('photos')
                ->where('slug', $slug)
                ->first();

            if (!$newsItem) {
                return response()->json([
                    'success' => false,
                    'message' => 'News not found'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $newsItem
            ]);
        } catch (\Exception $e) {
            \Log::error('News show error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error fetching news'
            ], 500);
        }
    }

    public function addNews(Request $request)
    {
    if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
    }

        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'news_date' => 'required|date',
            'category' => 'nullable|string|max:255',
            'slug' => 'required|string|max:255|unique:news,slug',
            'photos' => 'required|array|min:1|max:20',
            'photos.*' => 'image|max:5120'
        ]);

        $news = News::create([
            'title' => $validated['title'],
            'description' => $validated['description'] ?? null,
            'user_id' => Auth::id(),
            'news_date' => $validated['news_date'],
            'category' => $validated['category'] ?? 'general',
            'slug' => $validated['slug']
        ]);

        if ($request->hasFile('photos')) {
            foreach ($request->file('photos') as $index => $photo) {
                $path = $photo->store('news-photos', 'public');
                NewsPhoto::create([
                    'news_id' => $news->id,
                    'photo_path' => $path,
                    'order' => $index
                ]);
            }
        }

        return response()->json([
            'success' => true,
            'data' => $news->load('photos')
        ], 201);
    }

    public function updateNews(Request $request, $newsId)
    {
     if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
        return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
    }

        $news = News::findOrFail($newsId);

        $validated = $request->validate([
            'title' => 'sometimes|string|max:255',
            'description' => 'nullable|string',
            'news_date' => 'sometimes|date',
            'category' => 'nullable|string|max:255',
            'slug' => 'sometimes|string|max:255|unique:news,slug,' . $newsId,
            'delete_photos' => 'nullable|array',
            'delete_photos.*' => 'integer|exists:news_photos,id',
        ]);

        $news->update($validated);

        if ($request->has('delete_photos')) {
            foreach ($request->delete_photos as $photoId) {
                $photo = NewsPhoto::find($photoId);
                if ($photo) {
                    Storage::disk('public')->delete($photo->photo_path);
                    $photo->delete();
                }
            }
        }

        if ($request->hasFile('photos')) {
            $currentCount = $news->photos()->count();
            foreach ($request->file('photos') as $index => $photo) {
                $path = $photo->store('news-photos', 'public');
                NewsPhoto::create([
                    'news_id' => $news->id,
                    'photo_path' => $path,
                    'order' => $currentCount + $index
                ]);
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'News updated successfully',
            'data' => $news->load('photos')
        ]);
    }

    public function deleteNews($newsId)
    {
        if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
        }

        $news = News::findOrFail($newsId);

        foreach ($news->photos as $photo) {
            Storage::disk('public')->delete($photo->photo_path);
            $photo->delete();
        }

        $news->delete();

        return response()->json([
            'success' => true,
            'message' => 'News deleted successfully'
        ]);
    }
}
