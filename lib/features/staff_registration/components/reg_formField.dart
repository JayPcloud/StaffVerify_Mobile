import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/textField_validators.dart';

class VStaffRegFormField extends StatelessWidget {
  const VStaffRegFormField(
      {super.key,
      required this.title,
      this.controller,
      this.hintText,
      this.validator,
      this.keyboardType,
      this.suffixIcon,
      this.canFocus,
      this.enableInteractiveSelection, this.required,});

  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? canFocus;
  final bool? enableInteractiveSelection;
  final bool? required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: context.textTheme.titleMedium!.copyWith(
                color: context.textTheme.titleSmall!.color,
              ),
              children: [
                if(required??true)TextSpan(
                    text: ' *',
                    style: context.textTheme.titleMedium!
                        .copyWith(color: VColors.emphasis)),
              ]),
        ),

        SizedBox(
          height: VSizes.smallSpace,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: TextFormField(
            style: context.textTheme.labelLarge,
            controller: controller,
            keyboardType: keyboardType,
            canRequestFocus: canFocus ?? true,
            enableInteractiveSelection: enableInteractiveSelection,
            cursorColor: context.theme.primaryColorDark,
            validator: validator ??
                (value) =>
                    VTextFieldValidator.maxCharValidator(value: value, min: 4),
            decoration: InputDecoration(
                filled: true,
                suffixIcon: suffixIcon,
                hintText: hintText,
                hintStyle: context.textTheme.labelMedium!
                    .copyWith(color: Colors.grey.withOpacity(0.8)),
                fillColor: context.theme.colorScheme.tertiary,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            context.theme.primaryColorDark.withOpacity(0.02)))),
          ),
        )
      ],
    );
  }
}
