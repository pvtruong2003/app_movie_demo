import 'package:app_movie/model/debug_mode.dart';
import 'package:app_movie/model/list_debug.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor{

  final int _maxCharactersPerLine = 200;

  @override
  Future<void> onRequest(RequestOptions options) {

    print('--> ${options.method} ${options.path}');
    print('Content type: ${options.contentType}');
    print('<-- END HTTP');
    return super.onRequest(options);
  }

  @override
  Future<void> onResponse(Response<Object> response) {
    print('<-- ${response.statusCode} ${response.request.method} ${response.request.path}');

    DebugMode debugMode = DebugMode();
    debugMode.data = response.data;
    debugMode.method = response.request.method;
    debugMode.param = response.statusMessage;
    DebugMode.listDebug.add(debugMode);

    final String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      final int iterations =
      (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        print(responseAsString.substring(
            i * _maxCharactersPerLine, endingIndex));
      }
    } else {
      final Logger logger = Logger(
        printer: PrettyPrinter(
            methodCount: 2, // number of method calls to be displayed
            errorMethodCount: 8, // number of method calls if stacktrace is provided
            lineLength: 120, // width of the output
            colors: true, // Colorful log messages
            printEmojis: true, // Print an emoji for each log message
            // printTime: true // Should each log print contain a timestamp6♠
        )
      );
      //logger.d('Response Data', response.data);
    }
    print('<-- END HTTP');

    return super.onResponse(response);
  }

  @override
  Future<void> onError(DioError err) async{
    Logger.level = Level.warning;
    final Logger logger = Logger(
        printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount: 8, // number of method calls if stacktrace is provided
          lineLength: 120, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          // printTime: true // Should each log print contain a timestamp6♠
        )
    );
    logger.e('$Error log ${err.error}');
    return super.onError(err);
  }

}