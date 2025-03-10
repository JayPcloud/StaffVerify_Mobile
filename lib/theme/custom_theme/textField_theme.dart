import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class VTextFieldTheme {

  static InputDecorationTheme lightTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(VSizes.smallBRadius)),
      borderSide: BorderSide(width: VSizes.borderWidth0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(VSizes.smallBRadius)),
      borderSide: BorderSide(width: VSizes.borderWidth0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
          Radius.circular(VSizes.smallBRadius)),
      borderSide: BorderSide(width: VSizes.borderWidth0),
    ),
    errorMaxLines: 1,
  );
}