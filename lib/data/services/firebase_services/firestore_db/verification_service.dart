import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/models/history_model.dart';
import 'package:staff_verify/utils/constants/texts.dart';

class VerificationService extends GetxController {

  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<void> recordToVerificationHistory(VHistoryModel history) async {
    await _db.collection(VTexts.verificationsCollection).doc().set(history.toJson());
    await _db.collection(VTexts.usersCollection).doc(_auth.currentUser!.uid).collection(VTexts.userVerificationHistoryCollection
    ).doc().set(history.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchHistories(int limit)  {
     return _db.collection(VTexts.usersCollection).doc(_auth.currentUser!.uid).collection(VTexts.userVerificationHistoryCollection)
    .orderBy(VTexts.vDateField, descending: true).limit(limit).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoreHistories(int limit, DocumentSnapshot lastDocument)  {
    return _db.collection(VTexts.usersCollection).doc(_auth.currentUser!.uid).collection(VTexts.userVerificationHistoryCollection)
        .orderBy(VTexts.vDateField, descending: true).startAfterDocument(lastDocument).limit(limit).get();
  }
}
