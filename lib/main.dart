import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart" as firebase_core;
import 'package:registro_login/screens/create-new-account-2.dart';
import 'package:registro_login/screens/create-new-account-3.dart';
import 'package:registro_login/screens/create-new-account-4.dart';
import 'package:registro_login/screens/create-new-account-fin.dart';
import 'package:registro_login/screens/create-new-account.dart';
import 'package:registro_login/screens/forgot-password.dart';

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
        '/': (context) => CreateNewAccount(),
        'ForgotPassword': (context) => ForgotPassword(),
        'CreateNewAccount': (context) => CreateNewAccount(),
        'CreateNewAccount2': (context) => CreateNewAccount2(),
        'CreateNewAccount3': (context) => CreateNewAccount3(),
        'CreateNewAccount4': (context) => CreateNewAccount4(),
        'CreateNewAccountFin': (context) => CreateNewAccountFin(),
      },
    );
  }
}
