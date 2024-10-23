import 'package:json_annotation/json_annotation.dart';
import 'user.dart';
part 'user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse {
  String? token;

  User? user;

  UserResponse({this.token, this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
