import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;

  String name;
  String username;

  @JsonKey(nullable: true)
  String email;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
