import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/common/widgets/utils_components.dart';
import 'package:staff_verify/data/services/firebase_services/firestore_db/staff_repositories.dart';
import 'package:staff_verify/features/staff_registration/controller/select_image_controller.dart';
import 'package:staff_verify/features/staff_verification/models/staff_model.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/utils/helpers/helper_func.dart';

class VStaffRegController extends GetxController {

  final _staffRepo = VStaffRepositories();
  final imagePicker = VImagePickerController.instance;

  Rx<String?> gender = null.obs;

  FocusNode genderDropDownFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  final qrCodeGenKey = GlobalKey();

  final TextEditingController firstnameTxtCtrl = TextEditingController();
  final TextEditingController lastnameTxtCtrl = TextEditingController();
  final TextEditingController emailTxtCtrl = TextEditingController();
  final TextEditingController phoneTxtCtrl = TextEditingController();
  final TextEditingController deptTxtCtrl = TextEditingController();
  final TextEditingController roleTxtCtrl = TextEditingController();

  Rx<TextEditingController> genderTxtController = TextEditingController().obs;

  final List<String> genderList = ['Male', 'Female'];

  void onGenderSelected(String value) => genderTxtController.value.text = value;

  void displayConfirmationDialog() {

    if(imagePicker.pickedImage.value == null) {
      VHelperFunc.errorNotifier('No image selected');
      return;
    }

    if(formKey.currentState!.validate()) {
      showDialog(context: Get.context!, builder: (context) => VUtilsComponents.confirmationDialog(
          title: 'Warning!',
          option2: 'Proceed',
          confirmMessage: "Please Make sure the information supplied \nis accurate",
          onPressed1: Get.back,
          onPressed2: registerStaff
      ),);
    }

  }

  void registerStaff() async {
    Get.back();
    showDialog(context: Get.context!, builder: (context) => VUtilsComponents.actionLoader("Registering staff, please wait..."),);

    final String staffImgFilePath = imagePicker.pickedImage.value!.path;

    final Staff staff = Staff(
        staffID: '_',
        firstname: firstnameTxtCtrl.text.trim(),
        lastname: lastnameTxtCtrl.text.trim(),
        gender: genderTxtController.value.text.trim(),
        email: emailTxtCtrl.text.trim(),
        mobileNo: phoneTxtCtrl.text.trim(),
        department: deptTxtCtrl.text.trim(),
        role: roleTxtCtrl.text.trim(),
        imageUrl: '_',
        qrcodeData: '_'
    );
    try{
      final String staffId = await _staffRepo.registerStaff(staff: staff, staffImagePath: staffImgFilePath);
      Get.offAndToNamed(VRoutes.vRegConfirm, arguments: staffId);
    } catch(e) {
      Get.back();
      VHelperFunc.errorNotifier(e.toString());
      print(e.toString());
      return;
    }

  }

  @override
  void dispose() {
    genderDropDownFocus.dispose();
    imagePicker.dispose();
    super.dispose();
  }
}