@extends('layouts.home')

@section('title','Desa Seraya')
@section('content')

    <div class="main-content-wrapper section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <!-- ============= Post Content Area Start ============= -->
                <div class="col-12 col-lg-8">
                    <div class="post-content-area mb-50">
                        <!-- Catagory Area -->
                        <div class="world-catagory-area">
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="title">Berita</li>
                            </ul>

                            <div class="tab-content" id="myTabContent">

                                <div class="tab-pane fade show active" id="world-tab-1" role="tabpanel" aria-labelledby="tab1">
                                    <div class="row">
                                        <div class="col-12 col-md-6">
                                            <div class="world-catagory-slider owl-carousel wow fadeInUpBig" data-wow-delay="0.1s">
                                                
                                                @foreach($news as $new)
                                                <!-- Single Blog Post -->
                                                <div class="single-blog-post">
                                                    <!-- Post Thumbnail -->
                                                    <div class="post-thumbnail">
                                                    <img src="{{asset("images/news/$new->image")}}" alt="">
                                                    </div>
                                                    <!-- Post Content -->
                                                    <div class="post-content">
                                                        <a href="{{url("berita/$new->slug/view")}}" class="headline">
                                                            <h5>{{$new->title}}</h5>
                                                        </a>
                                                        <p>{{$new->content}}</p>
                                                        <!-- Post Meta -->
                                                        <div class="post-meta">
                                                            <p><a href="#" class="post-author">Katy Liu</a> on <a href="#" class="post-date">Sep 29, 2017 at 9:48 am</a></p>
                                                        </div>
                                                    </div>
                                                </div>
                                                @endforeach
                                            </div>
                                        </div>

                                        <div class="col-12 col-md-6">
                                            @foreach($news as $new)
                                            <!-- Single Blog Post -->
                                            <div class="single-blog-post post-style-2 d-flex align-items-center wow fadeInUpBig" data-wow-delay="0.2s">
                                                <!-- Post Thumbnail -->
                                                <div class="post-thumbnail">
                                                    <img src="{{asset("images/news/$new->image")}}" alt="">
                                                </div>
                                                <!-- Post Content -->
                                                <div class="post-content">
                                                    <a href="{{url("berita/$new->slug/view")}}" class="headline">
                                                        <h5>{{$new->title}}</h5>
                                                    </a>
                                                    <!-- Post Meta -->
                                                    <div class="post-meta">
                                                        <p><a href="#" class="post-author">Katy Liu</a> on <a href="#" class="post-date">Sep 29, 2017 at 9:48 am</a></p>
                                                    </div>
                                                </div>
                                            </div>
                                            @endforeach
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>

                <!-- ========== Sidebar Area ========== -->
                <div class="col-12 col-md-8 col-lg-4">
                    <div class="post-sidebar-area wow fadeInUpBig" data-wow-delay="0.2s">
                        <!-- Widget Area -->
                        
                        <!-- Widget Area -->
                        <div class="sidebar-widget-area">
                            <h5 class="title">Tentang Desa</h5>
                            <div class="widget-content">
                                <p style="text-align:justify;">Desa Seraya merupakan desa tua, dan bisa dikatakan desa Seraya merupakan desa tertua di Bali. Pernyataan ini mempunyai beberapa alasan, yaitu yang pertama; Bahasa. Desa Seraya memiliki bahasa Seraya yaitu bahasa khas yang mereka miliki dari turun temurun di samping bahasa Bali, yang mereka gunakan hanya kepada penduduk asli Seraya.</p>
                                <a href="{{url('tentang')}}">Lihat Selengkapnya</a>
                            </div>
                        </div>

                        <!-- Widget Area -->
                        <div class="sidebar-widget-area">
                            <h5 class="title">Perangkat Desa</h5>
                            <div class="widget-content">
                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-2 d-flex align-items-center widget-post">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="images/hari-raya/tumpek-kandang.jpg" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5 class="mb-0">Kepala Desa</h5>
                                        </a>
                                        <!-- Post Meta -->
                                        <div class="post-meta">
                                            <p><a href="#" class="post-author">I Made Wayan Ketut</a></p>
                                        </div>
                                    </div>
                                </div>
                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-2 d-flex align-items-center widget-post">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="images/hari-raya/buda-cemeng.jpg" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5 class="mb-0">Sekretaris Desa</h5>
                                        </a>
                                        <!-- Post Meta -->
                                        <div class="post-meta">
                                            <p><a href="#" class="post-author">I Made Wayan Ketut</a></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d63148.26429791887!2d115.63168666920762!3d-8.42457554232897!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dcdf879a5e0f337%3A0x5030bfbca8318b0!2sSeraya%2C+Karangasem+Sub-District%2C+Karangasem+Regency%2C+Bali!5e0!3m2!1sen!2sid!4v1534603549039" width="100%" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
@endsection