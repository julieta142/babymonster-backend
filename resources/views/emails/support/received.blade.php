@component('mail::message')
# New Support Message

A new support message has been received from **{{ $supportMessage->user->name }}** ({{ $supportMessage->user->email }}).

## Subject: {{ $supportMessage->subject }}

**Message:**
{{ $supportMessage->message }}

@component('mail::button', ['url' => config('app.frontend_url') . '/admin/support/' . $supportMessage->id])
View Message
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent
