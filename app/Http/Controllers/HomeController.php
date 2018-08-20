<?php

namespace App\Http\Controllers;
use DB;
use App\News;
use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        // $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request){
        $news=news::orderBy('id','desc')->get();
        // if (isset($request->date)) {
        //     $date=$request->date;
        // }else{
        //     $date=date('Y-m-d');
        // }
        // $data=DB::select("call getKalender('$date')"); 

        // foreach ($data as $key => $value) {
        //     $calendar=$value;
        // }
        return view('index',compact('news'));
    }

    public function viewNews($slug){
        $news=news::where('slug',$slug)->first();
        $other_news=news::
        where('slug','!=',$slug)
        ->orderBy('id','desc')->get();
        // return $newss;
        return view('view-news',compact('news','other_news'));
    }

    public function about(){
        return view('desa.about');
    }

    public function history(){
        return view('desa.history');
    }

    public function tradisi(){
        $other_news=news::orderBy('id','desc')->get();
        return view('desa.tradisi',compact('other_news'));
    }

    public function wisata(){
        $other_news=news::orderBy('id','desc')->get();
        return view('desa.wisata',compact('other_news'));
    }

    public function visiMisi(){
        return view('desa.visi-misi');
    }

    public function strukturOrganisasi(){
        return view('desa.struktur-organisasi');
    }
}
