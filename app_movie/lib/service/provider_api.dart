import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/model/movies.dart';
import 'package:app_movie/model/list_movie.dart';
import 'package:app_movie/service/base_provider.dart';
import 'package:dio/dio.dart';

class ProviderAPI extends BaseApiProvider {
  static const String API_KEY = 'api_key=095a1beb261c7c8385ebb67348b42df7';
  Response<Map<String, dynamic>> _result;

  Future<GenericCollection<Movie>> getMovies(int page) async {
    _result = await dio.request<Map<String, dynamic>>(
        'popular?$API_KEY&page=$page',
        options: RequestOptions(method: 'GET', baseUrl: baseUrl));
    final dynamic value = GenericCollection<Movie>.fromJson(_result.data);
    return value;
  }

  Future<ListTrending> getTrending(int page) async {
    _result = await dio.request<Map<String, dynamic>>(
        'trending/all/week?$API_KEY&page=$page',
        options: RequestOptions(method: 'GET', baseUrl: baseUrl2));
    final value = ListTrending.fromJson(_result.data);
    return value;
  }

  Future<void> addRating({String id}) async {
     final body  =   FormData.fromMap({'value': 8.5});
    // final response = await dio.request<Map<String, dynamic>>('$id/rating?$API_KEY',
    //     options: RequestOptions(method: 'POST', baseUrl: baseUrl), data: body);
    // return ResponseRating.fromJson(response.data);
    final response = await dio.post(baseUrl+'$id/rating?$API_KEY', data: {'value': 8.5});
    print(response.data);
  }

  Future<ListMovie> getMoviesBy({int page, String path}) async {
    _result = await dio.request<Map<String, dynamic>>('$path?$API_KEY&page=$page',
        options: RequestOptions(method: 'GET', baseUrl: baseUrl));
    final value = ListMovie.fromJson(_result.data);
    return value;
  }

  Future<GenericCollection<Review>> getReviews(String id) async {
    _result = await dio.request<Map<String, dynamic>>(
      '$id/reviews?$API_KEY',
      options: RequestOptions(method: 'GET', baseUrl: baseUrl),
    );
    final dynamic value = GenericCollection<Review>.fromJson(_result.data);
    return value;
  }

  Future<GenericCollection<Movie>> getSimilarMovies(String id) async {
    _result = await dio.request<Map<String, dynamic>>(
      '$id/similar?$API_KEY',
      options: RequestOptions(
          method: 'GET', headers: <String, dynamic>{}, baseUrl: baseUrl),
    );
    final GenericCollection<Movie> value =
        GenericCollection<Movie>.fromJson(_result.data);
    return value;
  }


  Future<MovieDetail> getDetailMovie(String id) async {
    _result = await dio.request<Map<String, dynamic>>('$id?$API_KEY',
      options: RequestOptions(
          method: 'GET', headers: <String, dynamic>{}, baseUrl: baseUrl),
    );
    final MovieDetail value = MovieDetail.fromJson(_result.data);
    return value;
  }

  Future<GenericCollection<Movie>> searchMovie(String query) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      r'query': query
    };
    _result = await dio.request<Map<String, dynamic>>(
      'search/movie?$API_KEY',
      queryParameters: queryParameters,
      options: RequestOptions(
          method: 'GET', headers: <String, dynamic>{}, baseUrl: baseUrl),
    );
    final GenericCollection<Movie> value =
        GenericCollection<Movie>.fromJson(_result.data);
    return value;
  }
}
