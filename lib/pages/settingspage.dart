import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();

  final user = FirebaseAuth.instance.currentUser!;
  static void signUserOut() {
    FirebaseAuth.instance.signOut();
  }
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text('Settings'),
        backgroundColor: Colors.blue[100],
        elevation: 0,
      ),
      body:
      SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
              child: Card(
                color: Colors.blue[50],
                elevation: 15.0, // Add elevation for a shadow effect
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16.0), // Adjust the border radius as needed
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                    child: const CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      child: Icon(
                                        Icons.person_2_sharp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ), //avatar
                              Container(
                                margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                child: const Text(
                                  'Username: \n\nLevel: \n\nPoints:',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                              , //profile stats
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    leading: const Icon(Icons.description, size: 30),
                    title: const Text('Terms of Service', style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Terms of Service'),
                            content: const Text('terms of service'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.question_mark, size: 30),
                    title: const Text('Help', style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      // Implement the logic for the "Help" section
                      // For example, you can navigate to a new page or show a dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Help'),
                            content: const Text('help'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.edit, size: 30),
                    title: const Text('Edit Profile',style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Edit Profile'),
                            content: const Text('Your edit profile content goes here.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const Divider(), // A divider to separate sections
                  ListTile(
                    leading: const Icon(Icons.logout, size: 30),
                    title: const Text('Logout', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700, color: Colors.redAccent,),),
                    onTap: () {
                      // Implement the logic for the "Logout" section
                      // For example, you can show a confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout',),
                            content: const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Settings.signUserOut();
                                  Navigator.pushNamed(context, '/loginpage');
                                },
                                child: const Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {

                                },
                                child: const Text('No'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}