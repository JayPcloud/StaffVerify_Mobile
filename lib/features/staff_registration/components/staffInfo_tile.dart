import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/sizes.dart';

class StaffInfoTile extends StatelessWidget {
  const StaffInfoTile({
    super.key,
    required this.title,
    required this.trailing,
  });

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 0,
      title: Text(
        title,
        style: Get.context!.textTheme.titleSmall,
      ),
      trailing: Text(
        trailing,
        style: Get.context!.textTheme.bodyMedium,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: VSizes.defaultSpace, vertical: VSizes.smallSpace),
    );
  }
}
