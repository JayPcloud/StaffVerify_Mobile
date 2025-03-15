import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/models/verification_details_model.dart';
import 'package:staff_verify/features/staff_verification/components/vStatusDisplay_dialog.dart';
import '../../../utils/constants/enums.dart';

class VerificationResultController extends GetxController {
  final VerificationDetailsModel vDetails;

  VerificationResultController(this.vDetails);

  static void popVStatusDialog()=> Get.back();

  void popPage()=> Get.back();

  static String vMethodToString(VerificationMethod vMethod) {
    switch (vMethod) {
      case VerificationMethod.staffID:
        return "ID";
      case VerificationMethod.email:
        return "Email";
      case VerificationMethod.mobileNo:
        return "Mobile No.";
      default:
        return "";
    }
  }

  void displayVerificationStatusDialog() {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
              child: Center(
                child: VerificationStatusDialogDisplay(
                  vStatus: vDetails.status,
                  credential: vDetails.inputParameter,
                  vMethod: vDetails.vMethod,
                ),
              ),
          );
        },
      );
  }


}
