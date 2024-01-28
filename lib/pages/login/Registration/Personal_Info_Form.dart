
//registration form
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  void registerUser1(BuildContext context) async {
    String resp = await Auth_Methods().createUser(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text);
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
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
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

          //may be wrong because use the same as sign in
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
                    print('pressed');
                    registerUser1(context);
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
    super.key,
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
      // width: 300, // Set an appropriate width
      // child: Padding(
      controller: _controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        hintText: 'hfyse2@nottingham.edu.my',
      ),
      onChanged: (value) => {
        _controller.text = value,
        //read value into variable
        //pass it and create a new user in firebase
      },
      validator: (value) => validateEmail(value!),

      // ),
    );
  }
}

class _passwordField extends StatefulWidget {
  final TextEditingController _passwordcontroller;

  const _passwordField({
    super.key,
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
      // width: 300, // Set an appropriate width
      // child: Padding(
      controller: widget._passwordcontroller,
      obscureText: !passwordVisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        hintText: 'Enter your password',
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
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

        //read value into variable
        //pass it and create a new user in firebase
      },
      validator: MultiValidator(
        [
          RequiredValidator(errorText: "Password Required"),
          MinLengthValidator(6,
              errorText: "Password should be atleast 8 characters"),
          MaxLengthValidator(15,
              errorText: "Password should not be greater than 15 characters")
        ],
      ),

      // ),
    );
  }
}

class _confirmPasswordField extends StatefulWidget {
  final TextEditingController _confirmPasswordcontroller;
  final TextEditingController _passwordcontroller;

  const _confirmPasswordField({
    super.key,
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
      // width: 300, // Set an appropriate width
      // child: Padding(
      controller: widget._confirmPasswordcontroller,
      obscureText: !confirmPasswordVisible,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
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
        //read value into variable
        //pass it and create a new user in firebase
      },
      validator: (val) {
        if (val!.isEmpty) {
          return "* Required";
        }
        if (val != widget._passwordcontroller.text) {
          print("Not matched");
          return "Passwords do not match";
        }
        //if not equal to what is written in password field
        // if (val != context.read<SignupCubit>().state.password) {
        //   return "Passwords do not match";
        // }
        print("matched");
        return null; // Validation passed
      },

      // ),
    );
  }
}
