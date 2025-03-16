import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_verify/features/staff_verification/controller/verification_result_controller.dart';
import 'package:staff_verify/utils/constants/enums.dart';
import 'package:staff_verify/utils/constants/spacing_style.dart';
import 'package:staff_verify/utils/formatters/date_formatter.dart';
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

  final controller = VerificationResultController(Get.arguments);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
          if(mounted) {
            controller.displayVerificationStatusDialog();
          }
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (Get.arguments == null) {
      return Center(
        child: Text('No data'),
      );
    }

    if (controller.vDetails.status == VerificationStatus.success) {
      final staff = controller.vDetails.staff;
      return PopScope(
          onPopInvokedWithResult: (didPop, result) =>
              Get.delete<VerificationResultController>(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    VSpacingStyle.paddingWithAppBarHeight.copyWith(bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Staff Details",
                          style: context.textTheme.displayMedium,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: controller.popPage,
                          child: Icon(Icons.close),
                        )
                      ],
                    ),
                    SizedBox(
                      height: VSizes.defaultSpace,
                    ),
                    Row(
                      children: [
                        Text(
                          'Date:  ${VDateFormatter.historyDateFormatter(controller.vDetails.date ?? DateTime.now())}',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    SizedBox(height: VSizes.spaceBtwItems),
                    if (staff!.imageUrl != null) ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(VSizes.lBRadius),
                      child: FancyShimmerImage(
                        shimmerDuration: Duration(seconds: 5),
                          imageUrl: staff.imageUrl!,
                          height: VDeviceUtils.screenHeight * 0.4,
                          width: VDeviceUtils.screenHeight * 0.4,
                          boxFit: BoxFit.cover,
                          boxDecoration: BoxDecoration(
                            color: context.theme.colorScheme.tertiary,
                            borderRadius: BorderRadiusDirectional.circular(VSizes.lBRadius),
                          ),
                        ),
                    ),
                    SizedBox(height: VSizes.spaceBtwItems),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${staff.firstname ?? ''} ${staff.lastname ?? ''}',
                          style: GoogleFonts.merriweather(
                              textStyle: context.textTheme.labelLarge),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          (staff.role ?? 'Staff Member'),
                          style: context.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: VSizes.defaultSpace,
                    ),
                    staffDetailTile(
                        title: "Staff ID", credential: staff.staffID ?? ''),
                    staffDetailTile(
                        title: "Email", credential: staff.email ?? ''),
                    staffDetailTile(
                        title: "Phone", credential: staff.mobileNo ?? ''),
                    staffDetailTile(
                        title: "Department",
                        credential: staff.department ?? ''),
                    staffDetailTile(
                      title: '',
                      titleWidget: Text(
                        "Verification ID",
                        style: context.textTheme.titleLarge!.copyWith(
                            color: VColors.successText.withOpacity(0.6)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      credential: controller.vDetails.id ?? '',
                    ),
                  ],
                ),
              ),
            ),
          ));
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

  Widget staffDetailTile(
      {required String title,
      Widget? titleWidget,
      required String credential}) {
    return ListTile(
      title: titleWidget ??
          Text(
            title,
            style: Get.context!.textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
      trailing: Text(
        credential,
        overflow: TextOverflow.ellipsis,
        style: Get.context!.textTheme.headlineSmall,
      ),
      contentPadding: EdgeInsets.zero,
      shape: LinearBorder.bottom(
          side: BorderSide(color: Get.context!.theme.colorScheme.tertiary)),
    );
  }
}
