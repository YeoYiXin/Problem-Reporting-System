import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:problem_reporting_system/services/update.dart';
import 'package:problem_reporting_system/services/updatesCard.dart';
import 'package:problem_reporting_system/services/Camera.dart';
import 'settingspage.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  Camera camera = Camera();

  //get updates from database

  //example
  List<Update> updates = [
    Update(issue: 'lamp post is now fixed', username: 'hcysc2'),
    Update(issue: 'air conditioner in F3B08 is now fixed', username: 'hcysc2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildProfileDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Image.asset(
          'assets/nottinghamlogo.jpg',
          height: 200,
          width: 200,
          color: Colors.blue[100],
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.blue[100],
        elevation: 0,
        automaticallyImplyLeading: false,
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
                          Text(
                            'Welcome, hcysc2!',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
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
                                  'Level: \n\nPoints:',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ), //profile stats
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
              child: Text(
                'Recent',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ), //updates for fixtures and reports
            //this part
            Expanded(
              child: ListView(
                children: updates.map((update) => UpdateCard(update: update))
                    .toList(),
              ),
            ), //so that the 3 icons stay at the bottom of the page
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _navigateToPage,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.black,
            gap: 8,
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.house,
                text: 'Home',
              ),
              GButton(
                icon: Icons.camera_alt,
                text: 'Camera',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Set the callback to trigger a rebuild when an image is selected
    camera.onImageSelected = () {
      setState(() {});
    };
  }

  void _navigateToPage(int index) {
      switch (index) {
        case 0:
        // Profile button tapped
          break;
        case 1:
        // Camera button tapped
          camera.onTapCameraButton(context);
          break;
        case 2:
        // Camera button tapped
          MaterialPageRoute(
            builder: (context) => Settings(),
          );
          break;
      }
  }


  Widget buildProfileDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 30,
                  child: Icon(
                    Icons.person_2_sharp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),
                ),
                      Center(
                        child: Text(
                          'OWA@nottingham.edu.my',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.fromLTRB(2.0, 0.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Details:\n',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontSize: 25,
                  ),
                ),
                Text(
                  'Current Level: 25\n\nPoints: 25000\n',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Progress:\n\n\n',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Reports made:',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.0,
                    fontSize: 18,
                  ),
                ),
              SizedBox(
                child: TextButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                  ),
                  icon: Icon(Icons.logout,
                  color: Colors.black,
                    ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/loginpage');
                    },
                    label: Text('logout',
                    style: TextStyle(
                        color: Colors.black,
                      fontSize: 20,
                    ),
                    ),
                  ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
