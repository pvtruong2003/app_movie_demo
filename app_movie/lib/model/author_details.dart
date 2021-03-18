import 'package:json_annotation/json_annotation.dart';
part 'author_details.g.dart';

@JsonSerializable(createToJson: false)
class AuthorDetail {
  AuthorDetail(this.username, this.avatarPath, this.rating);

  factory AuthorDetail.fromJson(Map<String, dynamic> js) => _$AuthorDetailFromJson(js);
  final String username;
  @JsonKey(name: 'avatar_path')
  final String avatarPath;
  final double rating;
}
