<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Shows extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        // 'description',
        'show_date',
        'youtube_url',
        'youtube_id',
        'category',
        'user_id'
    ];

    protected $casts = [
        'show_date' => 'date',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    protected $appends = ['embed_url', 'thumbnail_url', 'formatted_date'];

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

    public function getFormattedDateAttribute()
    {
        if (!$this->show_date) return null;
        return $this->show_date->format('F j, Y');
    }

    public static function extractYouTubeId($url)
    {
        preg_match('/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/', $url, $matches);
        return $matches[1] ?? null;
    }
}
