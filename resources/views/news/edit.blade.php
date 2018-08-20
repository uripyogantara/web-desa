@extends('dashboard.app')

@section('content')
<div class="row">
        <div class="col-sm-12">
            <div class="card card-body">
                <h4 class="card-title">Tambah Artikel</h4>
                {{-- <h6 class="card-subtitle"> Masukkan data suplier Anda </h6> --}}
                <form class="form-horizontal m-t-40" action="{{url("berita/$news->id")}}" method="POST" enctype="multipart/form-data">
                    @csrf
                    <input type="hidden" name="_method" value="PUT">
                    <div class="form-group">
                        <label>Judul Artikel</label>
                        <input type="text" class="form-control" name="title" value="{{$news->title}}">
                    </div>
                    <div class="form-group">
                        <label>Isi Artikel</label>
                        <textarea class="form-control" cols="30" rows="4" name="content">{{$news->content}}</textarea>
                    </div>
                    <div class="form-group">
                        <label>Gambar</label>
                        <input type="file" class="form-control" name="image">
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Simpan</button>
                </form>
            </div>
        </div>
    </div>
@endsection

