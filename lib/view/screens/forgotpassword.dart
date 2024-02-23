import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/screens/signup_page.dart';
import 'package:firebasemain/view/widgets/boxinputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends GetWidget<AuthController> {
  ForgotPassword({super.key});

  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Reset Password",
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
             
              InkWell(
                onTap: (){
                  controller.sendpasswordResetemail(email.text);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade500,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      const Text(
                    "Reset Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
