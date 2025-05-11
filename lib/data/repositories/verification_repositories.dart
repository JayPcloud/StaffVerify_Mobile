import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/models/history_model.dart';
import 'package:staff_verify/utils/constants/texts.dart';

class VerificationRepositories extends GetxController {

  final _db = FirebaseFirestore.instance;

  Future<VHistoryModel> recordToVerificationHistory(VHistoryModel history) async {

    await _db.collection(VTexts.verificationsCollection).doc().set(history.toJson());

    final doc = await _db.collection(VTexts.verificationsCollection).where(VTexts.vDateField, isEqualTo: history.timestamp)
        .where(VTexts.staffIDField, isEqualTo: history.staffId).get();

    await _db.collection(VTexts.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection(VTexts.userVerificationHistoryCollection
    ).doc(doc.docs[0].id).set(history.toJson());

    return VHistoryModel.fromJson(doc.docs[0]);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchHistories(int limit)  {

     return _db.collection(VTexts.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection(VTexts.userVerificationHistoryCollection)
    .orderBy(VTexts.vDateField, descending: true).limit(limit).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoreHistories(int limit, DocumentSnapshot lastDocument)  {
    return _db.collection(VTexts.usersCollection).doc(FirebaseAuth.instance.currentUser!.uid).collection(VTexts.userVerificationHistoryCollection)
        .orderBy(VTexts.vDateField, descending: true).startAfterDocument(lastDocument).limit(limit).get();
  }
}
