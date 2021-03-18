// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    json['id'] as String,
    json['author'] as String,
    json['content'] as String,
    json['created_at'] as String,
    json['author_details'] == null
        ? null
        : AuthorDetail.fromJson(json['author_details'] as Map<String, dynamic>),
  );
}
