import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasemain/view/screens/home_page.dart';
import 'package:firebasemain/view/screens/loginpage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ["email"]);
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rx<User?> _firebaseUser = Rx<User?>(null);
  User? get user => _firebaseUser.value;
  late UserCredential userCredential;

  var userDetails = <Map<String, dynamic>>[].obs;

  var loading = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());
    ever(_firebaseUser, (_) {
      isLoading.value = false;
    });
  }

  void createUser(String name, String email, String password) async {
    try {
      loading.value = true;
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Users");
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await reference.doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
      });
      Get.offAll(() => LoginPage());

      loading.value = false;
    } catch (e) {
      Get.snackbar("erro creating account", e.toString());
      loading.value = false;
    }
  }

  void logIn(String email, String password) async {
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.offAll(() => HomePage(userCredential.user!));
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

  void google_signIn() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User user = userCredential.user!;
    Get.offAll(() => HomePage(userCredential.user!));
  }

  void google_signOut() async {
    await googleSignIn.signOut();
  }
}
