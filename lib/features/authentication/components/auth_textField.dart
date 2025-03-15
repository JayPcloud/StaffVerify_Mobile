import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/validators/textField_validators.dart';

class VAuthFormField extends StatelessWidget {
  const VAuthFormField(
      {super.key,
      this.title,
      this.controller,
      this.hintText,
      this.validator,
      this.keyboardType,
      this.obscure = false,
      this.onTapObscure});

  final String? title;

  final String? hintText;

  final bool obscure;

  final TextInputType? keyboardType;

  final void Function()? onTapObscure;

  final TextEditingController? controller;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.textTheme.headlineSmall,
          ),
        if (title != null)
          SizedBox(
            height: VSizes.smallSpace,
          ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: TextFormField(
            style: context.textTheme.labelLarge,
            obscureText: obscure,
            controller: controller,
            keyboardType: title == VTexts.password? TextInputType.visiblePassword: null,
            validator: validator ??
                (value) => title == VTexts.email
                    ? VTextFieldValidator.emailValidator(value)
                    : VTextFieldValidator.maxCharValidator(value: value, min: 6),
            decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              fillColor: context.theme.colorScheme.surface,
              hintStyle: context.textTheme.labelMedium!
                  .copyWith(color: Colors.grey.withOpacity(0.5)),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              suffixIcon: title == 'Password'
                  ? IconButton(
                      onPressed: onTapObscure,
                      icon: FaIcon(
                        obscure == true
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: VSizes.iconSizeSm,
                      ))
                  : null,
            ),
          ),
        )
      ],
    );
  }
}
