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
import 'package:staff_verify/utils/helpers/helper_func.dart';
import '../../../data/repositories/staff_repositories.dart';
import '../../../data/services/internet_access__tracker.dart';

class VHomeController extends GetxController {

  final _auth = Get.put(VAuthService());
  final _staffRepo = Get.put(VStaffRepositories());
  final _verificationRepo = Get.put(VerificationRepositories());

  // Variables
  RxInt bodyIndex = 0.obs;

  final homeTabKey = GlobalKey();

  RxBool isHomeTabActive = true.obs;

  final formKey = GlobalKey<FormState>();

  final Rx<TextEditingController> textFieldController = TextEditingController().obs;

  final Rx<FocusNode> focusNode = FocusNode().obs;

  final RxBool hasFocus = false.obs;

  final RxBool txtFieldNotEmpty = false.obs;

  String? _scanBarcode;

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
      if(InternetAccessTracker.hasNetworkConnection == false) {
        VHelperFunc.errorNotifier('No Network Connection');
        return;
      }

      List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs;

      if(vMethod == VerificationMethod.qrCode){

        VHelperFunc.startLoadingDialog(action: "Verifying Identity...");
          docs = await _staffRepo.getStaff(
              VTexts.qrcodeField, _scanBarcode!.trim());

        }else {

        if (formKey.currentState!.validate()) {
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
          } else {
            docs = [];
          }
        }else {
          return;
        }
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
          VHelperFunc.errorNotifier("Found Two staffs associated with ${vMethod.toString()} '${textFieldController.value.text.trim()}'");
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

    } catch (e) {
      ///------------remove---------------///
      print(e.toString());
      VHelperFunc.stopLoadingDialog();
      VHelperFunc.errorNotifier('Something went wrong, please try again later');
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
    } catch(e) {
      barcodeScanRes = e.toString();
      print(barcodeScanRes);
      VHelperFunc.errorNotifier(VTexts.defaultErrorMessage);
      return;
    }


      _scanBarcode = barcodeScanRes;

      if (_scanBarcode == null) {
        VHelperFunc.errorNotifier('Invalid QR code');
        return;
      }

      if (_scanBarcode != null && _scanBarcode != '-1') {
        await verifyStaff(VerificationMethod.qrCode);
      } else {}

  }


  Future<void> logout() async {
    try {
      await _auth.logout();
      Get.offAllNamed(VRoutes.blancLoading);
      await Future.delayed(Duration(milliseconds: 500));
      Get.offAllNamed(VRoutes.wrapper);
    } catch (e) {
      VHelperFunc.errorNotifier(e.toString());
    }
  }
}
