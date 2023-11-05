import 'package:firstly/pages/login_page.dart';
import 'package:firstly/pages/registration_page.dart';
import 'package:flutter/material.dart';

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
        '/registrationpage': (context) => RegistrationPage(),
        '/loginpage': (context) => LoginPage(),
      },
    );
  }
}
