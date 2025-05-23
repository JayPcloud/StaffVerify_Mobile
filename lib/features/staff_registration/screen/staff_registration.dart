import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/common/widgets/action_button.dart';
import 'package:staff_verify/features/staff_registration/components/reg_formField.dart';
import 'package:staff_verify/utils/constants/sizes.dart';
import 'package:staff_verify/utils/constants/spacing_style.dart';
import 'package:staff_verify/utils/helpers/device.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/validators/textField_validators.dart';
import '../components/gender_dropDown_FormField.dart';
import '../controller/staff_reg_controller.dart';

class VStaffRegScreen extends StatefulWidget {
  const VStaffRegScreen({super.key});

  @override
  State<VStaffRegScreen> createState() => _VStaffRegScreenState();
}

class _VStaffRegScreenState extends State<VStaffRegScreen> {
  final VStaffRegController controller = VStaffRegController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: VSpacingStyle.defaultPadding,
        child: VActionButton(
            actionText: 'Continue',
          onPressed: controller.displayConfirmationDialog,
          radius: VSizes.smallBRadius,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: VSpacingStyle.paddingWithAppBarHeight.copyWith(left: VSizes.smallSpace),
              child: Row(
                children: [
                IconButton(onPressed:Get.back, icon: const Icon(Icons.arrow_back_outlined)),
                SizedBox(width: VSizes.defaultSpace,),
                Text("Add Employee",style: context.textTheme.displaySmall,)
              ],),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                    topStart:Radius.circular(VSizes.lBRadius),
                    topEnd: Radius.circular(VSizes.lBRadius)
                ),
              ),
              child: Padding(
                padding: VSpacingStyle.defaultPadding.copyWith(left: VSizes.defaultSpace, right: VSizes.defaultSpace),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    spacing: VSizes.defaultSpace,
                    children: [
                    GestureDetector(
                      onTap: controller.imagePicker.displayPickImageDialog,
                      child: Obx((){
                        if(controller.imagePicker.pickedImage.value != null) {
                          return Column(
                            children: [
                              CircleAvatar(
                                radius:VDeviceUtils.screenWidth * 0.171,
                                backgroundColor: context.theme.primaryColor,
                                child: CircleAvatar(
                                  radius: VDeviceUtils.screenWidth * 0.17,
                                  backgroundImage: Image.file(File(controller.imagePicker.pickedImage.value!.path)).image,),
                              ),
                              SizedBox(height: VSizes.smallSpace,),
                              Text("Tap to change photo", style: context.textTheme.titleMedium!.copyWith(fontSize: VSizes.fontSizeXSm),)

                            ],
                          );
                        }else {
                          return Column(
                            children: [
                              Image.asset(VTexts.noPhotoIcon, height: VDeviceUtils.screenHeight * 0.1, ),
                              Text("Tap to add photo", style: context.textTheme.titleMedium!.copyWith(fontSize: VSizes.fontSizeXSm),)
                            ],
                          );
                        }
                      } ),
                    ),
                    VStaffRegFormField(title: "First Name", controller: controller.firstnameTxtCtrl),
                    VStaffRegFormField(title: "Last Name", controller: controller.lastnameTxtCtrl),
                    VSelectGenderDropDown(controller: controller,),
                    VStaffRegFormField(title: "Email",controller: controller.emailTxtCtrl, hintText: 'e.g example@gmail.com',validator:(value)=>VTextFieldValidator.emailValidator(value),),
                    VStaffRegFormField(title: "Phone", controller: controller.phoneTxtCtrl, hintText: 'Include country code; e.g +234', validator: (value)=> VTextFieldValidator.phoneNumberValidator(value), ),
                    Row(
                      children: [
                        Expanded(child: VStaffRegFormField(title: "Department", controller: controller.deptTxtCtrl, hintText: 'e.g Production',)),
                        SizedBox(width: VSizes.spaceBtwItems,),
                        Expanded(child: VStaffRegFormField(title: "Role",controller: controller.roleTxtCtrl, hintText: 'Optional', required: false,validator: (_){
                          return null;
                        },)),
                      ],
                    ),

                  ],),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}

