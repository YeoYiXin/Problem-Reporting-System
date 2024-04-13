//YYX
//login interface
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:problem_reporting_system/pages/login/label/InputLabel.dart';
import 'package:problem_reporting_system/pages/login/login_background.dart';
import 'package:problem_reporting_system/pages/login/resources/auth_methods.dart';
import 'package:problem_reporting_system/pages/dashboard/changePasswordPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //change from within build to here
  String email = "";
  String password = "";

  // sign user in method
  void signUserIn() async {
    if (!formkey.currentState!.validate()) {
      return;
    }

    // Validate email format
    if (!EmailValidator(errorText: "Not a valid email").isValid(email)) {
      // Show error message for invalid email format
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email format")),
      );
      return; // Exit sign in process
    }

    // Check if email domain is allowed
    if (!email.endsWith("@nottingham.edu.my")) {
      // Show error message for invalid domain
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email must end with @nottingham.edu.my")),
      );
      return; // Exit sign in process
    }

    // Validate password fields
    if (password.isEmpty) {
      // Show error message for empty password fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in the password fields")),
      );
      return; // Exit sign in process
    }

    String resp = await Auth_Methods().signIn(
      context: context,
      email: email,
      password: password,
    );
  }

  //email validator
  String? validateEmail(String value) {
    if (!EmailValidator(errorText: "Not a valid email").isValid(value)) {
      return "Not a valid email";
    }
    if (!value.endsWith("@nottingham.edu.my")) {
      return "Email must end with @nottingham.edu.my";
    }
    return null; // Return null if the email is valid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
          key: formkey,
          child: Stack(
            children: [
              const Login_Background(),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Nott-A-Problem",
                              style: TextStyle(
                                fontSize: 40,
                                fontFamily: 'Lobster',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: const Text(
                                "Access to the fixes on campus. Report faulty facilities by just taking a picture and submitting.",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //form table for email and password, submit and then register if doesnt have an account
                      const Gap(30),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const InputLabel(label: "University Email"),
                                const Gap(10),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    hintText: "hfyze@nottingham.edu.my",
                                    fillColor: Colors.white,
                                    filled: true,
                                  ),
                                  validator: (value) => validateEmail(value!),
                                  onChanged: (val) {
                                    email = val;
                                  },
                                ),
                                const Gap(20),
                                const InputLabel(label: "Password"),
                                const Gap(10),
                                TextFormField(
                                  obscureText: !passwordVisible,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    hintText: "Password",
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    password = val;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return changePasswordPage();
                                          }));
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                        ),
                                        onPressed: () {
                                          signUserIn();
                                        },
                                        child: const Text(
                                          'Sign in',
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
                                const Gap(20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Not registered yet ? ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Register Now',
                                              style: const TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                    '/registrationpage', //dont have register route yet
                                                  );
                                                }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
