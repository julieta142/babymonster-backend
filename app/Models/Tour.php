<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tour extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'poster_image',
        'start_date',
        'end_date',
        'status',
        'sort_order',
        'user_id'
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
    ];

    protected $appends = ['poster_url', 'countries_count', 'videos_count', 'images_count'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function countries()
    {
        return $this->hasMany(TourCountry::class)->orderBy('start_date');
    }

    public function videos()
    {
        return $this->hasMany(TourVideo::class)->orderBy('sort_order');
    }

    public function images()
    {
        return $this->hasMany(TourImage::class)->orderBy('sort_order');
    }

    public function getPosterUrlAttribute()
    {
        if ($this->poster_image) {
            return asset('storage/' . $this->poster_image);
        }
        return '/images/default-tour.jpg';
    }

    public function getCountriesCountAttribute()
    {
        return $this->countries()->count();
    }

    public function getVideosCountAttribute()
    {
        return $this->videos()->count();
    }

    public function getImagesCountAttribute()
    {
        return $this->images()->count();
    }

    public function getStatusBadgeAttribute()
    {
        $badges = [
            'upcoming' => 'bg-yellow-500',
            'ongoing' => 'bg-green-500',
            'completed' => 'bg-gray-500'
        ];
        $labels = [
            'upcoming' => 'Upcoming',
            'ongoing' => 'Ongoing',
            'completed' => 'Completed'
        ];
        return [
            'color' => $badges[$this->status] ?? 'bg-gray-500',
            'label' => $labels[$this->status] ?? $this->status
        ];
    }

public function getGroupedCountriesAttribute()
{
    $grouped = [];

    foreach ($this->countries as $country) {
        $key = $country->country;

        if (!isset($grouped[$key])) {
            $grouped[$key] = [
                'country' => $country->country,
                'flag_emoji' => $country->flag_emoji,
                'shows' => []
            ];
        }

        $grouped[$key]['shows'][] = [
            'id' => $country->id,
            'city' => $country->city,
            'venue' => $country->venue,
            'start_date' => $country->start_date,
            'end_date' => $country->end_date,
            'ticket_link' => $country->ticket_link,
            'sort_order' => $country->sort_order
        ];
    }

    foreach ($grouped as &$group) {
        usort($group['shows'], function($a, $b) {
            return strtotime($a['start_date']) - strtotime($b['start_date']);
        });
    }

    return array_values($grouped);
}
}
