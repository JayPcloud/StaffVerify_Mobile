import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/texts.dart';

class VHistoryModel {

  String? vid,staffId, userId;
  VerificationStatus? verificationStatus;
  Timestamp? timestamp;
  VerificationMethod? vMethod;

  VHistoryModel({
     this.staffId,
     this.userId,
     this.vid,
    required this.verificationStatus,
    required this.vMethod,
    required this.timestamp,
  });

  VHistoryModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    vid = json.id;
    verificationStatus = json[VTexts.vStatusField]== "success"?VerificationStatus.success:VerificationStatus.failed;
    timestamp = json[VTexts.vDateField];
    vMethod = vMethodFromString(json[VTexts.vMethodField]);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map[VTexts.staffIDField] = staffId;
    map[VTexts.userIdField] = userId;
    map[VTexts.vStatusField] = verificationStatus == VerificationStatus.success?"success":"failed";
    map[VTexts.vDateField] = timestamp;
    map[VTexts.vMethodField] = vMethodToString(vMethod!);
    return map;
  }

  static List<VHistoryModel> snapshotListToVHistoryModel(List snapshots) {
    return snapshots.map((e) => VHistoryModel.fromJson(e),).toList();
  }

  static VerificationMethod vMethodFromString(String vMethod) {
    switch (vMethod) {
      case VTexts.staffIdMethod:
        return VerificationMethod.staffID;
      case VTexts.emailMethod:
        return VerificationMethod.email;
      case VTexts.mobileNoMethod:
        return VerificationMethod.mobileNo;
      case VTexts.qrCodeMethod:
        return VerificationMethod.qrCode;
      default:
        return VerificationMethod.staffID;
    }
  }

  static String vMethodToString(VerificationMethod vMethod) {
    switch (vMethod) {
      case VerificationMethod.staffID:
        return VTexts.staffIdMethod;
      case VerificationMethod.email:
        return VTexts.emailMethod;
      case VerificationMethod.mobileNo:
        return VTexts.mobileNoMethod;
      case VerificationMethod.qrCode:
        return VTexts.qrCodeMethod;
      }
  }
}