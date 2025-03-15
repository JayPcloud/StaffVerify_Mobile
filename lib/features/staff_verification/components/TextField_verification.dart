import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controller/home_controller.dart';

class VerificationFormField extends StatelessWidget {
  const VerificationFormField(
      {super.key,
      required this.title,
      required this.controller,
      required this.validator,
      this.keyboardType});

  final VHomeController controller;
  final String title;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleSmall!.copyWith(color: VColors.primary),
        ),
        SizedBox(
          height: VSizes.smallSpace,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: Form(
            key: controller.formKey,
            child: TextFormField(
              focusNode: controller.focusNode.value,
              style: context.textTheme.labelLarge,
              controller: controller.textFieldController.value,
              keyboardType: keyboardType,
              validator: (value) => validator(value),
              onChanged: (value) => controller.textFieldOnChanged(value.trim()),
              decoration: InputDecoration(
                  filled: true,
                  suffixIcon: Obx(
                    () => controller.txtFieldNotEmpty.value
                        ? InkWell(
                            onTap: controller.clearTxtController,
                            child: Icon(
                              Icons.close,
                              size: VSizes.iconSizeSm,
                            ))
                        : SizedBox(),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: VSizes.borderWidth1))),
            ),
          ),
        )
      ],
    );
  }
}
