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

  var loading=false.obs;

  String get user {
    if (_firebaseUser.value != null) {
      return _firebaseUser.value!.email!;
    } else {
      return "";
    }
  }

  @override
  void onInit() {
    // super.onInit();
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void createUser(String name, String email, String password) async {
    try {
      loading.value=true;
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
      loading.value=false;
    } catch (e) {
      Get.snackbar("erro creating account", e.toString());
      loading.value=false;
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

  void sendpasswordResetemail(String email) async {
    try {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((value) => Get.offAll(() => LoginPage()));
      Get.snackbar("Password reset email has been sent", "success");
    } catch (e) {
      Get.snackbar("Error sending email", e.toString());
    }
  }

  void deleteAccount(String email, String pass) async {
    User? user = await _auth.currentUser;
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: pass);
    try {
      await user!.reauthenticateWithCredential(credential).then((value) {
        value.user!.delete().then((value) {
          Get.offAll(() => LoginPage());
          Get.snackbar("Account deleted", "success");
        });
      });
    } catch (e) {
      Get.snackbar("Error deleting account!", e.toString());
    }
  }

  void google_signIn()async{
    final GoogleSignInAccount? googleUser=await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth=await googleUser!.authentication;

    final AuthCredential credential=GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,

    );
    // final  User user=await _auth.signInWithCredential(credential).then((value) => Get.offAll(()=>HomePage()));
    final UserCredential userCredential=await _auth.signInWithCredential(credential);
    final User user=userCredential.user!;
    Get.offAll(()=>HomePage());
  }

  void google_signOut()async{
    await googleSignIn.signOut();
  }
}
