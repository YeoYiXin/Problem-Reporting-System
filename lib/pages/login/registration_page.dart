//Shen Fung's
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:problem_reporting_system/services/my_textfield.dart';

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
            FirebaseDatabase.instance.ref().child('users');
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                        child: const Center(
                          child: Text(
                            'Register now',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Make an account now and make our campus a better place.',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      // Username TextField
                      MyTextField(
                        controller: usernameController,
                        hintText:
                        'OWA@nottingham.edu.my', // Change the hint for the username field
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

                      const SizedBox(height: 20),
                      // Password TextField
                      MyTextField(
                        controller:
                        passwordController, // Use the passwordController for the password field
                        hintText:
                        'Confirm Password', // Change the hint for the password field
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
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onPressed: () {() => registerUser(context);
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                        child: const Text(
                          'Have an account already?',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: GestureDetector(
                          onTap: () {
                            // Implement your registration logic here
                            Navigator.pushNamed(context, '/loginpage'); // Close the dialog
                          },
                          child: const Text(
                            'Go back to login page.',
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
              ),
          ),
        ),
      ),
    );
  }
}
