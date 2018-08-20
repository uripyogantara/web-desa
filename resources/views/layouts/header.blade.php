<header class="header-area">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav class="navbar navbar-expand-lg">
                    <!-- Logo -->
                <a class="navbar-brand" href="{{url('/')}}"><img src="{{asset('images/logo.png')}}" alt="Logo"></a>
                    <!-- Navbar Toggler -->
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#worldNav" aria-controls="worldNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                    <!-- Navbar -->
                    <div class="collapse navbar-collapse" id="worldNav">
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item active">
                                <a class="nav-link" href="{{url('/')}}">Home <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Profil Desa</a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="{{url('tentang')}}">Tentang Desa</a>
                                    <a class="dropdown-item" href="{{url('sejarah')}}">Sejarah</a>
                                    <a class="dropdown-item" href="{{url('tradisi')}}">Tradisi dan Budaya</a>
                                    <a class="dropdown-item" href="{{url('wisata')}}">Objek Pariwisata</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Pemerintah Desa</a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="{{url('visi-misi')}}">Visi dan Misi</a>
                                    <a class="dropdown-item" href="{{url('struktur-organisasi')}}">Struktur Organisasi</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Data Penduduk</a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="index.html">Visi dan Misi</a>
                                    <a class="dropdown-item" href="catagory.html">Struktur Organisasi</a>
                                </div>
                            </li>
                        </ul>
                        <!-- Search Form  -->
                        <div id="search-wrapper">
                            <form action="#">
                                <input type="text" id="search" placeholder="Search something...">
                                <div id="close-icon"></div>
                                <input class="d-none" type="submit" value="">
                            </form>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
    </div>
</header>