import 'package:app_movie/model/movies.dart';

class MovieHome {
  List<Movies> moviesNow;
  List<Movies> moviesComing;
  List<Movies> moviesTrending;

  MovieHome({this.moviesNow, this.moviesComing, this.moviesTrending});

  String error;

  MovieHome.withError(String er) : error = er;
}
