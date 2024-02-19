import 'package:firebase_core/firebase_core.dart';
import 'package:firebasemain/controller/auth_controller.dart';
import 'package:firebasemain/firebase_options.dart';
import 'package:firebasemain/controller/instancebinding.dart';
import 'package:firebasemain/view/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController()); 
  runApp(const MyApp());
    

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InstanceBinding(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

