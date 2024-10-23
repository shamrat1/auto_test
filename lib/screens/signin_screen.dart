import 'dart:io';

import 'package:auto_ichi/controllers/authentication_controller.dart';
import 'package:auto_ichi/utils/constants/colors.dart';
import 'package:auto_ichi/utils/constants/custom_textfields.dart';
import 'package:auto_ichi/widgets/social_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthenticationController _controller = Get.find();

  Widget _errorWidget(String error) {
    if (error.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.only(top: 8.h),
      alignment: Alignment.centerLeft,
      child: Text(
        error,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.red,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 33.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 83.h),
                  child: Image.asset(
                    "assets/logo_with_color.png",
                    height: 50.h,
                    width: 165.w,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: Text(
                    "Sign In",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                        context,
                        _controller.emailController,
                        prefixIcon: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        hintText: "Email",
                      ),
                      _errorWidget(_controller.emailError.value),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    children: [
                      TCustomTextFields.textFieldOne(
                        context,
                        _controller.passwordController,
                        prefixIcon: Icons.lock_outline_rounded,
                        textInputAction: TextInputAction.done,
                        obsecureText: true,
                        hintText: "Password",
                      ),
                      _errorWidget(_controller.passwordError.value),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: ElevatedButton(
                    onPressed: () => _controller.login(),
                    child: _controller.loading.value
                        ? const CircularProgressIndicator()
                        : const Text("Login"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 55.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const SocialIconButton(
                            assetImageURL: "assets/facebook.png"),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const SocialIconButton(
                            assetImageURL: "assets/google.png"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 55.h),
                  child: GestureDetector(
                    child: Text(
                      "Create New Account",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: TColors.darkerGrey,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
