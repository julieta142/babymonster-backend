<?php

namespace App\Mail;

use App\Models\SupportMessage;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SupportMessageReceived extends Mailable
{
    use Queueable, SerializesModels;

    public $supportMessage;

    public function __construct(SupportMessage $supportMessage)
    {
        $this->supportMessage = $supportMessage;
    }

    public function build()
    {
        return $this->subject('New Support Message from ' . $this->supportMessage->user->name)
                    ->markdown('emails.support.received');
    }
}
