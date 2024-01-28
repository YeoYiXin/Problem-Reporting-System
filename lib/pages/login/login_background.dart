//YYX
//background wi
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:problem_reporting_system/pages/login/center_widget/login_centerWidget.dart';

// ignore: camel_case_types
class Login_Background extends StatelessWidget {
  const Login_Background({super.key});

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      //top container background
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            gradient: LinearGradient(
                begin: Alignment(-0.2, -0.8),
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade600.withOpacity(0.5),
                  Colors.blue.shade200.withOpacity(0.5),
                  Colors.blue.shade50.withOpacity(0.5),
                ])),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Transform.rotate(
      //bottom container background
      angle: 180 * math.pi / 180,
      child: Container(
        width: 1.5 * screenWidth,
        height: 1.5 * screenWidth,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: const Alignment(0.6, -1.1),
                end: const Alignment(0.7, 0.8),
                colors: [
                  Colors.blue.shade100.withOpacity(0.5),
                  Colors.blue.shade300.withOpacity(0.5),
                ])),
      ),
    );
  }

  Widget centerWidget(double screenWidth) {
    return Container(
      //center container background
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
              begin: const Alignment(-0.5, -1.1),
              end: const Alignment(0.7, 0.8),
              colors: [
                Colors.blue.shade100.withOpacity(0.5),
                Colors.blue.shade300.withOpacity(0.5),
              ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
            child: Stack(children: [
      Positioned(top: -160, left: -30, child: topWidget(screenSize.width)),
      Positioned(
        bottom: -180,
        left: -40,
        child: bottomWidget(screenSize.width),
      ),
      Positioned(
        child: CenterWidget(size: screenSize),
      ),
      const Image(
        image: AssetImage('assets/nottsLogo.png'),
        height: 150,
        width: 150,
      )
    ])));
  }
}
