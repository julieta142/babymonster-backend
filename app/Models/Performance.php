<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Performance extends Model
{
    use HasFactory;

    protected $table = 'performances';

    protected $fillable = [
        'title',
        'description',
        'youtube_url',
        'youtube_id',
        'category',
        'thumbnail_url',
        'performance_date',
        'show_name',
        'views',
        'user_id'
    ];

    protected $casts = [
        'performance_date' => 'date',
        'views' => 'integer',
    ];

    protected $appends = ['embed_url', 'video_thumbnail_url'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function getEmbedUrlAttribute()
    {
        return "https://www.youtube.com/embed/{$this->youtube_id}";
    }

    public function getVideoThumbnailUrlAttribute()
    {
        if ($this->thumbnail_url) {
            return $this->thumbnail_url;
        }
        return "https://img.youtube.com/vi/{$this->youtube_id}/maxresdefault.jpg";
    }

    public static function extractYouTubeId($url)
    {
        preg_match('/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/', $url, $matches);
        return $matches[1] ?? null;
    }
}
