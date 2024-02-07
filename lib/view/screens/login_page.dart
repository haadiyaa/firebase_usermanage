import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/widgets/boxinputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final ctrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Welcome!",
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
              BoxInputField(
                controller: ctrl.signUsername,
                placeholder: const Text("Username"),
                icon: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                controller: ctrl.loginPassword,
                placeholder: const Text('Password'),
                icon: const Icon(Icons.key),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                controller: ctrl.loginEmail,
                placeholder: const Text("Email"),
                icon: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                controller: ctrl.signPhone,
                placeholder: const Text("Phone Number"),
                icon: const Icon(Icons.phone),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                controller: ctrl.signAddress,
                placeholder: const Text("Address"),
                icon: const Icon(Icons.location_city),
                line: 3,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  ctrl.signUp();
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ctrl.loading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
