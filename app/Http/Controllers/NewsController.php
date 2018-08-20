<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\News;
class NewsController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $news=news::orderBy('id','desc')->get();
        return view('news.index',compact('news'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('news.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'image' => 'mimes:jpeg,png|max:2048',
        ]);

        $slug=strtolower($request->title);
        $slug=str_replace(" ","-",$slug);
        if($request->hasFile('image')) {
            $image = $request->file('image');
            // TODO file name isi judul
            $image_name = $slug . '_' . date('YmdHis') . '.' . $image->extension();
            $destinationPath = 'images/news';
            $request->image->move($destinationPath, $image_name);
        }

        
        $news = new news();
        $news->title = $request->title;
        $news->content = $request->content;
        $news->slug = $slug;
        $news->image = $image_name;
        $news->save();
        return redirect('berita');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $news=news::find($id);
        return view('news.edit',compact('news'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'image' => 'mimes:jpeg,png|max:2048',
        ]);

        $slug=strtolower($request->title);
        $slug=str_replace(" ","-",$slug);
        
        $news = news::find($id);

        if($request->hasFile('image')) {
            $image = $request->file('image');
            // TODO file name isi judul
            $image_name = $slug . '_' . date('YmdHis') . '.' . $image->extension();
            $destinationPath = 'images/news';
            $request->image->move($destinationPath, $image_name);
            $news->image = $image_name;
        }

        
        $news->title = $request->title;
        $news->content = $request->content;
        $news->slug = $slug;
        $news->save();
        return redirect('berita');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $news=news::find($id);
        $news->delete();
        return redirect('berita');
    }
}
