import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:staff_verify/data/services/authentication.dart';
import 'package:staff_verify/data/repositories/verification_repositories.dart';
import 'package:staff_verify/features/staff_verification/models/history_model.dart';
import 'package:staff_verify/features/staff_verification/models/staff_model.dart';
import 'package:staff_verify/features/staff_verification/models/verification_details_model.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/utils/constants/enums.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import 'package:staff_verify/utils/formatters/text_formatter.dart';
import 'package:staff_verify/utils/helpers/helper_func.dart';
import 'package:staff_verify/utils/validators/textField_validators.dart';
import '../../../data/repositories/staff_repositories.dart';

class VHomeController extends GetxController {

  // @override
  // void onInit() {
  //   focusNode.value.addListener(
  //     () {
  //       if(focusNode.value.hasFocus) {
  //         if(!hasFocus.value) {
  //           hasFocus.value = true;}
  //       }else {
  //         if(hasFocus.value) {hasFocus.value = false;
  //         }
  //       }
  //     },
  //   );
  //   super.onInit();
  // }

  final _auth = Get.find<VAuthService>();
  final _staffRepo = Get.find<VStaffRepositories>();
  final _verificationRepo = Get.find<VerificationRepositories>();

  // Variables
  RxInt bodyIndex = 0.obs;

  final homeTabKey = GlobalKey();

  RxBool isHomeTabActive = true.obs;

  final formKey = GlobalKey<FormState>();

  final Rx<TextEditingController> textFieldController = TextEditingController().obs;

  final Rx<FocusNode> focusNode = FocusNode().obs;

  final RxBool hasFocus = false.obs;

  final RxBool txtFieldNotEmpty = false.obs;

  final Rx<String?> _scanBarcode = null.obs;

  void textFieldOnChanged(String value) {
    if(value.isNotEmpty) {
      if(!txtFieldNotEmpty.value) {
        txtFieldNotEmpty.value = true;
      }
    }else {
      if(txtFieldNotEmpty.value){
        txtFieldNotEmpty.value = false;
      }

    }
  }

  // void toggleQRScanButton(int index) {
  //   if(index == 0) {
  //     isHomeTabActive.value = true;
  //   }else {
  //     isHomeTabActive.value = false;
  //   }
  // }

  void changeBodyIndex(int index) => bodyIndex.value = index;

  void clearTxtController(){
    textFieldController.value.clear();
    txtFieldNotEmpty.value = false;
  }


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

  Future<VHistoryModel> recordVerification(
      {required bool verified,
      required VerificationMethod vMethod,
      Staff? staff}) async {
    final recordedHistory = await _verificationRepo.recordToVerificationHistory(VHistoryModel(
        userId: VAuthService.currentUser!.uid,
        staffId: verified && staff != null ? staff.staffID.toString() : null,
        verificationStatus:
            verified ? VerificationStatus.success : VerificationStatus.failed,
        vMethod: vMethod,
        timestamp: Timestamp.now()));
    return recordedHistory;
  }

  Future<void> verifyStaff(VerificationMethod vMethod) async {
    focusNode.value.unfocus();
    try {
      if (formKey!.currentState!.validate()) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs;

        VHelperFunc.startLoadingDialog(action: "Verifying Identity...");

        if (vMethod == VerificationMethod.staffID) {
          docs = await _staffRepo.getStaff(
              VTexts.staffIDField, textFieldController.value.text.trim());
        } else if (vMethod == VerificationMethod.email) {
          docs = await _staffRepo.getStaff(
              VTexts.emailField, textFieldController.value.text.trim());
        } else if (vMethod == VerificationMethod.mobileNo) {
          docs = await _staffRepo.getStaff(
              VTexts.mobileNoField, textFieldController.value.text.trim());
        } else if(vMethod == VerificationMethod.qrCode) {
          docs = await _staffRepo.getStaff(
              VTexts.qrcodeField, _scanBarcode.value!.trim());
        }else {
          docs = [];
        }

        final history = await recordVerification(
            verified: docs.isNotEmpty,
            vMethod: vMethod,
            staff: docs.isNotEmpty?Staff.fromJson(docs[0].data()):null);

        VHelperFunc.stopLoadingDialog();

        if (docs.isEmpty) {
          Get.toNamed(VRoutes.vResults,
              arguments: VerificationDetailsModel(
                status: VerificationStatus.failed,
                vMethod: vMethod,
                inputParameter: textFieldController.value.text.trim(),
              ));
          return;
        }

        if (docs.length > 1) {
          VHelperFunc.errorNotifier(
              "Found Two staffs associated with ${vMethod.toString()} '${textFieldController.value.text.trim()}'");
        }
        Get.toNamed(VRoutes.vResults,
            arguments: VerificationDetailsModel(
                id: history.vid,
                status: VerificationStatus.success,
                staff: Staff.fromJson(docs[0].data()),
                inputParameter: textFieldController.value.text.trim(),
                date: history.timestamp?.toDate(),
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

      final errMsg = VTextFieldValidator.maxCharValidator(value: _scanBarcode.value, min: 5);
      if(errMsg != null) {
        VHelperFunc.errorNotifier("Invalid QR code. Please scan a valid staff QR code");
        return;
      }

      await verifyStaff(VerificationMethod.qrCode);

    } else {
      VHelperFunc.errorNotifier(VTexts.defaultErrorMessage);
    }
  }


  Future<void> logout() async {
    try {
      await _auth.logout();
      Get.offAllNamed(VRoutes.blancLoading);
      await Future.delayed(Duration(milliseconds: 500));
      Get.offAllNamed(VRoutes.wrapper);
    } catch (e) {
      VHelperFunc.errorNotifier(
          VTextFormatter.formatFirebaseErrorText(e.toString()));
    }
  }
}
