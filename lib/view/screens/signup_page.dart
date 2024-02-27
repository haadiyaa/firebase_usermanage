import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/view/screens/loginpage.dart';
import 'package:firebasemain/view/widgets/boxinputfield.dart';
import 'package:firebasemain/view/widgets/googlesignin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends GetWidget<AuthController> {
  SignUpPage({super.key});

  // final ctrl = Get.put(AuthController());
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController age = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                BoxInputField(
                  validator: (value) {
                    final name = RegExp(r'^[A-Za-z\s]+$');
                    if (value!.isEmpty) {
                      return 'User name can\'t be empty';
                    } else if (!name.hasMatch(value)) {
                      return "Enter a valid name";
                    }
                  },
                  keyboard: TextInputType.name,
                  controller: name,
                  placeholder: const Text("Username"),
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 20,
                ),
                BoxInputField(
                  validator: (value) {
                    final paswd = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                    if (value!.isEmpty) {
                      return 'please enter the password';
                    } else if (!paswd.hasMatch(value)) {
                      return 'Password should contain at least one upper case, \none lower case, one digit, one special character and \nmust be 8 characters in length';
                    }
                  },
                  keyboard: TextInputType.visiblePassword,
                  obscure: false,
                  controller: password,
                  placeholder: const Text('Password'),
                  icon: const Icon(Icons.key),
                ),
                const SizedBox(
                  height: 20,
                ),
                BoxInputField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    final emailReg = RegExp(
                        r"^[a-zA-Z0-9_\-\.\S]{4,}[@][a-z]+[\.][a-z]{2,3}$");
                    if (!emailReg.hasMatch(value)) {
                      return 'Invalid email address!';
                    }
                  },
                  keyboard: TextInputType.emailAddress,
                  controller: email,
                  placeholder: const Text("Email"),
                  icon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 20,
                ),
                BoxInputField(
                  validator: (value) {
                    final reg2 = RegExp(r"^[6789]\d{9}$");
                    if (value!.isEmpty) {
                      return 'Number can\'t be empty';
                    } else if (value.length > 10) {
                      return "number exact 10";
                    } else if (!reg2.hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                  },
                  keyboard: TextInputType.phone,
                  controller: phone,
                  placeholder: const Text("Phone Number"),
                  icon: const Icon(Icons.phone),
                ),
                const SizedBox(
                  height: 20,
                ),
                BoxInputField(
                  validator: (value) {
                    final agee = RegExp(r"^[0-9]{1,2}$");

                    if (value!.isEmpty) {
                      return 'Age can\'t be empty';
                    } else if (value.length > 2) {
                      return "Enter valid age";
                    } else if (!agee.hasMatch(value)) {
                      return 'Invalid age!';
                    } else if (int.parse(value) < 18) {
                      return 'Age must be greater than 18';
                    }
                  },
                  keyboard: TextInputType.number,
                  controller: age,
                  placeholder: const Text("Age"),
                  icon: const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print("validting");
                      registerUser();
                    }
                  },
                  child: Obx(
                    () => Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade500,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: controller.loading.value
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
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Divider(),
                    Text("OR"),
                    Divider(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const GoogleSignIn(),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAll(() => LoginPage());
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void registerUser() {
    print("registering");
    controller.createUser(
        name.text, email.text, password.text, phone.text, age.text);
  }
}
