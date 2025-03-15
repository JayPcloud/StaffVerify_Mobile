import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_verify/features/authentication/models/user_model.dart';
import 'package:staff_verify/utils/constants/texts.dart';

import '../services/authentication.dart';

class VUserRepository extends GetxController {

  @override
  void onReady() {
    getUser();
    super.onReady();
  }


  final _db = FirebaseFirestore.instance;

  final Rx<VUserModel?> currentUser = Rx(null);

  Future<void> getUser() async {
    final resp = await _db.collection(VTexts.usersCollection).doc(VAuthService.currentUser?.uid).get();
    if(resp.data()!=null) {
      currentUser.value = VUserModel.fromJson(resp.data()!);
    }

  }

  Future<void> storeUserData(VUserModel user) async {
    await _db.collection(VTexts.usersCollection).doc(user.uid).set(
        user.toJson()
    );
  }

}