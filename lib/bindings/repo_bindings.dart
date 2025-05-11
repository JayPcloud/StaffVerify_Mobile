import 'package:get/get.dart';
import 'package:staff_verify/data/services/internet_access__tracker.dart';

class RepositoriesBinding extends Bindings {

  @override
  void dependencies() {

    Get.put(InternetAccessTracker(),);
    //
    // Get.lazyPut<VUserRepository>(()=>VUserRepository.instance);
    //
    // Get.lazyPut<VerificationRepositories>(()=>VerificationRepositories());
    //
    // Get.lazyPut<VStaffRepositories>(()=>VStaffRepositories());

    //Get.lazyPut<VSignUpController>(()=>VSignUpController());

    //Get.lazyPut<VLoginController>(()=>VLoginController());

    //Get.lazyPut<VForgotPasswordController>(()=>VForgotPasswordController());
  }


}