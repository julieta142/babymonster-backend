<?php

namespace App\Mail;

use App\Models\LoginHistory;
use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class LoginNotificationMail extends Mailable
{
    use Queueable, SerializesModels;

    public $user;
    public $loginHistory;

    public function __construct(User $user, LoginHistory $loginHistory)
    {
        $this->user = $user;
        $this->loginHistory = $loginHistory;
    }

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'New Login to Your BABYMONSTER Account 🔐',
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.login-notification',
        );
    }
}
