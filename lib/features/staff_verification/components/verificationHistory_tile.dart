import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/models/history_model.dart';
import 'package:staff_verify/utils/constants/enums.dart';
import 'package:staff_verify/utils/formatters/date_formatter.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VHistoryTile extends StatelessWidget {
  const VHistoryTile({super.key, required this.history});

  final VHistoryModel history;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      titleTextStyle: context.textTheme.titleSmall,
      subtitleTextStyle: context.textTheme.titleMedium!
          .copyWith(fontSize: VSizes.fontSizeXSm, fontWeight: FontWeight.w500),
      leading: Container(
        padding: EdgeInsets.all(VSizes.spaceBtwItems),
        decoration: BoxDecoration(
            color: context.theme.colorScheme.tertiary, shape: BoxShape.circle),
        child: Icon(
          history.vMethod == VerificationMethod.staffID
              ? FontAwesomeIcons.user
              : history.vMethod == VerificationMethod.email
                  ? Icons.email_outlined
                  : history.vMethod == VerificationMethod.mobileNo
                      ? Icons.phone_enabled_outlined
                      : history.vMethod == VerificationMethod.qrCode
                          ? Icons.qr_code_2
                          : null,
          size: VSizes.iconSizeSm,
        ),
      ),
      title: Text(
        "ID: ${history.vid}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        VDateFormatter.historyDateFormatter(history.timestamp!.toDate()),
      ),
      trailing: Text(
        history.verificationStatus == VerificationStatus.success
            ? "success"
            : "failed",
        style: context.textTheme.titleMedium!.copyWith(
            color: history.verificationStatus == VerificationStatus.success
                ? VColors.successText
                : VColors.failed),
      ),
    );
  }
}
