//YYX
//register interface
//on successful submission of form, go to infoPage
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:problem_reporting_system/pages/login/Registration/Personal_Info_Form.dart';
import 'package:problem_reporting_system/pages/login/login_background.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool passwordVisible = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
    //school
    //course
    //year
    //then navigate to get ready page
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
            key: formkey,
            child: Stack(
              children: [
                const Login_Background(),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 170),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //registration form
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        //form
                        Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const PersonalInfoForm(),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
