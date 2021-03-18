import 'package:app_movie/model/author_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reviews.g.dart';

@JsonSerializable(createToJson: false)
class Review {
  Review(
      this.id, this.author, this.content, this.createdAt, this.authorDetails);

  factory Review.fromJson(Map<String, dynamic> js) => _$ReviewFromJson(js);

  final String id;
  final String author;
  final String content;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'author_details')
  final AuthorDetail authorDetails;
}
