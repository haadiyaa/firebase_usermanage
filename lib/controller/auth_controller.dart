import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemain/model/usermodel.dart';
import 'package:firebasemain/view/screens/home_page.dart';
import 'package:firebasemain/view/screens/loginpage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
  late Rx<User?> _firebaseUser;

  String get user {
    if (_firebaseUser.value != null) {
      return _firebaseUser.value!.email!;
    } else {
      return "";
    }
  }

  @override
  void onInit() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String name, String email, String password) async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Users");
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        reference.add({
          'name': name,
          'email': email,
        }).then((value) => Get.offAll(() => LoginPage()));
      });
    } catch (e) {
      Get.snackbar("erro creating account", e.toString());
    }
  }

  void logIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (value) => Get.offAll(
              () => HomePage(),
            ),
          );
    } catch (e) {
      Get.snackbar("Error while logging in", e.toString());
    }
  }

  Future<void> signOut() async {
    await _auth.signOut().then((value) => Get.offAll(() => LoginPage()));
  }
}
