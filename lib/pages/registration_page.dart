import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:problem_reporting_system/services/my_textfield.dart';
import 'package:problem_reporting_system/services/my_button.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      if (userCredential != null && userCredential.user != null) {
        DatabaseReference usersRef =
            FirebaseDatabase.instance.reference().child('users');
        usersRef.child(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'username': usernameController.text,
        });

        Navigator.pushNamed(context, '/loginpage');
      } else {
        print('User or UserCredential is null');
        // Handle the scenario where user or userCredential is null
      }
    } catch (e) {
      print('Error during registration: $e');
      // Handle registration errors
      // Show a dialog/snackbar to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Logo
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/nottylogo1.jpeg'),
                ),

                const SizedBox(height: 20),

                // Welcome to the UNMC Problem Solving App
                const Text(
                  'Register Your Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                    height: 30), // You can adjust the spacing as needed

                // Username TextField
                MyTextField(
                  controller: usernameController,
                  hintText:
                      'Username(OWA)', // Change the hint for the username field
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                // Password TextField
                MyTextField(
                  controller:
                      passwordController, // Use the passwordController for the password field
                  hintText:
                      'New Password', // Change the hint for the password field
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // Password TextField
                MyTextField(
                  controller:
                      passwordController, // Use the passwordController for the password field
                  hintText:
                      'Confirm Password', // Change the hint for the password field
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                // Sign in Button
                MyButton(
                  onTap: () => registerUser(context),
                ),

                const SizedBox(height: 10), // Add some spacing here

                // Not a member? Register Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an Account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/loginpage');
                      },
                      child: const Text(
                        'Go Back to Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
