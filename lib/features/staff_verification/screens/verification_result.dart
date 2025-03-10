import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_verify/features/staff_verification/controller/verification_result_controller.dart';
import 'package:staff_verify/utils/constants/enums.dart';
import 'package:staff_verify/utils/constants/spacing_style.dart';
import 'package:staff_verify/utils/helpers/device.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VerificationResultScreen extends StatefulWidget {
  const VerificationResultScreen({super.key});

  @override
  State<VerificationResultScreen> createState() =>
      _VerificationResultScreenState();
}

class _VerificationResultScreenState extends State<VerificationResultScreen> {
  final argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationResultController(argument));

    if (controller.vDetails.status == VerificationStatus.success) {

      final staff = controller.vDetails.staff;

      return PopScope(
          onPopInvokedWithResult: (didPop, result) =>
              Get.delete<VerificationResultController>(),
          child: Scaffold(
            body: Padding(
              padding:
                  VSpacingStyle.paddingWithAppBarHeight.copyWith(bottom: 0),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            "Staff Details",
                            style: context.textTheme.displayMedium,
                          ),
                          Spacer(),
                          InkWell(
                            child: Icon(Icons.close),
                          )
                        ],
                      )),
                  SizedBox(
                    height: VSizes.defaultSpace,
                  ),
                  Row(
                    children: [
                      Text(
                        controller.vDetails.date.toString(),
                        style: context.textTheme.bodySmall,
                      ),
                      Spacer(),
                      Text(
                        "Verified",
                        style: context.textTheme.labelLarge!
                            .copyWith(color: VColors.successText),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius:
                        BorderRadiusDirectional.circular(VSizes.lBRadius),
                    child: Image.network(
                      staff!.imageUrl ?? '_',
                      height: VDeviceUtils.screenHeight * 0.4,
                      width: double.infinity,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${staff.firstname!} ${staff.lastname!}',
                            style: GoogleFonts.merriweather(
                                textStyle: context.textTheme.bodyLarge),
                          ),
                          Text(
                            staff.role!,
                            style: context.textTheme.titleLarge,
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Verification ID",
                              style: context.textTheme.titleLarge!.copyWith(
                                  color: VColors.successText.withOpacity(0.6))),
                          Text(
                            controller.vDetails.id!,
                            style: context.textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: VSizes.defaultSpace,
                  ),
                  staffDetailTile(
                      title: "Staff ID", credential: staff.staffID.toString()),
                  staffDetailTile(
                      title: "Email", credential: staff.email!),
                  staffDetailTile(
                      title: "Phone", credential: staff.mobileNo.toString()),
                  staffDetailTile(title: "Department", credential: staff.department!)
                ],
              ),
            ),
          )
      );

    } else {
      return PopScope(
          onPopInvokedWithResult: (didPop, result) =>
              Get.delete<VerificationResultController>(),
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text(
                "No staff found",
                style: context.textTheme.headlineSmall,
              ),
            ),
          ));
    }
  }

  Widget staffDetailTile({required String title, required String credential}) {
    return ListTile(
      title: Text(
        title,
        style: Get.context!.textTheme.titleSmall,
      ),
      trailing: Text(
        credential,
        style: Get.context!.textTheme.headlineSmall,
      ),
      contentPadding: EdgeInsets.zero,
      shape: LinearBorder.bottom(
          side: BorderSide(color: Get.context!.theme.colorScheme.tertiary)),
    );
  }
}
