import 'package:app_movie/model/base_response/base_response.dart';

class Movies {
  int id;
  double voteAverage;
  String title;
  String posterPath;
  String overview;
  List<int> genreIds;
  String error;

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    voteAverage = (json['vote_average'] as num)?.toDouble();
    title = json['title'] as String;
    posterPath = json['poster_path'] as String;
    overview = json['overview'] as String;
    genreIds = (json['genre_ids'] as List<dynamic>)?.map((dynamic e) => e as int)?.toList();
  }

  Movies.withError(String value) : error = value;
}

class ListTrending extends BaseResponse {
  List<Movies> results = [];

  ListTrending.fromJson(Map<String, dynamic> js) : super.fromJson(js) {
    results = [];
    dynamic data = js['results'];
    for (var item in data) {
      results.add(Movies.fromJson(item));
    }
  }
}
