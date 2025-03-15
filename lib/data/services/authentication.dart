import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:staff_verify/data/repositories/user_repositories.dart';

class VAuthService extends GetxController{

  static final auth = FirebaseAuth.instance;

  static User? get currentUser  => FirebaseAuth.instance.currentUser;

  void refreshUserRepoInstances() {
    Get.delete<VUserRepository>();
    Get.lazyPut<VUserRepository>(()=>VUserRepository());
  }

  Future<UserCredential> signUp({required String email, required String password}) async {
    final userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    refreshUserRepoInstances();
    return userCredential;
  }

  Future<UserCredential> login({required String email, required String password}) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    refreshUserRepoInstances();
    return userCredential;
  }

  Future<void> sendPasswordResetLink(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await auth.signOut();
    refreshUserRepoInstances();
  }
}
