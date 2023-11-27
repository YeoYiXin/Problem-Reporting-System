import 'package:flutter/material.dart';
import 'package:problem_reporting_system/services/my_textfield.dart';
import 'package:problem_reporting_system/services/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // Text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {
    // Implement your sign-in logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 260,
                    child: Column(
                        children: const [
                        Text(
                            "Nott-a-problem",
                            style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Poppins",
                            height: 1.2,
                            ),
                          ),
                        SizedBox(height: 16),
                        Text(
                          "Here to solve your problems.",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                //Username TextField
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
                      'Password', // Change the hint for the password field
                  obscureText: true,
                ),

                  const SizedBox(height: 10),

                  const SizedBox(height: 10),

                // Sign in Button
                  MyButton(
                  onTap: signUserIn,
                ),

                  const SizedBox(height: 20), // Add some spacing here

                //Not a member? Register Now
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/registrationpage');
                      },
                      child: const Text(
                        'Register now',
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
          ),],
      ),
    );
  }
}


