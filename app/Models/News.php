<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class News extends Model
{
    protected $fillable = [
        'title',
        'slug',
        'description',
        'user_id',
        'news_date',
        'category'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function photos()
    {
        return $this->hasMany(NewsPhoto::class)->orderBy('order');
    }
}
