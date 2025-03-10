import 'package:get/get.dart';
import 'package:staff_verify/data/services/firebase_services/authentication/firebase_auth.dart';
import 'package:staff_verify/data/services/firebase_services/firestore_db/staff_repositories.dart';
import 'package:staff_verify/data/services/firebase_services/firestore_db/user_repositories.dart';
import 'package:staff_verify/features/authentication/controller/forgot_password_controller.dart';
import 'package:staff_verify/features/authentication/controller/login_controller.dart';
import 'package:staff_verify/features/authentication/controller/signUp_controller.dart';
import 'package:staff_verify/features/authentication/controller/verify_email_controller.dart';

import '../data/services/firebase_services/firestore_db/verification_service.dart';

class RepositoriesBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<VAuthService>(()=>VAuthService());

    Get.lazyPut<VUserRepository>(()=>VUserRepository());

    Get.lazyPut<VerificationService>(()=>VerificationService());

    Get.lazyPut<VStaffRepositories>(()=>VStaffRepositories());

    //Get.lazyPut<VSignUpController>(()=>VSignUpController());

    //Get.lazyPut<VLoginController>(()=>VLoginController());

    //Get.lazyPut<VForgotPasswordController>(()=>VForgotPasswordController());
  }

}