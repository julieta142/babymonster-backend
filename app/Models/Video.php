<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Video extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'description',
        'youtube_url',
        'youtube_id',
        'views',
        'user_id'
    ];

    protected $casts = [
        'views' => 'integer',
    ];

    protected $appends = ['embed_url', 'thumbnail_url'];

    public function user()
    {
        return $this->belongsTo(User::class);
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
}
