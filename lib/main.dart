import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart" as firebase_core;
import 'package:registro_login/screens/create-new-account-3.dart';
import 'package:registro_login/screens/create-new-account-4.dart';
import 'package:registro_login/screens/create-new-account.dart';
import 'package:registro_login/screens/create-new_account-fin.dart';
import 'package:registro_login/screens/forgot-password.dart';
import 'package:registro_login/screens/login-screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        '/': (context) => CreateNewAccount3(),
        'ForgotPassword': (context) => ForgotPassword(),
        'CreateNewAccount': (context) => CreateNewAccount(),
        'CreateNewAccountFin': (context) => CreateNewAccountFin()
      },
    );
  }
}
