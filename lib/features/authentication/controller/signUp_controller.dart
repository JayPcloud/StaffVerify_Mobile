import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:staff_verify/data/services/authentication.dart';
import 'package:staff_verify/data/repositories/user_repositories.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import 'package:staff_verify/utils/formatters/text_formatter.dart';
import 'package:staff_verify/utils/helpers/helper_func.dart';
import '../../../utils/validators/textField_validators.dart';
import '../models/user_model.dart';

class VSignUpController extends GetxController {

  /// Class_instances
  final _auth = Get.find<VAuthService>();
  final _userRepo = Get.find<VUserRepository>();
  final _getStorage = GetStorage();


  /// Text_Field Controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  /// Variables
  final formKey = GlobalKey<FormState>();
  RxBool rememberMeCheckValue = false.obs;
  RxBool hidePassword = false.obs;


  /// Functions

  void navigateToLogin()=> Get.offAndToNamed(VRoutes.login);

  String? confirmPassword(value) => VTextFieldValidator.confirmPassword(value, passwordController.text.trim());

  void toggleHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  Future<void> rememberMeCheck(bool? value) async {
    rememberMeCheckValue.value = value??false;
  }

  Future<void> rememberMeImplement({ String? email,}) async {
    await _getStorage.initStorage;
    if(rememberMeCheckValue.value == true) {
      await _getStorage.write(VTexts.rememberMeKey, true);
      await _getStorage.write(VTexts.getStorageEmailKey, email);
      await _getStorage.write(VTexts.getStoragePasswordKey, passwordController.text.trim());
    }else{
      await _getStorage.remove(VTexts.rememberMeKey);
      await _getStorage.remove(VTexts.getStorageEmailKey);
      await _getStorage.remove(VTexts.getStoragePasswordKey);
    }
  }


  void registerUser() async {
    if( formKey.currentState!.validate()) {

      VHelperFunc.startLoadingDialog(action: "Creating account...");

      try {
        final userCredential = await _auth.signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
        );

        await _userRepo.storeUserData(VUserModel(
            uid: userCredential.user!.uid,
            email: userCredential.user!.email!,
            username: usernameController.text.trim(),
            emailVerified: false,
            userDisabled: false
        ));
        await rememberMeImplement( email:userCredential.user!.email!,);
        VHelperFunc.snackBarNotifier(msg: VTexts.successfulSignupMsg, position: SnackPosition.TOP, txtColor: VColors.whiteText);
        Get.offAllNamed(VRoutes.wrapper);

      } catch(e) {
        VHelperFunc.stopLoadingDialog();
        VHelperFunc.errorNotifier(VTextFormatter.formatFirebaseErrorText(e.toString()));
      }
    }
  }

}