<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Album extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'album_art',
        'description',
        'release_date',
        'artist',
        'rating',
        'order',
        'user_id'
    ];

    protected $casts = [
        'release_date' => 'date',
        'rating' => 'integer',
        'order' => 'integer'
    ];

    protected $appends = ['album_art_url', 'rating_stars'];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function videos()
    {
        return $this->hasMany(AlbumVideo::class)->orderBy('track_number');
    }

    public function getAlbumArtUrlAttribute()
    {
        if ($this->album_art) {
            return asset('storage/' . $this->album_art);
        }
        return '/images/default-album.jpg';
    }

    public function getRatingStarsAttribute()
    {
        if (!$this->rating || $this->rating == 0) return '☆☆☆☆☆';
        $fullStars = str_repeat('★', $this->rating);
        $emptyStars = str_repeat('☆', 5 - $this->rating);
        return $fullStars . $emptyStars;
    }
}
