<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TourCountry extends Model
{
    use HasFactory;

    protected $fillable = [
        'tour_id',
        'country',
        'city',
        'venue',
        'start_date',
        'end_date',
        'ticket_link',
        'sort_order'
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
    ];

    public function tour()
    {
        return $this->belongsTo(Tour::class);
    }

    public function videos()
    {
        return $this->hasMany(TourVideo::class);
    }

    public function images()
    {
        return $this->hasMany(TourImage::class);
    }

    public function getFlagEmojiAttribute()
    {
        $flags = [
            'Japan' => '🇯🇵',
            'USA' => '🇺🇸',
            'United States' => '🇺🇸',
            'America' => '🇺🇸',
            'South Korea' => '🇰🇷',
            'Korea' => '🇰🇷',
            'Thailand' => '🇹🇭',
            'Indonesia' => '🇮🇩',
            'Philippines' => '🇵🇭',
            'Singapore' => '🇸🇬',
            'Malaysia' => '🇲🇾',
            'Vietnam' => '🇻🇳',
            'Taiwan' => '🇹🇼',
            'Hong Kong' => '🇭🇰',
            'Macau' => '🇲🇴',
            'Australia' => '🇦🇺',
            'UK' => '🇬🇧',
            'United Kingdom' => '🇬🇧',
            'England' => '🇬🇧',
            'France' => '🇫🇷',
            'Germany' => '🇩🇪',
            'Brazil' => '🇧🇷',
            'Mexico' => '🇲🇽',
            'Canada' => '🇨🇦',
            'China' => '🇨🇳',
            'India' => '🇮🇳',
            'UAE' => '🇦🇪',
            'Saudi Arabia' => '🇸🇦',
            'Turkey' => '🇹🇷',
            'Italy' => '🇮🇹',
            'Spain' => '🇪🇸',
            'Netherlands' => '🇳🇱',
            'Belgium' => '🇧🇪',
            'Switzerland' => '🇨🇭',
            'Poland' => '🇵🇱',
            'Sweden' => '🇸🇪',
            'Norway' => '🇳🇴',
            'Denmark' => '🇩🇰',
            'Finland' => '🇫🇮',
            'Ireland' => '🇮🇪',
            'Portugal' => '🇵🇹',
            'Greece' => '🇬🇷',
            'Czech Republic' => '🇨🇿',
            'Hungary' => '🇭🇺',
            'Austria' => '🇦🇹',
            'Russia' => '🇷🇺',
            'South Africa' => '🇿🇦',
            'Egypt' => '🇪🇬',
            'Argentina' => '🇦🇷',
            'Chile' => '🇨🇱',
            'Colombia' => '🇨🇴',
            'Peru' => '🇵🇪',
        ];
        return $flags[$this->country] ?? '🌍';
    }

    public function getDateRangeAttribute()
    {
        if (!$this->start_date) return 'TBA';

        $start = date('M j', strtotime($this->start_date));

        if ($this->end_date && $this->start_date != $this->end_date) {
            $end = date('M j, Y', strtotime($this->end_date));
            return $start . ' - ' . $end;
        }

        return date('M j, Y', strtotime($this->start_date));
    }
}
