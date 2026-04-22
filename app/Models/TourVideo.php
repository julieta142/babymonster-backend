<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TourVideo extends Model
{
    use HasFactory;

    protected $fillable = [
        'tour_id',
        'tour_country_id',
        'title',
        'youtube_url',
        'youtube_id',
        'video_type',
        'sort_order'
    ];

    protected $appends = ['embed_url', 'thumbnail_url'];

    public function tour()
    {
        return $this->belongsTo(Tour::class);
    }

    public function country()
    {
        return $this->belongsTo(TourCountry::class, 'tour_country_id');
    }

    public function getEmbedUrlAttribute()
    {
        return "https://www.youtube.com/embed/{$this->youtube_id}";
    }

    public function getThumbnailUrlAttribute()
    {
        return "https://img.youtube.com/vi/{$this->youtube_id}/maxresdefault.jpg";
    }

    public static function extractYouTubeId($url)
    {
        preg_match('/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/', $url, $matches);
        return $matches[1] ?? null;
    }

public function getTypeBadgeAttribute()
{
    $badges = [
        'performance' => 'bg-purple-500',
        'behind' => 'bg-blue-500',
        'announcement' => 'bg-green-500',
        'interview' => 'bg-orange-500'
    ];
    $labels = [
        'performance' => 'Performance',
        'behind' => 'Behind',
        'announcement' => 'Announcement',
        'interview' => 'Interview'
    ];
    return [
        'color' => $badges[$this->video_type] ?? 'bg-gray-500',
        'label' => $labels[$this->video_type] ?? $this->video_type
    ];
}
}
