import 'package:app_movie/model/author_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reviews.g.dart';

@JsonSerializable(createToJson: false)
class Review {
  Review(
      this.id,
      this.author,
      this.content,
      this.createdAt,
      this.authorDetails);

  factory Review.fromJson(Map<String, dynamic> js) => _$ReviewFromJson(js);

  Review.withError(String valueE) : error = valueE;

  String id;
  String author;
  String content;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'author_details')
  AuthorDetail authorDetails;

  String error;
}
