<?php

namespace App\Events;

use App\Models\SupportMessage;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class SupportMessageUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $supportMessage;

    public function __construct(SupportMessage $supportMessage)
    {
        $this->supportMessage = $supportMessage;
    }

    public function broadcastOn()
    {
        return new PrivateChannel('user.' . $this->supportMessage->user_id);
    }

    public function broadcastAs()
    {
        return 'message-updated';
    }

    public function broadcastWith()
    {
        return [
            'id' => $this->supportMessage->id,
            'status' => $this->supportMessage->status,
            'admin_response' => $this->supportMessage->admin_response,
            'rejection_reason' => $this->supportMessage->rejection_reason,
            'responded_at' => $this->supportMessage->responded_at?->toISOString()
        ];
    }
}
