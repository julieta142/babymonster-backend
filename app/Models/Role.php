<?php
// app/Models/Role.php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    protected $fillable = ['name', 'display_name', 'description'];

    public function users()
    {
        return $this->belongsToMany(User::class, 'role_user')->withTimestamps();
    }

    public function permissions()
    {
        return $this->belongsToMany(Permission::class, 'permission_role')->withTimestamps();
    }

    public function hasPermission($permissionName)
    {
        if ($this->relationLoaded('permissions')) {
            return $this->permissions->contains('name', $permissionName);
        }
        return $this->permissions()->where('name', $permissionName)->exists();
    }

    public function givePermissionTo($permissionName)
    {
        $permission = Permission::where('name', $permissionName)->first();
        if ($permission && !$this->hasPermission($permissionName)) {
            $this->permissions()->attach($permission->id);
            $this->load('permissions');
            return true;
        }
        return false;
    }

    public function revokePermissionTo($permissionName)
    {
        $permission = Permission::where('name', $permissionName)->first();
        if ($permission) {
            $this->permissions()->detach($permission->id);
            $this->load('permissions');
            return true;
        }
        return false;
    }

    public function syncPermissions(array $permissionNames)
    {
        $permissionIds = Permission::whereIn('name', $permissionNames)->pluck('id')->toArray();
        $this->permissions()->sync($permissionIds);
        $this->load('permissions');
        return $this;
    }
}
