import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/components/TextField_verification.dart';
import 'package:staff_verify/features/staff_verification/components/verification_method_card_widget.dart';
import 'package:staff_verify/features/staff_verification/controller/home_controller.dart';
import 'package:staff_verify/utils/constants/sizes.dart';
import 'package:staff_verify/utils/constants/spacing_style.dart';
import 'package:staff_verify/utils/validators/textField_validators.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/device.dart';

class VHomeTabView extends StatelessWidget {
  const VHomeTabView({super.key, required this.controller});

  final VHomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: VSpacingStyle.paddingWithAppBarHeight.copyWith(left: 0, right: 0, ),
        child: Column(
            children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text("Choose Verification Method",
                  style: context.textTheme.displaySmall)),
          SizedBox(
            height: VSizes.spaceBtwSections,
          ),
          SizedBox(
              height: VDeviceUtils.screenHeight * 0.1,
              width: double.infinity,
              child: Row(spacing: VSizes.defaultSpace, children: [
                Obx(() {
                  if (controller.bodyIndex.value == 0) {
                    return VerificationMethodCard(
                      index: 0,
                      icon: FontAwesomeIcons.solidCircleUser,
                      surfaceColor: context.theme.colorScheme.surfaceContainer,
                      elevation: VSizes.elevation,
                      controller: controller,
                    );
                  } else {
                    return VerificationMethodCard(
                      index: 0,
                      icon: FontAwesomeIcons.circleUser,
                      surfaceColor: context.theme.colorScheme.tertiary,
                      textColor: VColors.greyText,
                      elevation: 0,
                      controller: controller,
                    );
                  }
                }),
                Obx(() {
                  if (controller.bodyIndex.value == 1) {
                    return VerificationMethodCard(
                      index: 1,
                      icon: FontAwesomeIcons.solidEnvelope,
                      surfaceColor: context.theme.colorScheme.surfaceContainer,
                      elevation: VSizes.elevation,
                      controller: controller,
                    );
                  } else {
                    return VerificationMethodCard(
                      index: 1,
                      icon: FontAwesomeIcons.envelope,
                      surfaceColor: context.theme.colorScheme.tertiary,
                      textColor: VColors.greyText,
                      elevation: 0,
                      controller: controller,
                    );
                  }
                }),
                Obx(() {
                  if (controller.bodyIndex.value == 2) {
                    return VerificationMethodCard(
                      index: 2,
                      icon: FontAwesomeIcons.phone,
                      surfaceColor: context.theme.colorScheme.surfaceContainer,
                      elevation: VSizes.elevation,
                      controller: controller,
                    );
                  } else {
                    return VerificationMethodCard(
                      index: 2,
                      icon: FontAwesomeIcons.phone,
                      surfaceColor: context.theme.colorScheme.tertiary,
                      textColor: VColors.greyText,
                      elevation: 0,
                      controller: controller,
                    );
                  }
                })
              ])),

          SizedBox(height: VSizes.spaceBtwSections,),

          Obx((){
            if(controller.bodyIndex.value == 0) {
              return VerificationFormField(
                title: "Staff ID",
                controller: controller,
                validator:(value)=>VTextFieldValidator.maxCharValidator(max:10,value: value),
              );
            }else if(controller.bodyIndex.value == 1) {
              return VerificationFormField(
                title: "Email Address",
                controller: controller,
                validator:(value)=>VTextFieldValidator.emailValidator(value),
              );
            }else if(controller.bodyIndex.value == 2) {
              return VerificationFormField(
                title: "Mobile Number",
                controller: controller,
               // keyboardType: TextInputType.phone,
                validator:(value)=>VTextFieldValidator.phoneNumberValidator(value),
              );
            }else{
              return SizedBox();
            }
          }),

          SizedBox(height: VDeviceUtils.screenHeight * 0.05,),

          MaterialButton(
            minWidth: VDeviceUtils.screenWidth * 0.6,
              color: context.theme.primaryColor.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(VSizes.smallBRadius,)),
              onPressed:()=>controller.verifyStaff(controller.verificationMethod()),
              child: Text("Verify", style:context.textTheme.labelSmall)
             ),

           SizedBox(height: VDeviceUtils.screenWidth * 0.7,),

           Align(
             alignment: Alignment.bottomRight,
             child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: context.theme.primaryColor,),
                        borderRadius: BorderRadiusDirectional.circular(VSizes.mdBRadius,)),
                    onPressed:controller.scanStaffQRCode,
                 minWidth: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.qr_code_2),
                        SizedBox(width: VSizes.smallSpace,),
                        Text("Scan QR Code", style:context.textTheme.labelLarge),
                      ],
                    )
                ),
           )
        ]),
      ),
    );
  }
}

