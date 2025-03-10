import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:staff_verify/features/authentication/models/user_model.dart';
import 'package:staff_verify/utils/constants/texts.dart';

class VUserRepository extends GetxController {

  final _db = FirebaseFirestore.instance;

  Future<void> storeUserData(VUserModel user) async {
    await _db.collection(VTexts.usersCollection).doc(user.uid).set(
        user.toJson()
    );
  }

}