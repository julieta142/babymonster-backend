<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SupportMessage extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'admin_id',
        'subject',
        'message',
        'admin_response',
        'status',
        'rejection_reason',
        'read_at',
        'responded_at'
    ];

    protected $casts = [
        'read_at' => 'datetime',
        'responded_at' => 'datetime',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function admin()
    {
        return $this->belongsTo(User::class, 'admin_id');
    }

    public function markAsRead()
    {
        if (!$this->read_at) {
            $this->update(['read_at' => now()]);
        }
    }

    public function respond($adminId, $response, $status, $rejectionReason = null)
    {
        $this->update([
            'admin_id' => $adminId,
            'admin_response' => $response,
            'status' => $status,
            'rejection_reason' => $rejectionReason,
            'responded_at' => now()
        ]);
    }
}
