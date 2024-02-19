import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/screens/home_page.dart';
import 'package:firebasemain/view/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends GetWidget<AuthController> {
  
  const SplashScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final authController = Get.find<AuthController>();
          if (authController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (authController.user != null) {
              return HomePage(controller.user);
            } else {
              return LoginPage();
            }
          }
        },
      ),
    );
  }
}