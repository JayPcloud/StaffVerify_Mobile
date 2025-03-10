import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/common/widgets/action_button.dart';
import 'package:staff_verify/features/authentication/components/auth_textField.dart';
import 'package:staff_verify/features/authentication/controller/signUp_controller.dart';
import 'package:staff_verify/utils/constants/sizes.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/device.dart';

class VSignUpScreen extends StatelessWidget {
  const VSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VSignUpController());
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
                VTexts.signup,
                style: context.textTheme.bodyLarge,
              ),

              SizedBox(
                height: VSizes.defaultSpace,
              ),

              Text(
                "Create a verifier account",
                style: context.textTheme.bodyMedium,
              ),

              SizedBox(
                height: VDeviceUtils.screenHeight * 0.07,
              ),

              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    VAuthFormField(title: "User Name", hintText: VTexts.usernameFieldHint, controller: controller.usernameController,),
                    SizedBox(
                      height: VSizes.defaultSpace,
                    ),
                    VAuthFormField(title: "Email",hintText: VTexts.emailTextFieldHint, controller: controller.emailController,),
                    SizedBox(
                      height: VSizes.defaultSpace,
                    ),
                    Row(
                      children: [
                        Obx(()=> Expanded(child: VAuthFormField(title: "Password", obscure: controller.hidePassword.value,onTapObscure: controller.toggleHidePassword,controller: controller.passwordController,))),
                        SizedBox(width: VSizes.spaceBtwItems,),
                        Obx(()=> Expanded(child: VAuthFormField(title: "Confirm Password", validator: (value)=>controller.confirmPassword(value?.trim()), obscure: controller.hidePassword.value,))),
                      ],
                    ),
                    SizedBox(
                      height: VSizes.defaultSpace,
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Transform.scale(
                    scale: 0.75,
                    child: SizedBox(
                      width: 20,
                      child: Obx(
                        ()=> Checkbox(
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: controller.rememberMeCheckValue.value,
                          onChanged: (value)=> controller.rememberMeCheck(value),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: VSizes.smallSpace,
                  ),
                  Text(
                    "Remember Me",
                    style: context.textTheme.bodySmall,
                  )
                ],
              ),

              SizedBox(
                height: VSizes.spaceBtwSections,
              ),

              VActionButton(
                actionText: VTexts.signup,
                onPressed: controller.registerUser,
              ),

              SizedBox(
                height: VSizes.spaceBtwSections,
              ),

              Row(
                children: [
                  Text("Already have an account?",
                      style: context.textTheme.bodyMedium),
                  SizedBox(
                    width: VSizes.defaultSpace,
                  ),
                  InkWell(
                    onTap: controller.navigateToLogin,
                    child: Text(
                      VTexts.login,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: VColors.primary,
                        fontSize: VSizes.fontSizeMd
                      ),
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
