import 'package:staff_verify/utils/constants/texts.dart';
import '../../../utils/constants/enums.dart';

class VUserModel {

  String? uid,email,username;
  bool? emailVerified,userDisabled;
  VUserRole? role;

  VUserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.emailVerified,
    required this.userDisabled,
    this.role
});

  VUserModel.fromJson(Map<String, dynamic> json) {
    username = json[VTexts.usernameField];
    email = json[VTexts.emailField];
    emailVerified = json[VTexts.emailVerified];
    userDisabled = json[VTexts.userDisabledField];
    role = roleStringToEnum(json[VTexts.roleField]);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};

    map[VTexts.userIdField] = uid;
    map[VTexts.usernameField] = username;
    map[VTexts.emailField] = email;
    map[VTexts.emailVerified] = emailVerified;
    map[VTexts.userDisabledField] = userDisabled;
    map[VTexts.roleField] = roleEnumToString(role);

    return map;
  }

  static VUserRole roleStringToEnum(String? value) {
    switch(value) {
      case VTexts.adminFieldValue:
        return VUserRole.admin;
      default:
        return VUserRole.verifier;
    }
  }

  static String roleEnumToString(VUserRole? role) {
    switch(role) {
      case  VUserRole.admin:
        return VTexts.adminFieldValue;
      default:
        return VTexts.verifierFieldValue;
    }
  }

}