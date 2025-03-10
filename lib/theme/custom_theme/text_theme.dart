import 'package:flutter/material.dart';
import 'package:staff_verify/utils/constants/colors.dart';
import 'package:staff_verify/utils/constants/sizes.dart';

class VTextTheme {

  VTextTheme._();

  static TextTheme lightTheme = TextTheme(

    displayLarge: TextStyle(fontSize: VSizes.fontSizeXXl, color: VColors.darkText, fontWeight: FontWeight.bold,),
    displayMedium: TextStyle(fontSize: VSizes.fontSizeXL, color: VColors.darkText, fontWeight: FontWeight.bold,),
    displaySmall: TextStyle(fontSize: 16, color: VColors.darkText, fontWeight: FontWeight.w600,),

    bodyLarge: TextStyle(fontSize: VSizes.fontSizeL, color: VColors.darkText, fontWeight: FontWeight.bold,),
    bodyMedium: TextStyle(fontSize: VSizes.fontSizeSm, color: VColors.greyText, fontWeight: FontWeight.w500,),
    bodySmall: TextStyle(fontSize: VSizes.fontSizeXSm, color: VColors.darkText, fontWeight: FontWeight.w500,),


    labelLarge: TextStyle(fontSize: VSizes.fontSizeMd, color: VColors.darkText, fontWeight: FontWeight.w600,),
    labelMedium: TextStyle(fontSize: VSizes.fontSizeMd, color: VColors.greyText, fontWeight: FontWeight.w500,),
    labelSmall: TextStyle(fontSize: VSizes.fontSizeMd, color: VColors.whiteText, fontWeight: FontWeight.w500,),


    titleLarge: TextStyle(fontSize: VSizes.fontSizeMd, color: VColors.greyText, fontWeight: FontWeight.w600,),
    titleMedium: TextStyle(fontSize: VSizes.fontSizeSm, color: VColors.greyText, fontWeight: FontWeight.w600,),
    titleSmall: TextStyle(fontSize: VSizes.fontSizeMd, color: VColors.darkText, fontWeight: FontWeight.w600,),


    headlineSmall: TextStyle(fontSize: VSizes.fontSizeSm, color: VColors.darkGreyText, fontWeight: FontWeight.w500)


  );

}