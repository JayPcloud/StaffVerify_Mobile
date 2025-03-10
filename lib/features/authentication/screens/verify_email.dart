import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/authentication/controller/verify_email_controller.dart';
import 'package:staff_verify/utils/constants/sizes.dart';
import 'package:staff_verify/utils/helpers/device.dart';

class VEmailVerificationScreen extends StatefulWidget {
  const VEmailVerificationScreen({super.key});

  @override
  State<VEmailVerificationScreen> createState() => _VEmailVerificationScreenState();
}

class _VEmailVerificationScreenState extends State<VEmailVerificationScreen> {

  final controller = Get.put(VEmailVController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: VSizes.spaceBtwItems,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_email_outlined, size: VDeviceUtils.screenHeight * 0.09,),
              SizedBox(height: VDeviceUtils.screenHeight * 0.05,),
              Text('Verify your email address', style: context.textTheme.displayMedium),
              SizedBox(height: VSizes.spaceBtwSections,),
               Text('We have just sent an email verification link on your email. '
                  'Please check your email and click on that link to verify your Email address',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(height: VSizes.defaultSpace,),
              Text('If not auto redirected after verification, click on the continue button',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium,
              ),
              SizedBox(height: VSizes.defaultHeight,),
              MaterialButton(
                onPressed:controller.navigateToWrapper,
                minWidth: VDeviceUtils.screenWidth * 0.4,
                height: VDeviceUtils.screenHeight * 0.045,
                shape: RoundedRectangleBorder(side: BorderSide(color: context.theme.primaryColor),
                    borderRadius:BorderRadiusDirectional.circular(VSizes.mdBRadius) ),
                child: Text('Continue',style: TextStyle(color: context.theme.primaryColor),),
              ),
              SizedBox(height: VDeviceUtils.screenHeight * 0.045,),
              InkWell(
                onTap: controller.sendEmailVerificationLink,
                child: Text('Resend E-mail Link', style: TextStyle(color: context.theme.primaryColor),) ,
              ),
              SizedBox(height: VDeviceUtils.screenHeight * 0.045,),
              InkWell(
                onTap: controller.navigateToLogin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.keyboard_backspace_sharp, color: context.theme.primaryColor,),
                    Text('  Back to login', style: TextStyle(color: context.theme.primaryColor),),
                  ],
                ) ,
              )
            ],),
        )
    );
  }
}
