// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericCollection<T> _$GenericCollectionFromJson<T>(Map<String, dynamic> json) {
  return GenericCollection<T>(
    page: json['page'] as int,
    totalResults: json['total_results'] as int,
    totalPages: json['total_pages'] as int,
    results: (json['results'] as List)?.map(_Converter<T>().fromJson)?.toList(),
  );
}

Map<String, dynamic> _$GenericCollectionToJson<T>(
        GenericCollection<T> instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
      'results': instance.results?.map(_Converter<T>().toJson)?.toList(),
    };
