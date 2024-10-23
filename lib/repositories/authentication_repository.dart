import 'package:auto_ichi/models/user_response.dart';
import 'package:auto_ichi/utils/http/http_client.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepository {
  Future<Either<String, UserResponse>> login(
      String email, String password) async {
    try {
      var response = await THttpHelper.post("login", {
        'email': email,
        'password': password,
      });
      return right(UserResponse.fromJson(response));
    } catch (e) {
      return left(e.toString());
    }
  }
}
