import 'package:staff_verify/utils/constants/texts.dart';

class VUserModel {

  String? uid,email,username;
  bool? emailVerified,userDisabled;

  VUserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.emailVerified,
    required this.userDisabled,
});

  VUserModel.fromJson(Map<String, dynamic> json) {
    username = json[VTexts.usernameField];
    email = json[VTexts.emailField];
    emailVerified = json[VTexts.emailVerified];
    userDisabled = json[VTexts.userDisabledField];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};

    map[VTexts.userIdField] = uid;
    map[VTexts.usernameField] = username;
    map[VTexts.emailField] = email;
    map[VTexts.emailVerified] = emailVerified;
    map[VTexts.userDisabledField] = userDisabled;

    return map;
  }

}