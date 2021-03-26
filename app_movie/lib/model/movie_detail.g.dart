// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) {
  return MovieDetail(
    id: json['id'] as int,
    title: json['title'] as String,
    adult: json['adult'] as bool,
    backdropPath: json['backdrop_path'] as String,
    budget: json['budget'] as int,
    genres: (json['genres'] as List<dynamic>)
        ?.map((dynamic e) =>
            e == null ? null : Genres.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    homepage: json['homepage'] as String,
    originalTitle: json['original_title'] as String,
    overview: json['overview'] as String,
    posterPath: json['poster_path'] as String,
    status: json['status'] as String,
    releaseDate: json['release_date'] as String ,
    voteCount: json['vote_count'] as int,
    voteAverage: (json['vote_average'] as num)?.toDouble(),
    companies: (json['production_companies'] as List<dynamic>)
        ?.map((dynamic e) => e == null
            ? null
            : ProductionCompany.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    error: json['error'] as String,
  );
}

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) {
  return ProductionCompany(
    id: json['id'] as int,
    logoPath: json['logo_path'] as String,
    name: json['name'] as String,
    originCountry: json['origin_country'] as String,
  );
}

Genres _$GenresFromJson(Map<String, dynamic> json) {
  return Genres(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}
