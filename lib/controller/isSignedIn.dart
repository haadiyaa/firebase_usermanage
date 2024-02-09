import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/screens/home_page.dart';
import 'package:firebasemain/view/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsSignedIn extends GetWidget<AuthController> {
  const IsSignedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Get.find<AuthController>().user!=null?HomePage():LoginPage();
    });
  }
}