import 'package:staff_verify/features/staff_verification/models/staff_model.dart';
import 'package:staff_verify/utils/constants/enums.dart';

class VerificationDetailsModel {
  String? id;
  VerificationStatus status;
  DateTime? date;
  Staff? staff;
  VerificationMethod vMethod;
  String inputParameter;

  VerificationDetailsModel({
    required this.status,
    required this.vMethod,
    required this.inputParameter,
    this.id,
    this.date,
    this.staff,
});
}