<?php

namespace App\Http\Controllers;

use App\Models\Performance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class PerformanceController extends Controller
{
    public function index()
    {
        try {
            $performances = Performance::with('user:id,name')
                ->orderBy('performance_date', 'desc')
                ->orderBy('created_at', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $performances
            ]);
        } catch (\Exception $e) {
            Log::error('Performance index error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch performances'
            ], 500);
        }
    }

    public function getByCategory($category)
    {
        try {
            $performances = Performance::with('user:id,name')
                ->where('category', $category)
                ->orderBy('performance_date', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $performances
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch performances'
            ], 500);
        }
    }

    public function getCategories()
    {
        try {
            $categories = Performance::select('category')
                ->distinct()
                ->orderBy('category')
                ->pluck('category');

            return response()->json([
                'success' => true,
                'data' => $categories
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch categories'
            ], 500);
        }
    }

    public function show($id)
    {
        try {
            $performance = Performance::with('user:id,name')->findOrFail($id);
            $performance->increment('views');

            return response()->json([
                'success' => true,
                'data' => $performance
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Performance not found'
            ], 404);
        }
    }

    public function store(Request $request)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can add performances'
                ], 403);
            }

            $validated = $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'youtube_url' => 'required|url',
                'category' => 'required|string',
                'performance_date' => 'nullable|date',
                'show_name' => 'nullable|string'
            ]);

            $youtubeId = Performance::extractYouTubeId($validated['youtube_url']);
            if (!$youtubeId) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid YouTube URL'
                ], 422);
            }

            $performance = Performance::create([
                'title' => $validated['title'],
                'description' => $validated['description'] ?? null,
                'youtube_url' => $validated['youtube_url'],
                'youtube_id' => $youtubeId,
                'category' => $validated['category'],
                'performance_date' => $validated['performance_date'] ?? null,
                'show_name' => $validated['show_name'] ?? null,
                'user_id' => Auth::id(),
                'views' => 0
            ]);

            return response()->json([
                'success' => true,
                'data' => $performance->load('user:id,name'),
                'message' => 'Performance added successfully!'
            ], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Performance store error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to add performance'
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can update performances'
                ], 403);
            }

            $performance = Performance::findOrFail($id);

            $validated = $request->validate([
                'title' => 'sometimes|string|max:255',
                'description' => 'nullable|string',
                'youtube_url' => 'sometimes|url',
                'category' => 'sometimes|string',
                'performance_date' => 'nullable|date',
                'show_name' => 'nullable|string'
            ]);

            $updateData = [];

            if ($request->has('title')) $updateData['title'] = $validated['title'];
            if ($request->has('description')) $updateData['description'] = $validated['description'];
            if ($request->has('category')) $updateData['category'] = $validated['category'];
            if ($request->has('performance_date')) $updateData['performance_date'] = $validated['performance_date'];
            if ($request->has('show_name')) $updateData['show_name'] = $validated['show_name'];

            if ($request->has('youtube_url')) {
                $youtubeId = Performance::extractYouTubeId($validated['youtube_url']);
                if (!$youtubeId) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Invalid YouTube URL'
                    ], 422);
                }
                $updateData['youtube_url'] = $validated['youtube_url'];
                $updateData['youtube_id'] = $youtubeId;
            }

            $performance->update($updateData);

            return response()->json([
                'success' => true,
                'message' => 'Performance updated successfully',
                'data' => $performance->fresh()
            ]);

        } catch (\Exception $e) {
            Log::error('Performance update error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to update performance'
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete performances'
                ], 403);
            }

            $performance = Performance::findOrFail($id);
            $performance->delete();

            return response()->json([
                'success' => true,
                'message' => 'Performance deleted successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Performance delete error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete performance'
            ], 500);
        }
    }
}
