<?php

namespace App\Http\Controllers;

use App\Http\Requests\UsersRequest;
use App\Models\Post;
use App\Models\Role;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class UserController extends Controller
{
    /**
     * Display the specified resource.
     */
    public function show(Request $request, User $user): View
    {

        return view('users.show', [
            'user' => $user,
            'posts_count' => $user->posts()->count(),
            'posts' => $user->posts()->latest()->limit(5)->get(),
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function my_posts(Request $request): View
    {
        $user = auth()->user();
        return view('myposts.index', [
            'user' => $user,
            'posts' => Post::latest()->paginate(50)
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(): View
    {
        $user = auth()->user();

        $this->authorize('update', $user);

        return view('users.edit', [
            'user' => $user,
            'roles' => Role::all()
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UsersRequest $request): RedirectResponse
    {
        $user = auth()->user();

        $this->authorize('update', $user);

        $user->update($request->validated());

        return redirect()->route('users.edit')->withSuccess(__('users.updated'));
    }
}
