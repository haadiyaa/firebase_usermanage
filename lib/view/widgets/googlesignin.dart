import 'package:firebasemain/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class GoogleSignIn extends GetWidget<AuthController> {
  const GoogleSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.google_signIn();
      },
      child: Container(
        width: 30,
        height: 30,
        child: SvgPicture.asset("assets/7123025_logo_google_g_icon.svg"),
      ),
    );
  }
}