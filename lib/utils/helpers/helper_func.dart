import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/utils_components.dart';

class VHelperFunc extends GetxController {

  static void startLoadingDialog({String? action}) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) => VUtilsComponents.fullScreenLoader(action)
    );
  }

  static void stopLoadingDialog() => Get.back();

  static void closeSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }

  static void errorNotifier(
    String err,
  ) {
    Get.closeAllSnackbars();
    Get.showSnackbar(VUtilsComponents.errorSnackBarNotifier(err, SnackPosition.TOP));
  }

  static void snackBarNotifier({required String msg, SnackPosition? position, Widget? icon, Color? txtColor, double? colorOpacity, Duration? duration = const Duration(seconds: 3), bool showIcon = false}) {
    Get.closeAllSnackbars();
    Get.showSnackbar(VUtilsComponents.snackBarNotifier(msg: msg,position: position, icon: icon, txtColor: txtColor,colorOpacity:colorOpacity,duration: duration, showIcon:  showIcon));
  }

}
