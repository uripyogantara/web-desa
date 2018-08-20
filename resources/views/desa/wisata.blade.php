@extends('layouts.home')

@section('title','Wisata Desa Seraya')

@section('content')
<div class="main-content-wrapper section-padding-100">
    <div class="container">
        <div class="row justify-content-center">
            <!-- ============= Post Content Area Start ============= -->
            <div class="col-12 col-lg-8">
                <div class="post-content-area mb-100">
                    <!-- Catagory Area -->
                    <div class="world-catagory-area">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="title">Pariwisata</li>
                        </ul>

                        <div class="tab-content" id="myTabContent">

                            <div class="tab-pane fade show active" id="world-tab-1" role="tabpanel" aria-labelledby="tab1">
                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-4 d-flex align-items-center">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="{{asset('images/pariwisata/batu-telu.jpg')}}" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5>Pantai Batu Telu</h5>
                                        </a>
                                        <p>Salah satu daerah pariwisata yang ada di desa Seraya adalah pantai Batu Telu, pantai tersebut terletak di sebelah timur desa Seraya. Jalan untuk mencapai Pantai Batu Telu tidak terlalu jauh dari pusat desa yaitu kantor desa, sekitar + 2 Km.</p>
                                    </div>
                                </div>

                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-4 d-flex align-items-center">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="{{asset('images/pariwisata/bias-lantang.jpg')}}" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5>Pantai Bias Lantang</h5>
                                        </a>
                                        <p>Pantai Bias Lantang merupakan salah satu pantai yang ada di Desa Seraya. Pantai ini terletak di Banjar Dinas Belubuh.</p>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ========== Sidebar Area ========== -->
            <div class="col-12 col-md-8 col-lg-4">
                <div class="post-sidebar-area">
                    <!-- Widget Area -->
                    <div class="sidebar-widget-area">
                        <h5 class="title">Berita</h5>
                        <div class="widget-content">
                            @foreach($other_news as $news)
                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-2 d-flex align-items-center widget-post">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="{{asset("images/news/$news->image")}}" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5 class="mb-0">{{$news->title}}</h5>
                                        </a>
                                    </div>
                                </div>
                                @endforeach
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Load More btn -->
        <div class="row">
            <div class="col-12">
                <div class="load-more-btn mt-50 text-center">
                    <a href="#" class="btn world-btn">Load More</a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection