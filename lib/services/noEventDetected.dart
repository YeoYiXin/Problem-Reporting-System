// Written by Grp B
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:problem_reporting_system/pages/dashboard/homepage.dart';

class NoEventThankYou extends StatelessWidget {
  const NoEventThankYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20), // Spacer at the top

            // Header with "Nott-A-Problem" text
            const Center(
              child: Text(
                "Nott-A-Problem",
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 50,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20), // Spacer between logo and content

            // Placeholder for Lottie Animation (uncomment when animation file is added)
            Center(
              child: Lottie.asset('assets/smile.json'),
            ),

            // "No Event Detected" text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'No Event Detected! Thank you for your time!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            // Back to homepage button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Home()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue[300],
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('BACK TO HOME'),
              ),
            ),
            const SizedBox(height: 20), // Spacer at the bottom
          ],
        ),
      ),
    );
  }
}