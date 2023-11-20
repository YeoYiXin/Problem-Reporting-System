import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:problem_reporting_system/pages/homepage.dart';

class Submitted extends StatefulWidget {
  const Submitted({Key? key}) : super(key: key);

  @override
  _SubmittedState createState() => _SubmittedState();
}

class _SubmittedState extends State<Submitted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Logo at the top left
          Positioned(
            top: 10,
            left: 0,
            child: Image.asset(
              'assets/nottylogo1.jpeg',
              height: 200,
              width: 200,
            ),
          ),

          // Lottie Animation
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Center(
              child: Lottie.asset('assets/tick.json'),
            ),
          ),

          // Text widget positioned above the Lottie animation
          const Positioned(
            top: 200, // Adjust the top position as needed
            left: 0,
            right: 0,
            child: Center(
              child: SingleChildScrollView(
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
          ),

          // Button below the Lottie animation
          Positioned(
            bottom: 120, // Adjust the bottom position as needed
            left: 0,
            right: 0,
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
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Back to Homepage",
                    style: TextStyle(
                      color: Colors.white,
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
