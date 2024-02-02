//return current level of user

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetLevel extends StatelessWidget {
  final String uid;

  GetLevel({required this.uid});

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
          String level = data['level'].toString();

          print(level);

          // return Container(
          //   height: MediaQuery.of(context).size.height * 0.1,
          //   width: MediaQuery.of(context).size.width * 0.5,
          //   child: Text(email));
          // return Text(
          //   email,
          //   style: TextStyle(fontSize: 20.0, color: Colors.black),
          // );
          // Extracting username without @nottingham.edu.my
          // String username = extractUsername(email);

          // Return the username
          return Text(
            level,
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return CircularProgressIndicator();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  // String extractUsername(String email) {
  //   String username = email.split('@')[0];
  //   return username;
  // }
}
