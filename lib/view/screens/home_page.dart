import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  FirebaseAuth auth=FirebaseAuth.instance;



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
          ListView(
            children: [
              auth.currentUser!.emailVerified?Text("${auth.currentUser!.email!} succesfully verified!"):Text("${auth.currentUser!.email!} not verified!"),
            ],
          ),
        ],
      ),
    );
  }
}
