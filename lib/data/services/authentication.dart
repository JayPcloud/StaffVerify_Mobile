import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:staff_verify/utils/exceptions/firebase_auth_exceptions.dart';

class VAuthService extends GetxController {

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw VFirebaseAuthException(code: e.code).message;
    } catch (e) {
      throw 'An unexpected error occurred! Please try again later';
    }
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw VFirebaseAuthException(code: e.code).message;
    } catch (e) {
      throw 'An unexpected error occurred! Please try again later';
    }
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw VFirebaseAuthException(code: e.code).message;
    } catch (e) {
      throw 'An unexpected error occurred! Please try again later';
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw VFirebaseAuthException(code: e.code).message;
    } catch (e) {
      throw Exception('An unexpected error occurred! Please try again later');
    }

  }
}
