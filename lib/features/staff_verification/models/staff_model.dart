import 'package:staff_verify/data/services/firebase_services/firestore_db/staff_repositories.dart';

import '../../../utils/constants/texts.dart';

class Staff {
  String? staffID, firstname,lastname,gender,email,mobileNo,department,role,imageUrl,qrcodeData;

  Staff({
    required this.staffID,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.email,
    required this.mobileNo,
    required this.department,
    required this.role,
    required this.imageUrl,
    required this.qrcodeData,
  });

  Staff.fromJson(Map<String, dynamic> json) {
    staffID = json[VTexts.staffIDField];
    firstname = json[VTexts.firstNameField];
    lastname = json[VTexts.lastNameField];
    gender = json[VTexts.genderField];
    email = json[VTexts.emailField];
    mobileNo = json[VTexts.mobileNoField];
    department = json[VTexts.deptField];
    role = json[VTexts.roleField] ?? "Staff Member";
    imageUrl = json[VTexts.imageUrlField];
    qrcodeData = json[VTexts.qrcodeField];
  }

  Map<String, dynamic> toJson({required String id, String? imageUrl }) {
    Map<String, dynamic> map = <String, dynamic>{};

    map[VTexts.staffIDField] = id;
    map[VTexts.firstNameField] = firstname;
    map[VTexts.lastNameField] = lastname;
    map[VTexts.genderField] = gender;
    map[VTexts.emailField] = email;
    map[VTexts.mobileNoField] = mobileNo;
    map[VTexts.deptField] = department;
    map[VTexts.roleField] = role;
    map[VTexts.imageUrlField] = imageUrl;
    map[VTexts.qrcodeField] = VStaffRepositories.generateQRCodeData(id);

    return map;
  }

}