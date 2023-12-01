import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:problem_reporting_system/services/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) {
    Navigator.pushNamed(context, '/homepage');
  }

  void registerUser(BuildContext context) {
    Navigator.pushNamed(context, '/registrationpage');
  }

  Future<void> showSignInDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title:
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Adjust the border radius as needed
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Text('Sign In',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w700,),)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Access to the fixes on campus. Report faulty facilities by just taking a picture and submitting.', style: TextStyle(fontSize: 15,color: Colors.black54,),textAlign: TextAlign.center,),
                ),
                MyTextField(
                  controller: usernameController,
                  hintText: 'OWA@nottingham.edu.my',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Adjust the radius as needed
                      ),
                    ),
                    onPressed: (){signUserIn(context);},
                    child: Text('Sign in', style: TextStyle(color: Colors.white, fontSize:20, ), textAlign: TextAlign.left,),
                  ),
                ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: Text(
                'Dont have an account?',
                style: TextStyle(
                  color: Colors.black,
                  ),
                ),
              ),
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                  child: GestureDetector(
                    onTap: () {
                      // Implement your registration logic here
                      registerUser(context); // Close the dialog
                    },
                    child: Text(
                      'Register now.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      toolbarHeight: 80,
        title: Image.asset(
        'assets/nottinghamlogoblack.png',
        height: 200,
        width: 250,
        color: Colors.white,
        colorBlendMode: BlendMode.darken,
        fit: BoxFit.fitWidth,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
    ),
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 0,
            child: Image.asset(
              "assets/nottinghamlogo2.png",
              color: Colors.white,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: const SizedBox(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              SizedBox(
                width: 260,
                child: Column(
                    children: const [
                    Text(
                        "Nott-A-problem",
                        style: TextStyle(
                        fontSize: 55,
                        fontWeight: FontWeight.w700,
                        // height: 1.2,
                        ),
                      ),
                    SizedBox(height: 16),
                    Text(
                      "Don't skip out on the faulty facilities. Fix them by just a snap of a picture with Nott-A-Problem. Make our campus a better place.",
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25.0), // Adjust the radius as needed
                  right: Radius.circular(25.0), // Adjust the radius as needed
                ),
                child: SizedBox(
                  height: 60,
                  width: 300,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.black, // Background color
                    ),
                    onPressed: () {
                      showSignInDialog(context);
                    },
                    label: Text('Get Started', style: TextStyle(color: Colors.white, fontSize:20, ), textAlign: TextAlign.left,),
                    icon: Icon(Icons.arrow_right_alt, color: Colors.white,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  "Signing up includes points to show off to your friends that you care about our campus facilities and earn rewards.",
                ),
              ),
              const Spacer(flex: 1),
          ],
            ),
            ),],
      ),
    );
  }
}


