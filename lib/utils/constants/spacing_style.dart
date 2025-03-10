import 'package:flutter/cupertino.dart';
import 'package:staff_verify/utils/constants/sizes.dart';

class VSpacingStyle {

  static const paddingWithAppBarHeight = EdgeInsets.only(
      top: VSizes.appBarHeight,
      left: VSizes.defaultSpace,
      right: VSizes.defaultSpace,
      bottom: VSizes.defaultSpace
  );

  static const defaultPadding = EdgeInsets.symmetric(
      vertical: VSizes.defaultSpace,
      horizontal: VSizes.spaceBtwItems,
  );

}