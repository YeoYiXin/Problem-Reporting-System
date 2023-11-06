import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context,'/');
                },
                child: Text('Log In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
