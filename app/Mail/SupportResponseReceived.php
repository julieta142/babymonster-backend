<?php

namespace App\Mail;

use App\Models\SupportMessage;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SupportResponseReceived extends Mailable
{
    use Queueable, SerializesModels;

    public $supportMessage;

    public function __construct(SupportMessage $supportMessage)
    {
        $this->supportMessage = $supportMessage;
    }

    public function build()
    {
        return $this->subject('Response to your support request')
                    ->markdown('emails.support.response');
    }
}
