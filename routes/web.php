<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', "HomeController@index");
Route::get('/berita/{slug}/view', "HomeController@viewNews");
Route::get('/dashboard', "DashboardController@index");
Route::resource('berita',"NewsController");

Route::get('/tentang',"HomeController@about");
Route::get('/sejarah',"HomeController@history");
Route::get('/tradisi',"HomeController@tradisi");
Route::get('/wisata',"HomeController@wisata");
Route::get('/visi-misi',"HomeController@visiMisi");
Route::get('/struktur-organisasi',"HomeController@strukturOrganisasi");

Auth::routes();
