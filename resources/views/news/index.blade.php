@extends('dashboard.app')

@section('content')
{{-- <div class="row"> --}}
    @foreach($news as $new)
    <div class="card card-body">
        <div class="row">
            <div class="col-md-2 col-lg-2 text-center">
                <a href="app-contact-detail.html"><img src="{{asset("images/news/$new->image")}}" alt="user" width="150" class="img-circle"></a>
            </div>
            <div class="col-md-10 col-lg-10">
                <div class="row">
                    <div class="col-md-6">
                        <h3 class="box-title m-b-0"><b>{{$new->title}}</b> </h3> 
                    </div>
                    <div class="col-md-6">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <small>{{$new->content}}</small>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col d-flex justify-content-end">
                <a href="{{url("berita/$new->id")}}" class="btn btn-primary">Lihat Selengkapnya</a>
                <a href="{{url("berita/$new->id/edit")}}" class="btn btn-success">Edit</a>
                <form method="POST" action="/berita/{{$new->id}}" style="display: inline-block">
                    {{csrf_field()}}
                    <input type="hidden" name="_method" value="DELETE">
                    <button type="submit" class="btn btn-danger">Hapus</button>
                </form>
            </div>
        </div>
    </div>
    @endforeach
{{-- </div> --}}
@endsection

