import 'package:app_movie/service/interceptors.dart';
import 'package:dio/dio.dart';

class BaseApiProvider {
  BaseApiProvider() {
    final BaseOptions options =
        BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio = Dio(options);
    dio.interceptors.add(LoggingInterceptor());
  }

  String baseUrl = 'https://api.themoviedb.org/3/movie/';
  Dio dio;

  String handleError(Exception error) {
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
}
