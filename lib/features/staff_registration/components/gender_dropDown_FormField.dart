import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_registration/components/reg_formField.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/device.dart';
import '../controller/staff_reg_controller.dart';

class VSelectGenderDropDown extends StatelessWidget {
  const VSelectGenderDropDown({
    super.key,
    required this.controller,
  });

  final VStaffRegController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> VStaffRegFormField(
        title: "Gender",
        hintText: 'Select option',
        controller: controller.genderTxtController.value,
        canFocus: false,
        enableInteractiveSelection: false,
        suffixIcon:DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: VSizes.spaceBtwItems),
            child: DropdownButton(
              isDense: true,
              focusNode: controller.genderDropDownFocus,
              menuWidth: VDeviceUtils.screenWidth * 0.35,
              dropdownColor: context.theme.colorScheme.tertiary,
              value: controller.gender.value,
              borderRadius: BorderRadius.circular(VSizes.smallBRadius),
              icon: Icon(Icons.keyboard_arrow_down_sharp,),
              items: <DropdownMenuItem<dynamic>>[
                DropdownMenuItem(
                    value: controller.genderList[0],
                    child: Text(controller.genderList[0])),
                DropdownMenuItem(
                    value: controller.genderList[1],
                    child: Text(controller.genderList[1])),
              ],
              onChanged: (value) => controller.onGenderSelected(value),
            ),
          ),
        ),
      ),
    );
  }
}
