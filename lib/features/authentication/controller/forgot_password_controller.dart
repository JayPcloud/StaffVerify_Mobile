import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import '../../../data/services/firebase_services/authentication/firebase_auth.dart';
import '../../../utils/formatters/text_formatter.dart';
import '../../../utils/helpers/helper_func.dart';

class VForgotPasswordController extends GetxController{

  final _auth = Get.find<VAuthService>();

  final formKey = GlobalKey<FormState>();

  RxBool sendingEmail = false.obs;

  final emailController = TextEditingController();

  Future<void> sendEmail() async {
    if(formKey.currentState!.validate() && !sendingEmail.value) {
      try{
        sendingEmail.value = true;
        await _auth.sendPasswordResetLink(emailController.text.trim());
        VHelperFunc.snackBarNotifier(msg: "Sent", txtColor: VColors.whiteText);
      } catch(e){
        VHelperFunc.stopLoadingDialog();
        VHelperFunc.errorNotifier(VTextFormatter.formatFirebaseErrorText(e.toString()));
      }
      sendingEmail.value = false;
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}