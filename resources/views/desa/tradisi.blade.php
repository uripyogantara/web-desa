@extends('layouts.home')

@section('title','Tradisi Desa Seraya')

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
                            <li class="title">Tradisi dan Budaya</li>
                        </ul>

                        <div class="tab-content" id="myTabContent">

                            <div class="tab-pane fade show active" id="world-tab-1" role="tabpanel" aria-labelledby="tab1">
                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-4 d-flex align-items-center">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="{{asset('images/tradisi/pura-bhur.jpg')}}" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5>Pura Bhur Bwah Swah</h5>
                                        </a>
                                        <p>Pura Bhur Loka ini terletak di gunung sebelah utara desa Seraya. Sebenarnya masih ada pura lain yang terletak diatas dari pura Bhur Loka ini, yaitu pura Bwah Loka dan Swah Loka dimana kata Bhur, Bwah, Swah dalam kepercayaan umat Hindu melambangkan tiga dunia.
                                        </p>
                                    </div>
                                </div>

                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-4 d-flex align-items-center">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="{{asset('images/tradisi/gebug-ende.jpg')}}" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5>Gebug Ende</h5>
                                        </a>
                                        <p>Gebug Ende merupakan tari memohon hujan, mengingat jika musim kemarau desa Seraya mengalami kekeringan hebat. Tari ini memakai aksesoris kayu rotan, perisai dari anyaman, serta kain yang bercorak hitam dan putih.</p>
                                        
                                    </div>
                                </div>

                                <!-- Single Blog Post -->
                                <div class="single-blog-post post-style-4 d-flex align-items-center">
                                    <!-- Post Thumbnail -->
                                    <div class="post-thumbnail">
                                        <img src="{{asset('images/tradisi/kerajinan-ata.jpg')}}" alt="">
                                    </div>
                                    <!-- Post Content -->
                                    <div class="post-content">
                                        <a href="#" class="headline">
                                            <h5>Kerajinan Ata</h5>
                                        </a>
                                        <p>Ate adalah kerajinan tangan yang terbuat dari pohon ate yang dianyam sehingga berbentuk menjadi barang yang bernilai ekonomis. Hasil dari anyaman tersebut bermacam-macam, seperti; tempat sampah, tempat buku, tempat perhiasan, tempat kosmetik, tempat alat tulis, dan masih banyak yang lainnya. Kerajinan Ate dari Desa Seraya sendiri sudah terkenal hingga keluar desa.</p>
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