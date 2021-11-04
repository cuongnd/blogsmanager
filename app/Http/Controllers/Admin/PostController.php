<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\PostsRequest;
use App\Models\Post;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class PostController extends Controller
{
    /**
     * Show the application posts index.
     */
    public function index(): View
    {
        $user = auth()->user();

        if($user->isAdmin())
        {
            return view('admin.posts.index', [
                'posts' => Post::latest()->paginate(50)
            ]);
        }else{
            $posts=Post::where('author_id', $user->id)->paginate(50);

            return view('admin.posts.index', [
                'posts' => $posts
            ]);
        }
    }

    /**
     * Display the specified resource edit form.
     */
    public function edit(Post $post): View
    {
        return view('admin.posts.edit', [
            'post' => $post,
            'users' => User::authors()->pluck('name', 'id'),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request): View
    {
        return view('admin.posts.create', [
            'users' => User::authors()->pluck('name', 'id'),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(PostsRequest $request): RedirectResponse
    {

        $user = auth()->user();
        if($user->isEditor()){
            $data=$request->only(['title', 'content', 'posted_at', 'thumbnail_id']);
            $data['author_id']=$user->id;
        }else{
            $data=$request->only(['title', 'content', 'posted_at', 'author_id', 'thumbnail_id']);

        }
        $data['slug'] = $data['title'].'-'.random_int(100,2000);
        $post = Post::create($data);
        return redirect()->route('admin.posts.edit', $post)->withSuccess(__('posts.created'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(PostsRequest $request, Post $post): RedirectResponse
    {
        $data=$request->only(['title', 'content', 'posted_at', 'author_id']);
        $user = auth()->user();
        if($user->isEditor()){
            $data['author_id']=$user->id;
        }
        $post->update($data);
        return redirect()->route('admin.posts.edit', $post)->withSuccess(__('posts.updated'));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Post  $post)
    {
        $post->delete();

        return redirect()->route('admin.posts.index')->withSuccess(__('posts.deleted'));
    }
}
