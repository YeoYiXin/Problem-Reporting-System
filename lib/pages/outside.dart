import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/dashboard/homepage.dart';

class OutsideCampus extends StatelessWidget {
  const OutsideCampus({super.key});

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
          // Text widget positioned above the Lottie animation
          Container(
            margin: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
            child: const Center(
              child: Text(
                'Problem detected is not within the campus! Thank you for your time! Only problems within the campus can be reported.',
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
            margin: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
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
