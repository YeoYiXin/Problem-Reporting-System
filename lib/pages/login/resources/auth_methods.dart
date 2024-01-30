
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
  @override
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
          password: password,
          uid: userId,
        );

        print(UserData);

        if (userCredential != null && userCredential.user != null) {
          await _firestore
              .collection("users")
              .doc(userId)
              .set(UserData.toJSon());

          resp = "User registered successfully";
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

  //sign in with email and password - bot used
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

        if (userCredential != null && userCredential.user != null) {
          resp = "User logged in successfully";
          Navigator.pushNamed(context, '/homepage');
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

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
