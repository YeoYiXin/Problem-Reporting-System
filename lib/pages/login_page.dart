import 'package:firstly/components/my_button.dart';
import 'package:firstly/components/my_textfield.dart';
import 'package:flutter/material.dart';

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Logo
                SizedBox(
                  height: 200,
                  child: Image.asset('lib/images/nottinghamlogo.jpg'),
                ),

                const SizedBox(height: 20),

                // Welcome to the UNMC Problem Solving App
                const Text(
                  'Nott-A-Problem! Your Local Problem Solving App',
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
                      'Password', // Change the hint for the password field
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Sign in Button
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 10), // Add some spacing here

                // Not a member? Register Now
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
        ),
      ),
    );
  }
}
