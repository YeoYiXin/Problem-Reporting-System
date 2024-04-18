//contain log in and sign up methods
//add necessary information
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/login/models/userData.dart';

class Auth_Methods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  Future<String> createUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    String resp = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        String userId = userCredential.user!.uid;

        userData UserData = userData(
          email: email,
          uid: userId,
        );

        print(UserData);

        if (userCredential.user != null) {
          await _firestore
              .collection("users")
              .doc(userId)
              .set(UserData.toJSon());

          resp = "User registered successfully";
          Navigator.pop(context); // Close the dialog
          Navigator.pushNamed(context, '/infoPage');
        }
      } else {
        resp = "User or UserCredential is null";
      }
    } on FirebaseAuthException catch (e) {
      resp = e.toString();
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resp)),
      );
    }
    return resp;
  }

  //sign in with email and password
  Future<String> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    String resp = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (userCredential.user != null) {
          resp = "User logged in successfully";
          print(resp);
          Navigator.pop(context); // Close the dialog
          Navigator.pushNamed(context, '/homepage');
        }
      } else {
        resp = "User or UserCredential is null";
      }
    } on FirebaseAuthException {
      resp = "Invalid email or password. Please try again.";

      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resp)),
      );
      Navigator.pop(context);
    } 
    return resp;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
