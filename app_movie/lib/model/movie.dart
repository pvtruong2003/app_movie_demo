import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(createToJson: false)
class Movie {
  Movie(
      {this.id,
      this.voteAverage,
      this.title,
      this.posterPath,
      this.overview,
      this.genreIds,
      this.error
      });

  factory Movie.fromJson(Map<String, dynamic> js) => _$MovieFromJson(js);

  Movie.withError(String value): error = value;

  int id;

  @JsonKey(name: 'vote_average')
  double voteAverage;

  String title;

  @JsonKey(name: 'poster_path')
  String posterPath;

  String overview;


  @JsonKey(name: 'genre_ids')
  List<int> genreIds;

  String error;

}
