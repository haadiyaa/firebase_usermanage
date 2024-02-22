import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/screens/loginpage.dart';
import 'package:firebasemain/view/widgets/boxinputfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetWidget<AuthController> {
  SignUpPage({super.key});

  // final ctrl = Get.put(AuthController());
  final TextEditingController name=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController phone=TextEditingController();
  final TextEditingController age=TextEditingController();

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
              SizedBox(height: 20,),
              BoxInputField(
                controller: name,
                placeholder: const Text("Username"),
                icon: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                obscure: false,
                controller: password,
                placeholder: const Text('Password'),
                icon: const Icon(Icons.key),
              ),
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
                controller: phone,
                placeholder: const Text("Phone Number"),
                icon: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              BoxInputField(
                controller: age,
                placeholder: const Text("Age"),
                icon: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: registerUser,
                child: 
                Obx(
                  () => 
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade500,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: controller.loading.value?const CircularProgressIndicator(color: Colors.white,):
                        const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(()=>LoginPage());
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    Text(
                      "Log In",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void registerUser() {
    controller.createUser(name.text, email.text, password.text,phone.text,age.text);
  }
}
