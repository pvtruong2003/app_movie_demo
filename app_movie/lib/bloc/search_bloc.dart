import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/service/interceptors.dart';
import 'package:app_movie/service/service_api.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc{
  SearchBloc() {
    _dio = Dio();
    _dio.interceptors.add(LoggingInterceptor());
    _serviceApi = ServiceApi(_dio);
    _searchMovie?.sink?.add([]);
  }

  Dio _dio;
  ServiceApi _serviceApi;
  final BehaviorSubject<List<Movie>> _searchMovie =
      BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get searchMovies => _searchMovie?.stream;

  Future<void> searchLocal(String text) async {
    final List<Movie> list = _searchMovie?.value;
    list.where((Movie movie) => movie.title.contains(text)).toList();
    _searchMovie?.sink?.add(list);
  }

  Future<void> onSearchMovies({String text}) async {
    _serviceApi = ServiceApi(_dio, baseUrl: 'https://api.themoviedb.org/3/');
    try {
      Common.showLoading(navigatorKey.currentContext);
      final GenericCollection<Movie> data = await _serviceApi.searchMovie(text);
      _searchMovie?.sink?.add(data.results);
      Common.hideLoading(navigatorKey.currentContext);
    } on Exception catch (e, st) {
      _handleError(e);
      Common.hideLoading(navigatorKey.currentContext);
    }
  }

  String _handleError(Exception error) {
    String errorDescription = '';
    if (error is DioError) {
      final DioError dioError = error;
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = 'Connection timeout with API server';
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              'Connection to API server failed due to internet connection';
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = 'Receive timeout in connection with API server';
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              'Received invalid status code: ${dioError.response.statusCode}';
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = 'Send timeout in connection with API server';
          break;
      }
    } else {
      errorDescription = 'Unexpected error occured';
    }
    return errorDescription;
  }

  @override
  void onDispose() {
    _searchMovie?.close();
  }
}
