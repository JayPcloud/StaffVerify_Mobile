import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_registration/screen/registration_confirmation.dart';
import 'package:staff_verify/features/staff_registration/screen/staff_registration.dart';
import 'package:staff_verify/features/staff_verification/screens/barcode_scanner.dart';
import 'package:staff_verify/features/staff_verification/screens/verification_result.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/theme/theme_data.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: VThemeData.lightTheme,
      smartManagement: SmartManagement.onlyBuilder,
      getPages: VRoutes.instance.pages,
      initialRoute: VRoutes.wrapper,
     // home: VStaffRegScreen()
    );
  }
}