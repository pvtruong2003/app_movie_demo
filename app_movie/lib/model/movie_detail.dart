import 'package:json_annotation/json_annotation.dart';

part 'movie_detail.g.dart';

@JsonSerializable(createToJson: false)
class MovieDetail {
  MovieDetail(
      {this.id,
      this.title,
      this.adult,
      this.backdropPath,
      this.budget,
      this.genres,
      this.homepage,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.status,
      this.voteCount,
      this.voteAverage,
      this.companies,
      this.error});

  MovieDetail.withError(String valError): error = valError;

  factory MovieDetail.fromJson(Map<String, dynamic> js) =>
      _$MovieDetailFromJson(js);

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'backdrop_path')
  String backdropPath;

  @JsonKey(name: 'budget')
  int budget;

  @JsonKey(name: 'genres')
  List<Genres> genres;

  @JsonKey(name: 'homepage')
  String homepage;

  @JsonKey(name: 'original_title')
  String originalTitle;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'poster_path')
  String posterPath;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'vote_count')
  int voteCount;

  @JsonKey(name: 'vote_average')
  double voteAverage;

  @JsonKey(name: 'production_companies')
  List<ProductionCompany> companies;

  String error;
}

@JsonSerializable(createToJson: false)
class ProductionCompany {
  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompany.fromJson(Map<String, dynamic> js) =>
      _$ProductionCompanyFromJson(js);

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'logo_path')
  String logoPath;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'origin_country')
  String originCountry;
}

@JsonSerializable(createToJson: false)
class Genres {
  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> js) => _$GenresFromJson(js);

  int id;
  String name;
}
