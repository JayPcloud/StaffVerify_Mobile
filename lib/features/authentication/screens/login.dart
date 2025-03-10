import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/authentication/controller/login_controller.dart';
import '../../../common/widgets/action_button.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/device.dart';
import '../components/auth_textField.dart';

class VLoginScreen extends StatelessWidget {
  const VLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VLoginController());
    return Scaffold(
      backgroundColor: context.theme.colorScheme.tertiary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: VSizes.defaultSpace,
              right: VSizes.defaultSpace,
              top: VDeviceUtils.screenHeight * 0.15,
              bottom: VSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                VTexts.login,
                style: context.textTheme.bodyLarge,
              ),
              const SizedBox(
                height: VSizes.defaultSpace,
              ),
              Text(
                "Login to your verifier account ",
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(
                height: VDeviceUtils.screenHeight * 0.07,
              ),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      VAuthFormField(
                        title: "Email",
                        controller: controller.emailController.value,
                      ),
                      const SizedBox(
                        height: VSizes.spaceBtwSections,
                      ),
                      Obx(() => VAuthFormField(
                            title: "Password",
                            controller: controller.passwordController.value,
                            obscure: controller.hidePassword.value,
                            onTapObscure: controller.toggleHidePassword,
                          )),
                    ],
                  )),
              const SizedBox(
                height: VSizes.spaceBtwSections,
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: SizedBox(
                      width: 20,
                      child: Obx(
                        () => Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: controller.rememberMeCheckValue.value,
                          onChanged: (value) =>
                              controller.rememberMeCheck(value),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: VSizes.smallSpace,
                  ),
                  Text(
                    "Remember Me",
                    style: context.textTheme.bodySmall,
                  ),
                  Spacer(),
                  InkWell(
                      onTap: controller.navigateToForgotPassword,
                      child: Text(
                        "Forgot Password?",
                        style: context.textTheme.bodySmall!.copyWith(
                          color: VColors.primary,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: VDeviceUtils.screenHeight * 0.1,
              ),
              VActionButton(
                actionText: VTexts.login,
                onPressed: controller.login,
              ),
              const SizedBox(
                height: VSizes.spaceBtwSections,
              ),
              Row(
                children: [
                  Text("New User?", style: context.textTheme.bodyMedium),
                  const SizedBox(
                    width: VSizes.defaultSpace,
                  ),
                  InkWell(
                      onTap: controller.navigateToSignUp,
                      child: Text(
                        VTexts.signup,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: VColors.primary,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
