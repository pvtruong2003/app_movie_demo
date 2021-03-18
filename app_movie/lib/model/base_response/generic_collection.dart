import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/model/trend.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generic_collection.g.dart';

@JsonSerializable()
class GenericCollection<T> {

  GenericCollection({this.page, this.totalResults, this.totalPages, this.results});

  factory GenericCollection.fromJson(Map<String, dynamic> js) => _$GenericCollectionFromJson<T>(js);

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'total_results')
  final int totalResults;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'results')
  @_Converter()
  final List<T> results;
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> && json.containsKey('releaseDate')) {
        return Trend.fromJson(json) as T;
    }
    if (json is Map<String, dynamic> && json.containsKey('poster_path')) {
      return Movie.fromJson(json) as T;
    }
    if (json is Map<String, dynamic> && json.containsKey('content')) {
      return Review.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}
