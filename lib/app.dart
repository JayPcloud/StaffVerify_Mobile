import 'package:flutter/material.dart';
import 'package:get/get.dart';
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