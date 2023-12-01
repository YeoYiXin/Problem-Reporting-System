import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('Settings'),
        backgroundColor: Colors.blue[100],
        elevation: 0,
      ),
      body:
      SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
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
                                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                    child: CircleAvatar(
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
                                margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                                child: Text(
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
                    leading: Icon(Icons.description, size: 30),
                    title: Text('Terms of Service', style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Terms of Service'),
                            content: Text('terms of service'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.question_mark, size: 30),
                    title: Text('Help', style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      // Implement the logic for the "Help" section
                      // For example, you can navigate to a new page or show a dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Help'),
                            content: Text('help'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.edit, size: 30),
                    title: Text('Edit Profile',style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Edit Profile'),
                            content: Text('Your edit profile content goes here.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  Divider(), // A divider to separate sections
                  ListTile(
                    leading: Icon(Icons.logout, size: 30),
                    title: Text('Logout', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700, color: Colors.redAccent,),),
                    onTap: () {
                      // Implement the logic for the "Logout" section
                      // For example, you can show a confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Logout',),
                            content: Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Perform the logout action
                                  // For example, you can navigate to the login page
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/loginpage',
                                        (route) => false,
                                  );
                                },
                                child: Text('Yes'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/loginpage');
                                },
                                child: Text('No'),
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