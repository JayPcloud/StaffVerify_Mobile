import 'package:flutter/material.dart';
import 'package:staff_verify/theme/custom_theme/textField_theme.dart';
import 'package:staff_verify/theme/custom_theme/text_theme.dart';
import 'package:staff_verify/utils/constants/colors.dart';

class VThemeData {

  VThemeData._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: VColors.primary,
    primaryColorDark: VColors.dark,
    textTheme: VTextTheme.lightTheme,
    scaffoldBackgroundColor: VColors.background,
    inputDecorationTheme: VTextFieldTheme.lightTheme,
    iconTheme: IconThemeData(
      color: VColors.icon,
    ),
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: VColors.primary,
      secondary: VColors.secondary,
      tertiary: VColors.accent,
      surface: VColors.secondary,
      surfaceContainer: VColors.surfaceEnabled,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(VColors.secondary)
    ),
  );

}