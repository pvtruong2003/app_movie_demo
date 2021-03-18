// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorDetail _$AuthorDetailFromJson(Map<String, dynamic> json) {
  return AuthorDetail(
    json['username'] as String,
    json['avatar_path'] as String,
    (json['rating'] as num)?.toDouble(),
  );
}
