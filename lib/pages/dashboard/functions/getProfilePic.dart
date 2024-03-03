import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetProfilePic extends StatelessWidget {
  final String uid;

  GetProfilePic({required this.uid});

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
          String profilePicURL = data['profilePicURL'].toString();

          // print([profilePicURL]);
          return CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              profilePicURL,
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return CircularProgressIndicator();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
