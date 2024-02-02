import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:problem_reporting_system/pages/dashboard/homepage.dart';

class Submitted extends StatefulWidget {
  const Submitted({Key? key}) : super(key: key);

  @override
  _SubmittedState createState() => _SubmittedState();
}

class _SubmittedState extends State<Submitted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Image.asset(
          'assets/nottinghamlogo.jpg',
          height: 200,
          width: 200,
          color: Colors.blue[100],
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.blue[100],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Lottie Animation
          Center(
            child: Lottie.asset('assets/tick.json'),
          ),

          // Text widget positioned above the Lottie animation
          Container(
            margin: EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
            child: Center(
              child: Text(
                'Thank you for submitting your complaint!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),

          // Button below the Lottie animation
          Container(
            margin: EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Back to Homepage",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
