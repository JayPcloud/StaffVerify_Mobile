import 'package:get/utils.dart';

class VTextFieldValidator {


  static String? emailValidator(String? value) {

    if(value == null || value.trim().isEmpty) {
      return "Please enter your email";
    }

    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Invalid Email Format";
    }

    return null;
  }


  static String? maxCharValidator({required String? value, required int max,}) {

    if(value == null || value.trim().isEmpty) {
      return "Required Field";
    }

    if(value.length < max) {
      return "Must be up to $max characters";

    }

    return null;
  }

  static String? confirmPassword(String? value, String? password) {

    if(value != password) {
      return "Password don't match";
    }

    return null;
  }


  static String? phoneNumberValidator(String? value,) {

    if(value == null || value.trim().isEmpty) {
      return "Field must not be empty";
    }

    if(!value.isPhoneNumber) {
     return "Invalid phone number";
    }

    return null;
  }
}