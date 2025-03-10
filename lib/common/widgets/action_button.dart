import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/texts.dart';

class VActionButton extends StatelessWidget {
  const VActionButton({
    super.key,
    required this.actionText,
    this.onPressed,
    this.child,
    this.minWidth,
    this.radius
  });

  final String actionText;
  final Widget? child;
  final double? minWidth;
  final double? radius;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: minWidth??double.infinity,
      elevation: 0,
      color: context.theme.primaryColor,
      shape: radius!=null?RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(radius!)):null,
      child: child??Text(actionText, style:context.textTheme.labelSmall,),
    );
  }
}
