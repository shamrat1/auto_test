import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  String? role;
  DateTime? createdAt;
  DateTime? updateAt;

  User(
      {this.createdAt,
      this.email,
      this.emailVerifiedAt,
      this.id,
      this.name,
      this.role,
      this.updateAt});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
