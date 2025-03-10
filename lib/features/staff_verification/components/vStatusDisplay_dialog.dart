import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_verify/common/widgets/action_button.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import 'package:staff_verify/utils/constants/enums.dart';
import 'package:staff_verify/utils/helpers/device.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../controller/verification_result_controller.dart';

class VerificationStatusDialogDisplay extends StatelessWidget {
  const VerificationStatusDialogDisplay(
      {super.key,
      required this.vStatus,
      required this.credential,
      required this.vMethod});

  final VerificationStatus vStatus;
  final String credential;
  final VerificationMethod vMethod;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: VDeviceUtils.screenWidth * 0.7,
        padding: EdgeInsets.only(
            top: VDeviceUtils.screenHeight * 0.05,
            left: VSizes.defaultSpace,
            right: VSizes.defaultSpace,
            bottom: VSizes.defaultSpace
        ),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(VSizes.lBRadius),
        ),
        child: Column(
          children: [
            Image.asset(
              vStatus == VerificationStatus.success
                  ? VTexts.successVerificationIconPng
                  : VTexts.failedVerificationIconPng,
              height: VDeviceUtils.screenHeight * 0.1,
              width: double.infinity,
            ),
            SizedBox(
              height: VDeviceUtils.screenHeight * 0.01,
            ),
            if (vStatus == VerificationStatus.success)
              Text(
                "Verified",
                style: GoogleFonts.merriweather(
                    textStyle: context.textTheme.labelMedium!.copyWith(
                        color: VColors.successText, fontSize: VSizes.fontSizeL)),
              ),
            if (vStatus == VerificationStatus.failed)
              Text(
                "failed Verification",
                style: GoogleFonts.roboto(
                    textStyle: context.textTheme.labelMedium!.copyWith(
                        color: VColors.failed, fontSize: VSizes.fontSizeL)),
                textAlign: TextAlign.center,
              ),

            SizedBox(
              height: VDeviceUtils.screenHeight * 0.03,
            ),

            if(vMethod == VerificationMethod.qrCode)
              RichText(
                text: TextSpan(
                    text: vStatus == VerificationStatus.success
                        ? "Staff ID verified successfully"
                        : "No staff member found",
                    style: GoogleFonts.merriweather(textStyle: context.textTheme.labelMedium!
                        .copyWith(color: context.textTheme.headlineSmall!.color),),
                )
              ) else RichText(
              text: TextSpan(
                  text: vStatus == VerificationStatus.success
                      ? "The Staff with ${VerificationResultController.vMethodToString(vMethod)} "
                      : "No staff member found with ${VerificationResultController.vMethodToString(vMethod)} ",
                  style: GoogleFonts.merriweather(textStyle: context.textTheme.labelMedium!
                      .copyWith(color: context.textTheme.headlineSmall!.color),),
                  children: [
                    TextSpan(
                      text: credential,
                      style: context.textTheme.labelMedium!
                          .copyWith(color: VColors.blueText, fontStyle: FontStyle.italic),
                    ),
                    if (vStatus == VerificationStatus.success)
                      TextSpan(
                        text: " has been successfully verified",
                        style: context.textTheme.labelMedium!.copyWith(
                            color: context.textTheme.headlineSmall!.color),
                      )
                  ]),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: VDeviceUtils.screenHeight * 0.04,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: VSizes.defaultSpace, ),
              child: VActionButton(
                radius: VSizes.mdBRadius,
                actionText: vStatus == VerificationStatus.success
                    ? "View Details"
                    : "Exit",
                onPressed: VerificationResultController.popVStatusDialog,
              ),
            )
          ],
        ),
      ),
    );
  }
}
