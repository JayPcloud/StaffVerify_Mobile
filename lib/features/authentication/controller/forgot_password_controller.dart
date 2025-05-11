import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import '../../../data/services/authentication.dart';
import '../../../utils/helpers/helper_func.dart';

class VForgotPasswordController extends GetxController{

  final _auth = Get.put(VAuthService());

  final formKey = GlobalKey<FormState>();

  RxBool sendingEmail = false.obs;

  final emailController = TextEditingController();

  Future<void> sendEmail() async {
    if(formKey.currentState!.validate() && !sendingEmail.value) {
      try{
        sendingEmail.value = true;
        await _auth.sendPasswordResetLink(emailController.text.trim());
        VHelperFunc.snackBarNotifier(msg: "Email Sent", txtColor: VColors.whiteText);
      } catch(e){
        VHelperFunc.errorNotifier(e.toString());
      }
      sendingEmail.value = false;
    }
  }

}