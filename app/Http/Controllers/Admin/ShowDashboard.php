<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Post;
use App\Models\User;
use Illuminate\View\View;

class ShowDashboard extends Controller
{
    /**
     * Show the application admin dashboard.
     */
    public function __invoke(): View
    {
        return view('admin.dashboard.index', [

            'posts' => Post::get(),
            'users' => User::get(),
        ]);
    }
}
