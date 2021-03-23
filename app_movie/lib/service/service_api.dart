// import 'package:app_movie/model/base_response/generic_collection.dart';
// import 'package:app_movie/model/movie.dart';
// import 'package:app_movie/model/movie_detail.dart';
// import 'package:app_movie/model/reviews.dart';
// import 'package:dio/dio.dart';
// import 'package:retrofit/http.dart';
// part 'service_api.g.dart';
//
// @RestApi(baseUrl: 'https://api.themoviedb.org/3/movie/')
// abstract class ServiceApi{
//   factory ServiceApi(Dio dio, {String baseUrl}) = _ServiceApi;
//
//   @GET('popular?api_key=095a1beb261c7c8385ebb67348b42df7&page={page}')
//   Future<GenericCollection<Movie>> getMovies(@Path('page') int page);
//
//   @GET('{id}/similar?api_key=095a1beb261c7c8385ebb67348b42df7')
//   Future<GenericCollection<Movie>> getSimilarMovies(@Path('id') String id);
//
//   @GET('trending/all/week?api_key=095a1beb261c7c8385ebb67348b42df7&page={page}')
//
//   @GET('{id}?api_key=095a1beb261c7c8385ebb67348b42df7')
//   Future<MovieDetail> getDetailMovie(@Path('id') String id);
//
//   @GET('search/movie?api_key=095a1beb261c7c8385ebb67348b42df7')
//   Future<GenericCollection<Movie>> searchMovie(@Query('query') String query);
//
//   @GET('{id}/reviews?api_key=095a1beb261c7c8385ebb67348b42df7')
//   Future<GenericCollection<Review>> getReviews(@Path('id') String id);
//
//
//
// }