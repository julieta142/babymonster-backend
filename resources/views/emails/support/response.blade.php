@component('mail::message')
# Response to Your Support Request

Hello {{ $supportMessage->user->name }},

Your support request has been reviewed by our admin.

**Subject:** {{ $supportMessage->subject }}
**Status:** {{ ucfirst($supportMessage->status) }}

@if($supportMessage->status === 'resolved')
**Admin Response:**
{{ $supportMessage->admin_response }}

Your account has been reviewed and the issue has been resolved.
@elseif($supportMessage->status === 'rejected')
**Admin Response:**
{{ $supportMessage->admin_response }}

**Reason for rejection:**
{{ $supportMessage->rejection_reason }}
@endif

@component('mail::button', ['url' => config('app.frontend_url') . '/support-status'])
View Status
@endcomponent

Thanks,<br>
{{ config('app.name') }}
@endcomponent
