//user log in status
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:problem_reporting_system/pages/dashboard/homepage.dart';
import 'package:problem_reporting_system/pages/login/informationPage/infoPage.dart';
import 'package:problem_reporting_system/pages/login/login_view.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //user is logged in
              if (snapshot.hasData) {
                return Home();
              }

              //user is not logged in
              else {
                return Login();
              }
            }));
  }
}
