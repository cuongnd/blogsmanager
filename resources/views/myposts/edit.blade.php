@extends('users.layout', ['tab' => 'my_posts'])

@section('content')
    <p>@lang('posts.show') : {{ link_to_route('posts.show', route('posts.show', $post), $post) }}</p>


    {!! Form::model($post, ['route' => ['update-my-post'], 'method' =>'PUT']) !!}
        @include('myposts/_form')

        <div class="pull-left">
            {{ link_to_route('my_posts', __('forms.actions.back'), [], ['class' => 'btn btn-secondary']) }}
            {!! Form::submit(__('forms.actions.update'), ['class' => 'btn btn-primary']) !!}
        </div>
    {!! Form::close() !!}

    {!! Form::model($post, ['method' => 'DELETE', 'route' => ['admin.posts.destroy', $post], 'class' => 'form-inline pull-right', 'data-confirm' => __('forms.posts.delete')]) !!}
        {!! Form::button('<i class="fa fa-trash" aria-hidden="true"></i> ' . __('posts.delete'), ['class' => 'btn btn-link text-danger', 'name' => 'submit', 'type' => 'submit']) !!}
    {!! Form::close() !!}
@endsection
