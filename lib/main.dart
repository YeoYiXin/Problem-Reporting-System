import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/homepage.dart';
import 'package:problem_reporting_system/pages/loginpage.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'package:problem_reporting_system/pages/profilepage.dart';

void main() => runApp(MaterialApp(
  initialRoute:'/loginpage',
  routes: {
    '/':(context) => Home(),
    '/loginpage': (context) => Login(),
    '/submittedpage': (context) => Submitted(),
    '/profilepage': (context) => Profile(),
  }
));


