import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_verification/controller/home_controller.dart';

import '../../../utils/constants/sizes.dart';

class VerificationMethodCard extends StatelessWidget {
  const VerificationMethodCard({
    super.key,
    required this.index,
    required this.icon,
    required this.surfaceColor,
    this.textColor,
    required this.elevation,
    required this.controller,
  });

  final int index;
  final IconData icon;
  final Color surfaceColor;
  final Color? textColor;
  final double elevation;
  final VHomeController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap:()=>controller.changeBodyIndex(index),
        child: Material(
          color: surfaceColor,
          borderRadius: BorderRadiusDirectional.circular(VSizes.smallBRadius),
          elevation: elevation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      
              Icon(
                icon,
                size: VSizes.defaultIconSize,
                color: textColor,
              ),
      
              SizedBox(
                height: VSizes.smallSpace,
              ),
      
              index == 0
                  ? Text(
                      "Staff ID",
                      style: context.textTheme.labelLarge!
                          .copyWith(fontSize: VSizes.fontSizeXSm, color: textColor),
                    )
      
                  : index == 1
                      ? Column(
                          children: [
                            Text(
                              "Email Address",
                              style: context.textTheme.labelLarge!.copyWith(
                                  fontSize: VSizes.fontSizeXSm, color: textColor),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
      
                      : Column(
                          children: [
                            Text(
                              "Mobile No.",
                              style: context.textTheme.labelLarge!.copyWith(
                                  fontSize: VSizes.fontSizeXSm, color: textColor),
                              maxLines: 2,
                              textAlign: TextAlign.center,
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
