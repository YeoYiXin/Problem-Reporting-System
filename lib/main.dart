import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/homepage.dart';
import 'package:problem_reporting_system/pages/login_page.dart';
import 'package:problem_reporting_system/pages/registration_page.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'package:problem_reporting_system/pages/settingspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //functions and methods
  void userTapped() {
    print("User tapped!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/homepage': (context) => Home(),
        '/loginpage': (context) => LoginPage(),
        '/submittedpage': (context) => Submitted(),
        '/registrationpage': (context) => RegistrationPage(),
        '/settings': (context) => Settings(),
      },
    );
  }
}
