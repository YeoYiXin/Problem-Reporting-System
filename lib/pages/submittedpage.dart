// Written by Grp B
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // This will space out the elements evenl
          children: [
            const SizedBox(height: 20), // Spacer at the top

            // Large Nottingham logo from your dashboard
            const Center(
              child: Text(
                "Nott-A-Problem",
                style: TextStyle(
                  fontFamily: 'Lobster',
                  fontSize: 50,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 20), // Spacer between logo and content

            // Lottie Animation
            Center(
              child: Lottie.asset('assets/tick.json'),
            ),

            // Thank you text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Thank you for submitting your complaint!',
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
                  foregroundColor:  Colors
                      .blue[300], // Adjust the button color as per your theme
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
