import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0,40.0,30.0,0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 40.0,
              ),
            ),
            Center(
              child: Text(
                'Username',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing:2.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Divider(
              height: 60.0,
              color: Colors.grey,
            ),
            SizedBox(height: 30.0),
            Text(
              'CURRENT LEVEL: Level',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing:2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey,
                ),
                SizedBox(width:10.0),
                Text(
                    'OWA@nottingham.edu.my',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      letterSpacing: 1.0,
                    )
                )
              ],
            ),
            Text(
              'Progress:',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing:2.0,
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
