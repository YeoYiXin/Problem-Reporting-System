//YYX
//information page (after registration successfuly)
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:problem_reporting_system/pages/login/login_background.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Login_Background(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 140, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to Nott-A-Problem!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // const Gap(20),

                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: Image.asset(
                        'assets/login.png',
                        height: 270,
                        width: 320,
                        colorBlendMode: BlendMode.darken,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),

                  const Gap(20),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Don't skip out on the faulty facilities. Fix them by just a snap of a picture with Nott-A-Problem. Make our campus a better place.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const Gap(20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Reporting problems increases points which shows that you care about our campus facilities and earn chances to obtain rewards!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  const Gap(20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            backgroundColor: Colors.blue.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/homepage');
                          },
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
