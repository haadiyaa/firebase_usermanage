import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/screens/forgotpassword.dart';
import 'package:firebasemain/view/screens/signup_page.dart';
import 'package:firebasemain/view/widgets/boxinputfield.dart';
import 'package:firebasemain/view/widgets/googlesignin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget<AuthController> {
  LoginPage({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Log In",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                keyboard: TextInputType.emailAddress,
                controller: email,
                placeholder: const Text("Email"),
                icon: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                keyboard: TextInputType.visiblePassword,
                controller: pass,
                placeholder: const Text('Password'),
                icon: const Icon(Icons.key),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ForgotPassword());
                },
                child: const Text("Forgot Password? Reset Now"),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: _login,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade500,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Divider(),
                  Text("OR"),
                  Divider(),
                ],
              ),
              const SizedBox(height: 10,),
              const GoogleSignIn(),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => SignUpPage());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    Text(
                      "Sign Up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    controller.logIn(email.text, pass.text);
  }
}
