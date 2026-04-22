<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TourImage extends Model
{
    use HasFactory;

    protected $fillable = [
        'tour_id',
        'tour_country_id',
        'image_path',
        'caption',
        'sort_order'
    ];

    protected $appends = ['image_url'];

    public function tour()
    {
        return $this->belongsTo(Tour::class);
    }

    public function country()
    {
        return $this->belongsTo(TourCountry::class, 'tour_country_id');
    }

    public function getImageUrlAttribute()
    {
        if ($this->image_path) {
            return asset('storage/' . $this->image_path);
        }
        return null;
    }
}
