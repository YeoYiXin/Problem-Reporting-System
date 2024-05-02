//registration form
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:problem_reporting_system/pages/login/label/InputLabel.dart';
import 'package:problem_reporting_system/pages/login/resources/auth_methods.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  bool passwordVisible = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmPasswordcontroller =
      TextEditingController();

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

  void registerUser(BuildContext context) async {
    // Validate email format
    if (!EmailValidator(errorText: "Not a valid email")
        .isValid(_emailcontroller.text)) {
      // Show error message for invalid email format
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email format")),
      );
      return; // Exit registration process
    }

    // Check if email domain is allowed
    if (!_emailcontroller.text.endsWith("@nottingham.edu.my")) {
      // Show error message for invalid domain
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email must end with @nottingham.edu.my")),
      );
      return; // Exit registration process
    }

    // Validate password fields
    if (_passwordcontroller.text.isEmpty ||
        _confirmPasswordcontroller.text.isEmpty) {
      // Show error message for empty password fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all password fields")),
      );
      return; // Exit registration process
    }

    // Validate if passwords match
    if (_passwordcontroller.text != _confirmPasswordcontroller.text) {
      // Show error message for mismatched passwords
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return; // Exit registration process
    }

    String resp = await Auth_Methods().createUser(
      context: context,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
    );
    // Proceed with user registration
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmPasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: MediaQuery.of(context).padding,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // const Gap(30),
              Column(
                children: [
                  const InputLabel(label: "University Email"),
                  const Gap(10),
                  TextFormField(
                    controller: _emailcontroller,
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
                      _emailcontroller.text = val;
                    },
                  ),
                  const Gap(20),
                  const InputLabel(label: "Password"),
                  const Gap(10),
                  TextFormField(
                    controller: _passwordcontroller,
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
                      _passwordcontroller.text = val;
                    },
                  ),
                  const Gap(20),
                  const InputLabel(label: "Confirm Password"),
                  const Gap(10),
                  TextFormField(
                    controller: _confirmPasswordcontroller,
                    obscureText: !passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: "Confirm Password",
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
                      if (value != _passwordcontroller.text) {
                        print("Not matched");
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      _confirmPasswordcontroller.text = val;
                    },
                  ),
                ],
              ),
              const Gap(30),
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
                        registerUser(context);
                      },
                      child: const Text(
                        'Register Now',
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
        ));
  }
}

class _emailField extends StatelessWidget {
  final TextEditingController _controller;

  const _emailField({
    required TextEditingController controller,
  }) : _controller = controller;

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
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        hintText: 'hfyse2@nottingham.edu.my',
      ),
      onChanged: (value) => {
        _controller.text = value,
      },
      validator: (value) => validateEmail(value!),

      // ),
    );
  }
}

class _passwordField extends StatefulWidget {
  final TextEditingController _passwordcontroller;

  const _passwordField({
    required TextEditingController passwordcontroller,
  }) : _passwordcontroller = passwordcontroller;

  @override
  State<_passwordField> createState() => _passwordFieldState();
}

class _passwordFieldState extends State<_passwordField> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._passwordcontroller,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
      onChanged: (value) => {
        widget._passwordcontroller.text = value,
        print(value),
        print(widget._passwordcontroller.text),
      },
      validator: MultiValidator(
        [
          RequiredValidator(errorText: "Password Required"),
        ],
      ),
    );
  }
}

class _confirmPasswordField extends StatefulWidget {
  final TextEditingController _confirmPasswordcontroller;
  final TextEditingController _passwordcontroller;

  const _confirmPasswordField({
    required TextEditingController confirmPasswordcontroller,
    required TextEditingController passwordcontroller,
  })  : _confirmPasswordcontroller = confirmPasswordcontroller,
        _passwordcontroller = passwordcontroller;

  @override
  State<StatefulWidget> createState() => _confirmPasswordFieldState();
}

class _confirmPasswordFieldState extends State<_confirmPasswordField> {
  bool confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._confirmPasswordcontroller,
      obscureText: !confirmPasswordVisible,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        hintText: 'Confirm your password',
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              confirmPasswordVisible = !confirmPasswordVisible;
            });
          },
        ),
      ),
      onChanged: (value) => {
        widget._confirmPasswordcontroller.text = value,
        print(value),
        print(widget._confirmPasswordcontroller.text),
      },
      validator: (val) {
        if (val!.isEmpty) {
          return "* Required";
        }
        if (val != widget._passwordcontroller.text) {
          print("Not matched");
          return "Passwords do not match";
        }
        print("matched");
        return null; // Validation passed
      },
    );
  }
}
