import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:staff_verify/data/services/firebase_services/firestore_db/verification_service.dart';

class VHistoryController extends GetxController {

  @override
  void onInit() {
    _subscription = _vService.fetchHistories(_limit).listen((snapshot) {
      if(initializing) {
        histories.insertAll(0,snapshot.docs);
        initializing = false;
      }else {
        for (var doc in snapshot.docs) {
          if(!histories.any((existingDoc) => existingDoc.id == doc.id ,)) {
            histories.insert(0,doc);
          }
        }
      }
    },);
    _scrollController.addListener(() {
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
        if(!isLoadingMore.value) {
          fetchMoreHistories();
        }
      }
    });
    super.onInit();
  }

  late StreamSubscription<QuerySnapshot> _subscription;

  final _vService = VerificationService();

  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;

  final int _limit = 20;

  RxBool isLoadingMore = false.obs;

  bool initializing = true;

  final RxBool _hasMoreHistories = true.obs;

  RxList<DocumentSnapshot> histories = RxList();


  Future<void> fetchMoreHistories() async {

    if(histories.isNotEmpty && _hasMoreHistories.value) {
      // print('fetching.................');
      isLoadingMore.value = true;
      final lastDocument = histories.last;
      QuerySnapshot snapshot = await _vService.fetchMoreHistories(_limit, lastDocument);

      if( snapshot.docs.isEmpty ) {
        // print("Done fetching");
        _hasMoreHistories.value = false;
        isLoadingMore.value = false;
        return;
      }

      histories.addAll(snapshot.docs);
      isLoadingMore.value = false;
      // print('Done.................');
    }
  }
















  /// -------------Dead Code ---------///
 // Future<void> fetchHistories() async {
  //   QuerySnapshot snapshot = await _vService.fetchHistories(_limit);
  //   if(snapshot.docs.isEmpty) {
  //     noHistories.value = true;
  //     return;
  //   }
  //   histories.addAll(snapshot.docs);
  //   _lastDocument = snapshot.docs.last;
  // }
}