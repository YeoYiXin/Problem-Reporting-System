import 'package:flutter/material.dart';
import 'dart:math' as math;

class appBackground extends StatelessWidget {
  const appBackground({Key? key});

  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -90 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          gradient: LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF66B2FF), // Light blue
              Color(0xFF967AE3), // Dark blue
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Transform.rotate(
      angle: 170 * math.pi / 180,
      child: Container(
        width: 1.8 * screenWidth,
        height: 1.8 * screenWidth,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 1.0),
            colors: [
              Color(0xFFFFCCCC), // Light pink
              Color(0xFF3399CC), // Darker blue
            ],
          ),
        ),
      ),
    );
  }

  Widget centerWidget(double screenWidth) {
    return Container(
      width: 1.2 * screenWidth,
      height: 1.2 * screenWidth,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(0.5, -0.5),
          radius: 1.5,
          colors: [
            Colors.white.withOpacity(0.7),
            const Color(0xFF3399CC), // Teal
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Stack(
        children: [
          Positioned(top: -80, left: -20, child: topWidget(screenSize.width)),
          Positioned(
            bottom: -100,
            left: -30,
            child: bottomWidget(screenSize.width),
          ),
          Positioned(
            top: screenSize.height * 0.1,
            left: screenSize.width * 0.25,
            child: centerWidget(screenSize.width),
          ),
        ],
      ),
    );
  }
}


