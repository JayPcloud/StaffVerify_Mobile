import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/models/staff_model.dart';
import '../../../../utils/constants/texts.dart';
import '../../cloud_storage.dart';

class VStaffRepositories extends GetxController {

  final _db = FirebaseFirestore.instance;

  final VCloudStorage _cloudStorage = VCloudStorage();

  String _generateStaffID(int totalStaff, Staff staff) {
    final String newTotal = ( totalStaff + 1).toString().padLeft(3,'0');
    final String newStaffId = '${staff.department!.substring(0,2).toUpperCase()}-234$newTotal';

    return newStaffId;
  }

  static String generateQRCodeData(String staffId) {
    String randomSuffix = randomAlphaNumeric(5);
    String qrCodeData = '$staffId$randomSuffix';
    return qrCodeData;
  }

  Future<String> registerStaff({required Staff staff, required String staffImagePath}) async {

    final emailExists =  _db.collection(VTexts.staffCollection).where(VTexts.emailField, isEqualTo: staff.email).get();
    final mobileExists =  _db.collection(VTexts.staffCollection).where(VTexts.mobileNoField, isEqualTo: staff.mobileNo).get();

    final results = await Future.wait([emailExists,mobileExists]);

    if(results[0].docs.isNotEmpty) {
      throw Exception(alreadyExistingStaffErrConstructor("Email", staff.email!));
    }else if(results[1].docs.isNotEmpty) {
      throw Exception(alreadyExistingStaffErrConstructor("Mobile Number", staff.mobileNo.toString()));
    }

    late String staffID;

    await _db.runTransaction((transaction) async {

      final doc = await transaction.get(_db.collection(VTexts.staffCollection).doc('all_staff_details'));

      final int totalStaff = doc.data()?[VTexts.totalStaffDocRef] ?? 0;

      final String generatedStaffID = _generateStaffID(totalStaff, staff).trim();

      final CloudinaryResponse? staffImgUploadResp = await _cloudStorage.uploadImage(imageFile:File(staffImagePath),subfolderName: VTexts.staffImageFolder,);

      if(staffImgUploadResp == null) {
        throw Exception(VTexts.imgUploadFailedErrMsg);
      }

      if(totalStaff > 0) {
        transaction.update(doc.reference, {VTexts.totalStaffDocRef: totalStaff + 1});
      }else {
        transaction.set(doc.reference, {VTexts.totalStaffDocRef: 1});
      }

      // final VQRCodeGenerator qrCode = VQRCodeGenerator(qrData: generatedStaffID);

      final String staffImgUrl = staffImgUploadResp.secureUrl;
      // String? qrCodeImgUrl;

      // try{
      //   final File qrImageFile = await qrCode.qrWidgetToFile(key: qrCodeGenKey);
      //   final CloudinaryResponse? qrImageUploadResp = await _cloudStorage.uploadImage(imageFile: qrImageFile,subfolderName: VTexts.staffImageFolder,);
      //   qrCodeImgUrl = qrImageUploadResp?.secureUrl;
      // } catch(e) {
      //   print(e);
      // }

      transaction.set(_db.collection(VTexts.staffCollection).doc(), staff.toJson(id: generatedStaffID, imageUrl:staffImgUrl));

      staffID = generatedStaffID;
    },);

    return staffID;

  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getStaff(String field, String value) async {
    final resp = await _db.collection(VTexts.staffCollection).where(field, isEqualTo: value).get();
    return resp.docs;
  }



  String alreadyExistingStaffErrConstructor(String field, String value) {
    return "Staff with $field $value already exists. Try using a different $field or"
        " contact our support team if you need assistance";
  }

}