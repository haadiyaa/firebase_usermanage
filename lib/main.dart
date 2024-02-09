import 'package:firebase_core/firebase_core.dart';
import 'package:firebasemain/controller/isSignedIn.dart';
import 'package:firebasemain/firebase_options.dart';
import 'package:firebasemain/controller/instancebinding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InstanceBinding(),
      home: IsSignedIn(),
    );
  }
}
