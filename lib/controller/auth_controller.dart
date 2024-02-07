import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemain/model/usermodel.dart';
import 'package:firebasemain/view/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController signUsername = TextEditingController();
  TextEditingController signPassword = TextEditingController();
  TextEditingController signEmail = TextEditingController();
  TextEditingController signPhone = TextEditingController();
  TextEditingController signAddress = TextEditingController();

  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  var loading = false.obs;

  signUp() async {
    try {
      loading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: signEmail.text, password: signPassword.text);
      await addUser();
      await verifyEmail(); 
      Get.to(() => HomePage());
      loading.value = false;
    } catch (e) {
      Get.snackbar("Error Signing In!", e.toString());
      loading.value=false;
    }
  }

  addUser() async {
    UserModel user = UserModel(
      username: signUsername.text,
      email: auth.currentUser!.email,
      phone: signPhone.text,
      address: signAddress.text,
    );
    await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("profile")
        .add(user.toMap());
  }

  logOut()async{
    await auth.signOut();
  }

  logIn() async{
    try{
          await auth.signInWithEmailAndPassword(email: loginEmail.text, password: loginPassword.text);
    }
    catch(e){
      Get.snackbar("Error Loging In!", e.toString());
    }
  }
  verifyEmail() async{
    await auth.currentUser!.sendEmailVerification();
    Get.snackbar("Verify your email", "email send to ${auth.currentUser!.email}");
  }
}
