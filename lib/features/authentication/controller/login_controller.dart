import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/services/authentication.dart';
import '../../../routes/routes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/formatters/text_formatter.dart';
import '../../../utils/helpers/helper_func.dart';

class VLoginController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    rememberMe();
  }

  /// Class_Instances
  final _auth = Get.find<VAuthService>();
  final _getStorage = GetStorage();

  /// Variables
  final formKey = GlobalKey<FormState>();
  RxBool rememberMeCheckValue = false.obs;
  RxBool hidePassword = false.obs;
  ///Text_Field_controllers
  Rx<TextEditingController> emailController = TextEditingController(text: GetStorage().read(VTexts.getStorageEmailKey)).obs;
  Rx<TextEditingController> passwordController = TextEditingController(text: GetStorage().read(VTexts.getStoragePasswordKey)).obs;

  ///Functions

  void navigateToForgotPassword()=> Get.toNamed(VRoutes.forgotPassword);

  void navigateToSignUp()=> Get.offAndToNamed(VRoutes.signUp);

  void toggleHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  void rememberMeCheck(bool? value) {
    rememberMeCheckValue.value = value??false;
  }

  Future<void> rememberMe() async {
    await _getStorage.initStorage;
    if(_getStorage.read(VTexts.rememberMeKey) == true){
      hidePassword.value = true;
      rememberMeCheckValue.value = true;
      emailController.value.text = _getStorage.read(VTexts.getStorageEmailKey);
      passwordController.value.text = _getStorage.read(VTexts.getStoragePasswordKey);
    }
  }

  Future<void> login() async {
    if(formKey.currentState!.validate()){

      VHelperFunc.startLoadingDialog(action: "validating user...");
      try{
        final userCredentials = await _auth.login(
            email: emailController.value.text.trim(),
            password: passwordController.value.text.trim()
        );

        if(rememberMeCheckValue.value == true) {
          await _getStorage.write(VTexts.rememberMeKey, true);
          await _getStorage.write(VTexts.getStorageEmailKey, userCredentials.user?.email?.trim());
          await _getStorage.write(VTexts.getStoragePasswordKey, passwordController.value.text.trim());
        }else{
          await _getStorage.remove(VTexts.rememberMeKey);
          await _getStorage.remove(VTexts.getStorageEmailKey);
          await _getStorage.remove(VTexts.getStoragePasswordKey);
        }
        VHelperFunc.stopLoadingDialog();
        try{
          Get.offAllNamed(VRoutes.wrapper);
        } catch(e) {
          Get.offAllNamed(VRoutes.blancLoading);
          Get.offAllNamed(VRoutes.wrapper);
        }

      } catch(e) {
        VHelperFunc.stopLoadingDialog();
        VHelperFunc.errorNotifier(VTextFormatter.formatFirebaseErrorText(e.toString()));
      }

    }


  }




}