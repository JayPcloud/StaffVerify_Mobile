import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:staff_verify/data/services/firebase_services/authentication/firebase_auth.dart';
import 'package:staff_verify/data/services/firebase_services/firestore_db/verification_service.dart';
import 'package:staff_verify/features/staff_verification/models/history_model.dart';
import 'package:staff_verify/features/staff_verification/models/staff_model.dart';
import 'package:staff_verify/features/staff_verification/models/verification_details_model.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/utils/constants/enums.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import 'package:staff_verify/utils/formatters/text_formatter.dart';
import 'package:staff_verify/utils/helpers/helper_func.dart';
import 'package:staff_verify/utils/validators/textField_validators.dart';

import '../../../data/services/firebase_services/firestore_db/staff_repositories.dart';

class VHomeController extends GetxController {
  final _auth = Get.find<VAuthService>();
  final _staffRepo = Get.find<VStaffRepositories>();
  final _verificationService = Get.find<VerificationService>();

  // Variables
  RxInt bodyIndex = 0.obs;

  final formKey = GlobalKey<FormState>();

  final textFieldController = TextEditingController();

  Rx<String?> get textFieldString => textFieldController.text.trim().obs;

  final Rx<String?> _scanBarcode = null.obs;

  void changeBodyIndex(int index) => bodyIndex.value = index;

  VerificationMethod verificationMethod() {
    switch (bodyIndex.value) {
      case 0:
        return VerificationMethod.staffID;
      case 1:
        return VerificationMethod.email;
      case 2:
        return VerificationMethod.mobileNo;
      default:
        return VerificationMethod.staffID;
    }
  }

  Future<void> recordVerification(
      {required bool verified,
      required VerificationMethod vMethod,
      Staff? staff}) async {
    await _verificationService.recordToVerificationHistory(VHistoryModel(
        userId: VAuthService.currentUser!.uid,
        staffId: verified && staff != null ? staff.staffID.toString() : null,
        verificationStatus:
            verified ? VerificationStatus.success : VerificationStatus.failed,
        vMethod: vMethod,
        timestamp: Timestamp.now()));
  }

  Future<void> verifyStaff(VerificationMethod vMethod) async {
    try {
      if (formKey.currentState!.validate()) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs;

        VHelperFunc.startLoadingDialog(action: "Verifying Identity...");

        if (vMethod == VerificationMethod.staffID) {
          docs = await _staffRepo.getStaff(
              VTexts.staffIDField, textFieldController.text.trim());
        } else if (vMethod == VerificationMethod.email) {
          docs = await _staffRepo.getStaff(
              VTexts.staffIDField, textFieldController.text.trim());
        } else if (vMethod == VerificationMethod.mobileNo) {
          docs = await _staffRepo.getStaff(
              VTexts.mobileNoField, textFieldController.text.trim());
        } else if(vMethod == VerificationMethod.qrCode) {
          docs = await _staffRepo.getStaff(
              VTexts.staffIDField, _scanBarcode.value!.trim());
        }else {
          docs = [];
        }

        await recordVerification(
            verified: docs.isNotEmpty,
            vMethod: vMethod,
            staff: docs.isNotEmpty?Staff.fromJson(docs[0].data()):null);

        VHelperFunc.stopLoadingDialog();

        if (docs.isEmpty) {
          Get.toNamed(VRoutes.vResults,
              arguments: VerificationDetailsModel(
                status: VerificationStatus.failed,
                vMethod: vMethod,
                inputParameter: textFieldController.text.trim(),
              ));
          return;
        }

        if (docs.length > 1) {
          VHelperFunc.errorNotifier(
              "Found Two staffs associated with ${vMethod.toString()} '${textFieldController.text.trim()}'");
        }
        Get.toNamed(VRoutes.vResults,
            arguments: VerificationDetailsModel(
                status: VerificationStatus.success,
                staff: Staff.fromJson(docs[0].data()),
                inputParameter: textFieldController.text.trim(),
                vMethod: vMethod));
        return;
      }
    } catch (e) {
      ///------------remove---------------///
      print(e.toString());
      VHelperFunc.stopLoadingDialog();
      VHelperFunc.errorNotifier(
          VTextFormatter.formatFirebaseErrorText(e.toString()));
    }
  }


  Future<void> scanStaffQRCode() async {

    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
      VHelperFunc.errorNotifier(barcodeScanRes);
      return;
    }

    if (Get.context!.mounted) return;

    _scanBarcode.value = barcodeScanRes;

    if(_scanBarcode.value != null && _scanBarcode.value != '-1') {

      final errMsg = VTextFieldValidator.maxCharValidator(value: _scanBarcode.value, max: 10);
      if(errMsg != null) {
        VHelperFunc.errorNotifier("Invalid QR code. Please scan a valid staff QR code");
        return;
      }

      verifyStaff(VerificationMethod.qrCode);

    } else {
      VHelperFunc.errorNotifier(VTexts.defaultErrorMessage);
    }
  }


  Future<void> logout() async {
    try {
      await _auth.logout();
      Get.offAllNamed(VRoutes.signUp);
    } catch (e) {
      VHelperFunc.errorNotifier(
          VTextFormatter.formatFirebaseErrorText(e.toString()));
    }
  }
}
