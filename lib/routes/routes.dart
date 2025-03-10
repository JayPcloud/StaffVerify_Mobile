import 'package:get/get.dart';
import 'package:staff_verify/features/authentication/screens/forgot_password.dart';
import 'package:staff_verify/features/authentication/screens/login.dart';
import 'package:staff_verify/features/authentication/screens/signUp.dart';
import 'package:staff_verify/features/authentication/screens/verify_email.dart';
import 'package:staff_verify/features/authentication/screens/wrapper.dart';
import 'package:staff_verify/features/staff_registration/screen/registration_confirmation.dart';
import 'package:staff_verify/features/staff_registration/screen/staff_registration.dart';
import 'package:staff_verify/features/staff_verification/screens/home_main.dart';
import 'package:staff_verify/features/staff_verification/screens/verification_result.dart';

import '../bindings/repo_bindings.dart';

class VRoutes {

  VRoutes._();

  static final instance = VRoutes._();

  static String get wrapper => "/wrapper";
  static String get signUp => "/signUp";
  static String get login => "/login";
  static String get forgotPassword => "/forgotPassword";
  static String get emailVer => "/email_verification";
  static String get home => "/home";
  static String get vResults => "/verification_results";
  static String get vRegConfirm => "/registration_confirm";

  List<GetPage<dynamic>>? pages = [
    GetPage(name: wrapper, page:()=>VWrapper(),),
    GetPage(name: signUp, page:()=>VSignUpScreen(),binding: RepositoriesBinding()),
    GetPage(name: login, page:()=>VLoginScreen(),binding: RepositoriesBinding()),
    GetPage(name: forgotPassword, page:()=>VForgotPassScreen(), binding: RepositoriesBinding()),
    GetPage(name: emailVer, page:()=>VEmailVerificationScreen(),),
    GetPage(name: home, page:()=>VHomeScreen(), binding: RepositoriesBinding()),
    GetPage(name: vResults, page:()=>VerificationResultScreen(), binding: RepositoriesBinding()),
    GetPage(name: vRegConfirm, page:()=>VRegConfirmationScreen(), binding: RepositoriesBinding()),
  ];
}