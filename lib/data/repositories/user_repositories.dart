import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_verify/features/authentication/models/user_model.dart';
import 'package:staff_verify/utils/constants/texts.dart';

class VUserRepository extends GetxController {

  @override
  void onInit() {
    if(FirebaseAuth.instance.currentUser !=null)getUser();
    super.onInit();
  }

  VUserRepository._();

  static final instance =  VUserRepository._();

  final _db = FirebaseFirestore.instance;

  final Rx<VUserModel?> _currentUser = Rx(null);

  Future<VUserModel?> getUser() async {

    if(_currentUser.value != null && _currentUser.value?.uid == FirebaseAuth.instance.currentUser?.uid) {
      return _currentUser.value!;
    }

      final resp = await _db.collection(VTexts.usersCollection).doc(FirebaseAuth.instance.currentUser?.uid).get();
      if(resp.data()!=null) {
        _currentUser.value = VUserModel.fromJson(resp.data()!);
        return _currentUser.value;
      }
      return null;
  }

  Future<void> storeUserData(VUserModel user) async {
    await _db.collection(VTexts.usersCollection).doc(user.uid).set(
        user.toJson()
    );
  }

  Future<void> editUserData(Map<String, dynamic> data) async {
    await _db.collection(VTexts.usersCollection).doc(FirebaseAuth.instance.currentUser?.uid).update(
        data
    );
  }


}