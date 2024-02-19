import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/screens/signup_page.dart';
import 'package:firebasemain/view/widgets/boxinputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccount extends GetWidget<AuthController> {
   DeleteAccount({super.key});

    final TextEditingController email=TextEditingController();
    final TextEditingController pass=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Delete Account",
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
                controller: email,
                placeholder: const Text("Email"),
                icon: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                controller: pass,
                placeholder: const Text('Password'),
                icon: const Icon(Icons.key),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  controller.deleteAccount(email.text, pass.text);
                },
                child:  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                            "Delete Account",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
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

  void _login() {
    controller.logIn(email.text, pass.text);
  }
}