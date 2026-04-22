<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AlbumVideo extends Model
{
    use HasFactory;

    protected $table = 'album_videos';

    protected $fillable = [
        'album_id',
        'title',
        'youtube_url',
        'youtube_id',
        'track_number',
        'duration',
        'audio_file',
        'audio_file_name',
        'lyrics',
    ];

    protected $appends = ['embed_url', 'thumbnail_url', 'audio_url'];

    public function album()
    {
        return $this->belongsTo(Album::class);
    }

    public function getEmbedUrlAttribute()
    {
        return "https://www.youtube.com/embed/{$this->youtube_id}";
    }

    public function getThumbnailUrlAttribute()
    {
        return "https://img.youtube.com/vi/{$this->youtube_id}/maxresdefault.jpg";
    }

    public function getAudioUrlAttribute()
    {
        if ($this->audio_file) {
            return asset('storage/' . $this->audio_file);
        }
        return null;
    }

    public static function extractYouTubeId($url)
    {
        preg_match('/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/', $url, $matches);
        return $matches[1] ?? null;
    }
}
