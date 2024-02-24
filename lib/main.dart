import 'package:flutter/material.dart';
import 'package:problem_reporting_system/firebase_options.dart';
import 'package:problem_reporting_system/pages/auth_page.dart';
import 'package:problem_reporting_system/pages/dashboard/homepage.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:problem_reporting_system/pages/login/informationPage/infoPage.dart';
import 'package:problem_reporting_system/pages/login/registration_view.dart';
import 'package:problem_reporting_system/pages/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: AuthPage(),
      routes: {
        '/homepage': (context) => Home(),
        '/loginpage': (context) => Login(),
        '/infoPage': (context) => InfoPage(),
        '/registrationpage': (context) => Registration(),
<<<<<<< Updated upstream
=======
        '/submittedpage': (context) => Submitted(),
        '/thankyoupage': (context) => NoEventThankYou(),
>>>>>>> Stashed changes
      },
    );
  }
}
