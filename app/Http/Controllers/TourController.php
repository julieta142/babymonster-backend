<?php

namespace App\Http\Controllers;

use App\Models\Tour;
use App\Models\TourCountry;
use App\Models\TourVideo;
use App\Models\TourImage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;

class TourController extends Controller
{
    public function index()
    {
        try {
            $tours = Tour::with('user:id,name')
                ->orderBy('sort_order')
                ->orderBy('start_date', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $tours
            ]);
        } catch (\Exception $e) {
            Log::error('Tour index error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch tours'
            ], 500);
        }
    }

public function show($id)
{
    try {
        $tourId = (int) $id;
        $tour = Tour::with([
            'user:id,name',
            'countries',
            'videos.country',
            'images.country'
        ])->find($tourId);

        if (!$tour) {
            return response()->json([
                'success' => false,
                'message' => 'Tour not found'
            ], 404);
        }

        $tourData = $tour->toArray();
        $tourData['grouped_countries'] = $tour->grouped_countries;

        return response()->json([
            'success' => true,
            'data' => $tourData
        ]);
    } catch (\Exception $e) {
        Log::error('Tour show error: ' . $e->getMessage());
        return response()->json([
            'success' => false,
            'message' => 'Failed to load tour: ' . $e->getMessage()
        ], 500);
    }
}

    public function store(Request $request)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can create tours'
                ], 403);
            }

            $validated = $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'start_date' => 'nullable|date',
                'end_date' => 'nullable|date',
                'status' => 'required|in:upcoming,ongoing,completed',
                'sort_order' => 'nullable|integer',
                'poster_image' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:5120'
            ]);

            $tourData = [
                'title' => $validated['title'],
                'description' => $validated['description'] ?? null,
                'start_date' => $validated['start_date'] ?? null,
                'end_date' => $validated['end_date'] ?? null,
                'status' => $validated['status'],
                'sort_order' => $validated['sort_order'] ?? 0,
                'user_id' => Auth::id()
            ];

            if ($request->hasFile('poster_image')) {
                $file = $request->file('poster_image');
                $filename = time() . '_tour_' . uniqid() . '.' . $file->getClientOriginalExtension();
                $path = $file->storeAs('tour_posters', $filename, 'public');
                $tourData['poster_image'] = $path;
            }

            $tour = Tour::create($tourData);

            return response()->json([
                'success' => true,
                'data' => $tour,
                'message' => 'Tour created successfully'
            ], 201);

        } catch (\Exception $e) {
            Log::error('Tour store error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to create tour: ' . $e->getMessage()
            ], 500);
        }
    }

    public function update(Request $request, $id)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can update tours'
                ], 403);
            }

            $tour = Tour::findOrFail($id);

            $validated = $request->validate([
                'title' => 'sometimes|string|max:255',
                'description' => 'nullable|string',
                'start_date' => 'nullable|date',
                'end_date' => 'nullable|date',
                'status' => 'sometimes|in:upcoming,ongoing,completed',
                'sort_order' => 'nullable|integer',
                'poster_image' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:5120'
            ]);

            $updateData = [];

            if ($request->has('title')) $updateData['title'] = $validated['title'];
            if ($request->has('description')) $updateData['description'] = $validated['description'];
            if ($request->has('start_date')) $updateData['start_date'] = $validated['start_date'];
            if ($request->has('end_date')) $updateData['end_date'] = $validated['end_date'];
            if ($request->has('status')) $updateData['status'] = $validated['status'];
            if ($request->has('sort_order')) $updateData['sort_order'] = $validated['sort_order'];

            if ($request->hasFile('poster_image')) {
                if ($tour->poster_image && Storage::disk('public')->exists($tour->poster_image)) {
                    Storage::disk('public')->delete($tour->poster_image);
                }

                $file = $request->file('poster_image');
                $filename = time() . '_tour_' . uniqid() . '.' . $file->getClientOriginalExtension();
                $path = $file->storeAs('tour_posters', $filename, 'public');
                $updateData['poster_image'] = $path;
            }

            $tour->update($updateData);

            return response()->json([
                'success' => true,
                'data' => $tour->fresh(),
                'message' => 'Tour updated successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Tour update error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to update tour'
            ], 500);
        }
    }

    public function destroy($id)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete tours'
                ], 403);
            }

            $tour = Tour::findOrFail($id);

            if ($tour->poster_image && Storage::disk('public')->exists($tour->poster_image)) {
                Storage::disk('public')->delete($tour->poster_image);
            }

            foreach ($tour->images as $image) {
                if (Storage::disk('public')->exists($image->image_path)) {
                    Storage::disk('public')->delete($image->image_path);
                }
            }

            $tour->delete();

            return response()->json([
                'success' => true,
                'message' => 'Tour deleted successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Tour delete error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete tour'
            ], 500);
        }
    }

    public function addCountry(Request $request, $tourId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can add countries'
                ], 403);
            }

            $tour = Tour::findOrFail($tourId);

            $validated = $request->validate([
                'country' => 'required|string|max:255',
                'city' => 'required|string|max:255',
                'venue' => 'required|string|max:255',
                'start_date' => 'required|date',
                'end_date' => 'nullable|date|after_or_equal:start_date',
                'ticket_link' => 'nullable|url',
                'sort_order' => 'nullable|integer'
            ]);

            $country = TourCountry::create([
                'tour_id' => $tourId,
                'country' => $validated['country'],
                'city' => $validated['city'],
                'venue' => $validated['venue'],
                'start_date' => $validated['start_date'],
                'end_date' => $validated['end_date'] ?? null,
                'ticket_link' => $validated['ticket_link'] ?? null,
                'sort_order' => $validated['sort_order'] ?? 0
            ]);

            return response()->json([
                'success' => true,
                'data' => $country,
                'message' => 'Country added successfully'
            ], 201);

        } catch (\Exception $e) {
            Log::error('Add country error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to add country'
            ], 500);
        }
    }

    public function updateCountry(Request $request, $tourId, $countryId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can update countries'
                ], 403);
            }

            $country = TourCountry::where('tour_id', $tourId)->findOrFail($countryId);

            $validated = $request->validate([
                'country' => 'sometimes|string|max:255',
                'city' => 'sometimes|string|max:255',
                'venue' => 'sometimes|string|max:255',
                'start_date' => 'sometimes|date',
                'end_date' => 'nullable|date|after_or_equal:start_date',
                'ticket_link' => 'nullable|url',
                'sort_order' => 'nullable|integer'
            ]);

            $country->update($validated);

            return response()->json([
                'success' => true,
                'data' => $country,
                'message' => 'Country updated successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Update country error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to update country'
            ], 500);
        }
    }

    public function deleteCountry($tourId, $countryId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete countries'
                ], 403);
            }

            $country = TourCountry::where('tour_id', $tourId)->findOrFail($countryId);
            $country->delete();

            return response()->json([
                'success' => true,
                'message' => 'Country deleted successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Delete country error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete country'
            ], 500);
        }
    }

    public function addVideo(Request $request, $tourId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can add videos'
                ], 403);
            }

            $tour = Tour::findOrFail($tourId);

            $validated = $request->validate([
                'title' => 'required|string|max:255',
                'youtube_url' => 'required|url',
                'tour_country_id' => 'nullable|exists:tour_countries,id',
                'video_type' => 'required|in:performance,behind,vlog,interview',
                'sort_order' => 'nullable|integer'
            ]);

            $youtubeId = TourVideo::extractYouTubeId($validated['youtube_url']);
            if (!$youtubeId) {
                return response()->json([
                    'success' => false,
                    'message' => 'Invalid YouTube URL'
                ], 422);
            }

            $video = TourVideo::create([
                'tour_id' => $tourId,
                'title' => $validated['title'],
                'youtube_url' => $validated['youtube_url'],
                'youtube_id' => $youtubeId,
                'tour_country_id' => $validated['tour_country_id'] ?? null,
                'video_type' => $validated['video_type'],
                'sort_order' => $validated['sort_order'] ?? 0
            ]);

            return response()->json([
                'success' => true,
                'data' => $video->load('country'),
                'message' => 'Video added successfully'
            ], 201);

        } catch (\Exception $e) {
            Log::error('Add video error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to add video'
            ], 500);
        }
    }

    public function deleteVideo($tourId, $videoId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete videos'
                ], 403);
            }

            $video = TourVideo::where('tour_id', $tourId)->findOrFail($videoId);
            $video->delete();

            return response()->json([
                'success' => true,
                'message' => 'Video deleted successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Delete video error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete video'
            ], 500);
        }
    }

    public function addImage(Request $request, $tourId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can add images'
                ], 403);
            }

            $tour = Tour::findOrFail($tourId);

            $validated = $request->validate([
                'image' => 'required|image|mimes:jpeg,png,jpg,webp|max:10240',
                'caption' => 'nullable|string|max:255',
                'tour_country_id' => 'nullable|exists:tour_countries,id',
                'sort_order' => 'nullable|integer'
            ]);

            $file = $request->file('image');
            $filename = time() . '_tour_img_' . uniqid() . '.' . $file->getClientOriginalExtension();
            $path = $file->storeAs('tour_images', $filename, 'public');

            $image = TourImage::create([
                'tour_id' => $tourId,
                'image_path' => $path,
                'caption' => $validated['caption'] ?? null,
                'tour_country_id' => $validated['tour_country_id'] ?? null,
                'sort_order' => $validated['sort_order'] ?? 0
            ]);

            return response()->json([
                'success' => true,
                'data' => $image,
                'message' => 'Image added successfully'
            ], 201);

        } catch (\Exception $e) {
            Log::error('Add image error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to add image'
            ], 500);
        }
    }

    public function deleteImage($tourId, $imageId)
    {
        try {
            if (!Auth::user()->hasRole('superadmin') && !Auth::user()->hasRole('admin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Only administrators can delete images'
                ], 403);
            }

            $image = TourImage::where('tour_id', $tourId)->findOrFail($imageId);

            if (Storage::disk('public')->exists($image->image_path)) {
                Storage::disk('public')->delete($image->image_path);
            }

            $image->delete();

            return response()->json([
                'success' => true,
                'message' => 'Image deleted successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Delete image error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to delete image'
            ], 500);
        }
    }
}
