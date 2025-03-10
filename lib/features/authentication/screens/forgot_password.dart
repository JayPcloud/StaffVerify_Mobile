import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/authentication/components/auth_textField.dart';
import 'package:staff_verify/features/authentication/controller/forgot_password_controller.dart';
import 'package:staff_verify/utils/constants/sizes.dart';
import 'package:staff_verify/utils/constants/texts.dart';
import 'package:staff_verify/utils/helpers/device.dart';
import 'package:staff_verify/utils/validators/textField_validators.dart';
import '../../../common/widgets/action_button.dart';
import '../../../utils/constants/colors.dart';

class VForgotPassScreen extends StatelessWidget {
  const VForgotPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VForgotPasswordController());
    return Scaffold(
      backgroundColor: context.theme.colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: context.theme.colorScheme.tertiary,
        title: Text(
          "Reset password",
          style: context.textTheme.displayMedium,
        ),
        leading: InkWell(
          onTap: Get.back,
            child: BackButtonIcon()
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: VSizes.defaultSpace, vertical: VSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              VTexts.resetPasswordInstruction,
              style: context.textTheme.bodySmall!
                  .copyWith(fontSize: VSizes.fontSizeSm),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: VDeviceUtils.screenHeight * 0.05,
            ),
            Text(
              "Email address",
              style: context.textTheme.labelLarge,
            ),
            SizedBox(
              height: VSizes.spaceBtwItems,
            ),
            Form(
              key: controller.formKey,
              child:VAuthFormField(
              hintText: VTexts.emailTextFieldHint,
              controller: controller.emailController,
              validator: (value)=>VTextFieldValidator.emailValidator(value),
            ),),
            SizedBox(
              height: VDeviceUtils.screenHeight * 0.1,
            ),
            VActionButton(
              actionText: "Send Email",
              onPressed: controller.sendEmail,
              child: Obx(() => controller.sendingEmail.value
                  ? SizedBox(
                      height: VSizes.buttonHeight,
                      width: VSizes.buttonHeight,
                      child: CircularProgressIndicator(
                        color: VColors.secondary,
                        strokeWidth: VSizes.microBRadius,
                      ))
                  : Text(
                      "Send Email",
                      style: context.textTheme.labelSmall,
                    )),
            )
          ],
        ),
      ),
    );
  }
}
