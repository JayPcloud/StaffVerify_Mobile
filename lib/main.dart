import 'package:cloudinary_dart/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:staff_verify/bindings/repo_bindings.dart';
import 'package:staff_verify/firebase_options.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  RepositoriesBinding().dependencies();

  runApp(const MyApp());

}


