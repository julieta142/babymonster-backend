<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Casts\Attribute;
use App\Models\LoginHistory;
use Illuminate\Support\Facades\Request;


/**
 * @method bool hasPermission(string $permissionName)
 * @method bool hasRole(string $roleName)
 * @method void assignRole(string $roleName)
 * @method void removeRole(string $roleName)
 * @method \Illuminate\Database\Eloquent\Relations\BelongsToMany roles()
 *
 * @property-read \Illuminate\Database\Eloquent\Collection|\App\Models\Role[] $roles
 */
class User extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    protected $fillable = [
        'name',
        'email',
        'password',
        'gender',
        'avatar',
        'is_blocked',
        'bio',
        'is_private',
        'background_url'
    ];

    protected $hidden = ['password', 'remember_token'];

    protected $appends = ['avatar_url'];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'is_blocked' => 'boolean',
            'is_private' => 'boolean',
        ];
    }

    protected function avatarUrl(): Attribute
    {
        return Attribute::make(
            get: function () {
                if ($this->avatar) {
                    return asset('storage/' . $this->avatar);
                }
                return $this->getDefaultAvatar();
            }
        );
    }

    protected function getDefaultAvatar()
    {
        $gender = $this->gender ?? 'prefer_not_to_say';
        $filename = match($gender) {
            'male' => 'male.png',
            'female' => 'female.png',
            default => 'default.png',
        };

        return asset("uploads/avatar/{$filename}");
    }

    public function videos()
    {
        return $this->hasMany(Video::class);
    }

    public function roles()
    {
        return $this->belongsToMany(Role::class, 'role_user')->withTimestamps();
    }

public function hasRole($roleName)
{
    return $this->roles()->where('name', $roleName)->exists();
}

public function hasPermission($permissionName)
{
    if ($this->hasRole('superadmin')) {
        return true;
    }

    if ($this->hasRole('admin')) {
        // List of permissions that admin CANNOT access
        $adminRestricted = [
            'view_users',
            'block_users',
            'manage_roles',
            'manage_permissions',
            'assign_roles'
        ];

        return !in_array($permissionName, $adminRestricted);
    }

    if ($this->hasRole('user')) {
        $userAllowed = [
            'edit_profile',
            'upload_videos',
            'view_news'
        ];

        return in_array($permissionName, $userAllowed);
    }

    return false;
}

public function assignRole($roleName)
{
    $role = Role::where('name', $roleName)->first();
    if ($role && !$this->hasRole($roleName)) {
        $this->roles()->attach($role->id);
    }
}

public function removeRole($roleName)
{
    $role = Role::where('name', $roleName)->first();
    if ($role) {
        $this->roles()->detach($role->id);
    }
}

public function getAllPermissions()
{
    if ($this->hasRole('superadmin')) {
        return Permission::all();
    }

    if ($this->hasRole('admin')) {
        return Permission::whereNotIn('name', ['view_users', 'block_users', 'manage_roles', 'manage_permissions', 'assign_roles'])->get();
    }

    if ($this->hasRole('user')) {
        return Permission::whereIn('name', ['edit_profile', 'upload_videos'])->get();
    }

    return collect();
}

    public function isBlocked()
    {
        return $this->is_blocked;
    }

    public function block()
    {
        $this->update([
            'is_blocked' => true,
            'blocked_at' => now(),
            'blocked_by' => Auth::id(),
        ]);
    }

    public function unblock()
    {
        $this->update([
            'is_blocked' => false,
            'blocked_at' => null,
            'blocked_by' => null,
        ]);
    }

    public function loginHistories()
{
    return $this->hasMany(LoginHistory::class);
}

public function recordLogin($provider = 'email')
{
    $userAgent = Request::userAgent();
    $deviceType = $this->getDeviceType($userAgent);
    $browser = $this->getBrowser($userAgent);
    $os = $this->getOS($userAgent);

    return LoginHistory::create([
        'user_id' => $this->id,
        'provider' => $provider,
        'ip_address' => Request::ip(),
        'user_agent' => $userAgent,
        'device_type' => $deviceType,
        'browser' => $browser,
        'os' => $os,
        'login_at' => now()
    ]);
}

public function updateLastLogin()
{
    $this->update([
        'last_login_at' => now(),
        'last_login_ip' => Request::ip()
    ]);
}

private function getDeviceType($userAgent)
{
    if (str_contains($userAgent, 'Mobile')) return 'mobile';
    if (str_contains($userAgent, 'Tablet')) return 'tablet';
    return 'desktop';
}

private function getBrowser($userAgent)
{
    if (str_contains($userAgent, 'Chrome')) return 'Chrome';
    if (str_contains($userAgent, 'Firefox')) return 'Firefox';
    if (str_contains($userAgent, 'Safari')) return 'Safari';
    if (str_contains($userAgent, 'Edge')) return 'Edge';
    return 'Unknown';
}

private function getOS($userAgent)
{
    if (str_contains($userAgent, 'Windows')) return 'Windows';
    if (str_contains($userAgent, 'Mac')) return 'macOS';
    if (str_contains($userAgent, 'Linux')) return 'Linux';
    if (str_contains($userAgent, 'Android')) return 'Android';
    if (str_contains($userAgent, 'iOS')) return 'iOS';
    return 'Unknown';
}

public function supportMessages()
{
    return $this->hasMany(SupportMessage::class, 'user_id');
}

public function adminResponses()
{
    return $this->hasMany(SupportMessage::class, 'admin_id');
}

// public function hasPendingSupportMessage()
// {
//     return $this->supportMessages()
//         ->whereIn('status', ['pending', 'in_review'])
//         ->exists();
// }

}
