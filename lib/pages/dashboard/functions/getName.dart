import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetName extends StatelessWidget {
  final String uid;
  final String section;

  GetName({required this.uid, required this.section});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = _firestore.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Text(
              'No data found',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            );
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String email = data['email'];

          print(email);

          String username = extractUsername(email);

          // Return the username

          if (section.compareTo("sidebar") == 0) {
            return Text(
              username,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                letterSpacing: 2.0,
              ),
            );
          } else if (section.compareTo("email") == 0) {
            return Text(
              email,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                letterSpacing: 1.0,
              ),
            );
          } else {
            return Text(
              username,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            );
          }
        } else if (snapshot.connectionState == ConnectionState.none) {
          return CircularProgressIndicator();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  String extractUsername(String email) {
    String username = email.split('@')[0];
    return username;
  }
}
