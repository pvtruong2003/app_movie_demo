import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/model/trend.dart';
import 'package:app_movie/service/base_provider.dart';
import 'package:dio/dio.dart';

class ProviderAPI extends BaseApiProvider {
  static const String API_KEY = 'api_key=095a1beb261c7c8385ebb67348b42df7';
  Response<Map<String, dynamic>> _result;

  Future<GenericCollection<Movie>> getMovies(int page) async {
    _result = await dio.request<Map<String, dynamic>>(
        'popular?$API_KEY&page=$page',
        options: RequestOptions(method: 'GET', baseUrl: baseUrl));
    final GenericCollection<Movie> value =
        GenericCollection<Movie>.fromJson(_result.data);
    return value;
  }

  Future<GenericCollection<Review>> getReviews(String id) async {
    _result = await dio.request<Map<String, dynamic>>(
      '$id/reviews?$API_KEY',
      options: RequestOptions(method: 'GET', baseUrl: baseUrl),
    );
    final GenericCollection<Review> value =
        GenericCollection<Review>.fromJson(_result.data);
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

  Future<GenericCollection<Trend>> getTrending(int page) async {
    _result = await dio.request<Map<String, dynamic>>(
      'trending/all/week?$API_KEY&page=$page',
      options: RequestOptions(
          method: 'GET', headers: <String, dynamic>{}, baseUrl: baseUrl),
    );
    final GenericCollection<Trend> value =
        GenericCollection<Trend>.fromJson(_result.data);
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