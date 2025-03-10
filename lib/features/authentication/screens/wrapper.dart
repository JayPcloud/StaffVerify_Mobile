import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staff_verify/features/authentication/screens/login.dart';
import 'package:staff_verify/features/authentication/screens/verify_email.dart';
import 'package:staff_verify/features/staff_verification/screens/home_main.dart';

class VWrapper extends StatelessWidget {
  const VWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          if (snapshot.hasData){

            if (snapshot.data!.emailVerified){

              return const VHomeScreen();
            }else{
              return const VEmailVerificationScreen();
            }

          }else{
            return const VLoginScreen();
          }
        },),
    );
  }
}
