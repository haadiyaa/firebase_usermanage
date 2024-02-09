import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemain/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetWidget<AuthController> {
  HomePage({super.key});

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text("hello"),
          ),
          ElevatedButton(
            onPressed: () {
              controller.signOut();
            },
            child: Text("log Out"),
          ),
        ],
      ),
    );
  }
}
