<?php

namespace App\Events;

use App\Models\SupportMessage;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NewSupportMessage implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $supportMessage;

    public function __construct(SupportMessage $supportMessage)
    {
        $this->supportMessage = $supportMessage;
    }

    public function broadcastOn()
    {
        return new Channel('support-messages');
    }

    public function broadcastAs()
    {
        return 'new-message';
    }

    public function broadcastWith()
    {
        return [
            'id' => $this->supportMessage->id,
            'user' => $this->supportMessage->user->name,
            'subject' => $this->supportMessage->subject,
            'message' => $this->supportMessage->message,
            'created_at' => $this->supportMessage->created_at->toISOString()
        ];
    }
}
