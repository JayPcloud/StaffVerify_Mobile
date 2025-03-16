import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:staff_verify/features/staff_registration/controller/reg_confirmation_controller.dart';
import 'package:staff_verify/routes/routes.dart';
import 'package:staff_verify/theme/theme_data.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    @override
    void initState() {
      super.initState();
      FlutterNativeSplash.remove();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: VThemeData.lightTheme,
      smartManagement: SmartManagement.onlyBuilder,
      getPages: VRoutes.instance.pages,
      initialRoute: VRoutes.wrapper,
    );
  }
}