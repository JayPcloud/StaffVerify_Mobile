import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:staff_verify/data/repositories/user_repositories.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import 'package:staff_verify/utils/helpers/helper_func.dart';

class VEmailVController extends GetxController {

  @override
  void onInit() {
    super.onInit();

    sendEmailVerificationLink(onInit: true);

    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      _auth.currentUser?.reload();

      if(_auth.currentUser!.emailVerified){
        await updateUserEmailVerifiedStatus(true);
        timer.cancel();

        VHelperFunc.snackBarNotifier(msg: 'Email Verified', txtColor: VColors.whiteText);

        Get.offAndToNamed(VRoutes.wrapper);
      }
    }
    );

  }


  final _auth = FirebaseAuth.instance;

  late Timer timer;

  Future<void> sendEmailVerificationLink({bool onInit = false})async{

    try{

      await _auth.currentUser!.sendEmailVerification();

      !onInit? Future.delayed(Duration(milliseconds: 100), () => VHelperFunc.snackBarNotifier(msg: 'Link Sent'),) : null;

    } catch (e){
     Future.delayed(Duration(milliseconds: 100), () => VHelperFunc.errorNotifier(e.toString()),);
    }
  }

  Future<void> updateUserEmailVerifiedStatus(bool isEmailVerified) async {
    await VUserRepository.instance.editUserData({VTexts.emailVerified:isEmailVerified});
  }

  void navigateToWrapper()=> Get.offAllNamed(VRoutes.wrapper);

  void navigateToLogin()=> Get.offAllNamed(VRoutes.login);

}