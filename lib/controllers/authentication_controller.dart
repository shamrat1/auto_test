import 'package:auto_ichi/main.dart';
import 'package:auto_ichi/models/user.dart';
import 'package:auto_ichi/models/user_response.dart';
import 'package:auto_ichi/repositories/authentication_repository.dart';
import 'package:auto_ichi/screens/signin_screen.dart';
import 'package:auto_ichi/utils/storage/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthenticationRepository _repository = AuthenticationRepository();
  Rx<UserResponse> response = UserResponse().obs;
  RxBool loading = false.obs;
  RxBool authenticated = false.obs;
  RxString emailError = "".obs;
  RxString passwordError = "".obs;

  @override
  void onInit() {
    initPrefs();
    super.onInit();
  }

  bool isAdmin() {
    return (response.value.user?.role ?? "") == "admin";
  }

  bool _validate() {
    if (emailController.text == "") {
      emailError.value = "Username is required";
    } else {
      emailError.value = "";
    }
    if (passwordController.text == "") {
      passwordError.value = "Password is required";
    } else {
      passwordError.value = "";
    }

    if (emailError.value == "" && passwordError.value == "") {
      return true;
    }
    return false;
  }

  void initPrefs() async {
    loading(true);
    SharedPrefs.getBool("authenticated").then((val) async {
      authenticated(val);
      if (authenticated.value) {
        await setAuthUserModel();
      }
      FlutterNativeSplash.remove();
    });
    loading(false);
  }

  Future<void> setAuthUserModel() async {
    loading(true);
    var token = await SharedPrefs.getString("token");
    var name = await SharedPrefs.getString("name");
    var email = await SharedPrefs.getString("email");
    var role = await SharedPrefs.getString("role");
    response.value = UserResponse(
        token: token, user: User(name: name, email: email, role: role));
    loading(false);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    if (!_validate()) {
      return;
    }
    loading(true);
    var r =
        await _repository.login(emailController.text, passwordController.text);
    r.fold((e) {
      Fluttertoast.showToast(msg: e);
    }, (r) {
      response.value = r;
      authenticated.value = true;
      // save it to local
      SharedPrefs.setBool("authenticated", true);
      SharedPrefs.setString("token", response.value.token ?? "");
      SharedPrefs.setString("name", response.value.user?.name ?? "");
      SharedPrefs.setString("email", response.value.user?.email ?? "");
      SharedPrefs.setString("role", response.value.user?.role ?? "");
      emailController.clear();
      passwordController.clear();
      Get.offAll(() => HomePage());
    });
    loading(false);
  }

  void logout() async {
    SharedPrefs.delete("authenticated");
    SharedPrefs.delete("token");
    SharedPrefs.delete("name");
    SharedPrefs.delete("email");
    SharedPrefs.delete("role");
    Get.offAll(() => SigninScreen());
  }
}
