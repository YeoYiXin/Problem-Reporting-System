import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:problem_reporting_system/pages/dashboard/services/update.dart';
import 'package:problem_reporting_system/pages/dashboard/services/updatesCard.dart';
import 'package:problem_reporting_system/pages/dashboard/services/Camera.dart';
import 'package:problem_reporting_system/pages/dashboard/services/report.dart';
import 'package:problem_reporting_system/pages/dashboard/services/reportsCard.dart';
import '../CheckReports.dart';
import '../appBackground.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  final int _selectedIndex = 0;
  Camera camera = Camera();

  List<Update> updates = [
    Update(issue: 'Lamp post near F1 not working', username: 'hcysc2'),
    Update(issue: 'Air conditioner in F3B08 is now not working', username: 'hcysc2'),
  ];

  List<Report> reports = [
    Report(issue: 'issue1', date: 'date1', progress: 'progress1'),
    Report(issue: 'issue2', date: 'date2', progress: 'progress2'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: buildProfileDrawer(),
      backgroundColor: Colors.white10,
      body: Stack(
        children: [
          // const appBackground(),
          SafeArea(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text("Nott-A-Problem",
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 50,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Set background color to white
                        foregroundColor: Colors.black, // Set text color to black
                        elevation: 10, // Add elevation to create a pop-out effect
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0), // Rounded edges
                          side: BorderSide(color: Colors.grey.shade200), // Border color
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child: CircleAvatar(
                                  radius: 20.0, // Adjust the radius as needed
                                  backgroundColor: Colors.black,
                                  child: Icon(Icons.person_2_sharp, color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 8.0), // Adjust the spacing between icon and label
                              // Wrap USERNAME and Level in a common parent widget
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'USERNAME',
                                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.bar_chart, color: Colors.green, size: 20),
                                        Text(
                                          'Level:',
                                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Icon(Icons.star, color: Colors.yellow, size: 20), // Add the icon here
                                        // const SizedBox(width: 4.0), // Adjust the spacing between icon and text
                                        Text(
                                          'Points:',
                                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                                        ),
                                        const SizedBox(width: 8.0),
                                         // Add the icon here
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              Card(
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF8C00FF).withOpacity(0.7), // Light blue
                        Color(0xFFFF9CE6).withOpacity(0.5), // Dark blue
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0,0,0,16),
                          child: Text(
                            'Your Reports:',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.centerRight,
                          children:[
                            Positioned(
                              // right: 0,
                              child: Container(
                                width: MediaQuery.sizeOf(context).width / 2,
                                  child: Image.asset('assets/megaphone.png')),
                            ),
                            Container(
                            height: 150.0, // Adjust the height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: reports.length,
                              itemBuilder: (context, index) {
                                return ReportCardItem(report: reports[index]);
                              },
                            ),
                          ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const Divider(),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: const Text(
                  'Recent Problems',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ), //updates for fixtures and reports
              //this part
              Expanded(
                child: ListView(
                  children: updates
                      .map((update) => UpdateCard(update: update))
                      .toList(),
                ),
              ),
              Container(
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  border: Border.all(color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: GNav(
                    selectedIndex: _selectedIndex,
                    onTabChange: _navigateToPage,
                    backgroundColor: Colors.transparent,
                    color: Colors.grey.shade700,
                    activeColor: Colors.white,
                    tabBackgroundColor: Colors.grey.shade800,
                    gap: 8,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    tabs: [
                      GButton(
                        icon: Icons.house_outlined,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.camera_alt,
                        text: 'Camera',
                      ),
                    ],
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
      //refresh logic
        break;
      case 1:
      // Camera button tapped
        camera.onTapCameraButton(context);
        break;
    }
  }

  Widget buildProfileDrawer() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20.0),
        topLeft: Radius.circular(20.0),
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF87CDFF).withOpacity(0.7), // Light blue
                          Color(0xFF003BFF).withOpacity(0.5), // Dark blue
                        ],
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
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          'OWA@nottingham.edu.my',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "History",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.assignment, size: 30),
                          title: Text('My Reports', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CheckReports()),
                            );
                          },
                        ),
                        Divider(),
                        Text(
                          "Account Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.edit, size: 30),
                          title: Text('Edit Profile', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Edit Profile Logic'),
                                  content: Text('.'),
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
                          title: Text('Change Password', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Change Password Logic'),
                                  content: Text('.'),
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
                        Text(
                          "More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.description, size: 30),
                          title: Text('Terms of Service', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Terms of Service'),
                                  content: Text('Terms of Service'),
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
                          title: Text('Help', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Hyperlink to email admin'),
                                  content: Text('.'),
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
                          leading: Icon(Icons.people_alt_outlined, size: 30),
                          title: Text('About us', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            // Your about us logic here
                          },
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, size: 30),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.redAccent),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Logout logic here
                          },
                          child: Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

}
