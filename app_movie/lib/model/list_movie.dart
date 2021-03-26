import 'package:app_movie/model/base_response/base_response.dart';
import 'package:app_movie/model/movies.dart';

class ListMovie extends BaseResponse {
  List<Movies> results;
  DateMovie dateComing;

  ListMovie.fromJson(Map<String, dynamic> js) : super.fromJson(js) {
    results = [];
    dynamic data = js['results'];
    dateComing = DateMovie.fromJson(js['dates']);
    for (var item in data) {
      results.add(Movies.fromJson(item));
    }
  }
}

class DateMovie {
  String maximum;
  String minimum;

  DateMovie.fromJson(Map<String, dynamic> js) {
    minimum = js['minimum'];
    maximum = js['maximum'];
  }
}
