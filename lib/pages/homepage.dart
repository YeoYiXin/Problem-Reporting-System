import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:problem_reporting_system/services/update.dart';
import 'package:problem_reporting_system/services/updatesCard.dart';
import 'package:problem_reporting_system/services/Camera.dart';
import 'settingspage.dart';
import 'package:problem_reporting_system/services/report.dart';
import 'package:problem_reporting_system/services/reportsCard.dart';
import 'CheckReports.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();

}

class _HomeState extends State<Home> {

  final Gradient activeTabGradient = LinearGradient(
    colors: [Color(0xFF0072ff), Color(0xFF00c6ff)],  // Replace with your desired colors
  );


  int _selectedIndex = 0;
  Camera camera = Camera();

  List<Update> updates = [
    Update(issue: 'lamp post is now fixed', username: 'hcysc2'),
    Update(issue: 'air conditioner in F3B08 is now fixed', username: 'hcysc2'),
  ];

  List<Report> reports = [
    Report(issue: 'issue1', date: 'date1', progress: 'progress1'),
    Report(issue: 'issue2', date: 'date2', progress: 'progress2'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: buildProfileDrawer(),
      backgroundColor: Colors.white10,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        title: Container(
          // margin: EdgeInsets.zero,
          child: Center(
            child: Text("Nott-A-Problem",
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontFamily: 'Lobster',
                fontSize: 50,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: const Text(
                    "Hello USERNAME!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    icon: const Icon(Icons.person_2_sharp),
                    color: Colors.black54,
                  );
                }),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: const Text(
                "Let's make our campus a better place!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: const Text(
                'Your Recent Reports:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  // fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReportCard(report: reports[index]),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: const Text(
                'Recently Reported Problems',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.0,
                  // fontWeight: FontWeight.w700,
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
            ), //so that the 3 icons stay at the bottom of the page
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height:70,
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration : BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          border: Border.all(color: Colors.black),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: _navigateToPage,
            backgroundColor: Colors.black,
            color: Colors.grey.shade700,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            tabs: const [
              GButton(
                icon: Icons.house_outlined,
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Settings()),
        );
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffe402fd),
                    Color(0xff3d76ff),
                  ],
                ),
              ),
              child: const Column(
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
                  Center(
                    child: Text(
                      'OWA@nottingham.edu.my',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 0.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.info_outline, size: 30),
                    title: const Text('Level', style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Level system'),
                            content: const Text('Levels are upgraded by earning enough points. Show off your level now to display your contributions to the University of Nottingham campus now!'),
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
                  const SizedBox(height: 10.0),
                  ListTile(
                    leading: const Icon(Icons.info_outline, size: 30),
                    title: const Text('Points', style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Points system'),
                            content: const Text('Points are earned by submitting reports of faulty facilities around campus.'),
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
                  const SizedBox(height: 10.0),
                  ListTile(
                    leading: const Icon(Icons.assignment, size: 30),
                    title: const Text('My Reports', style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CheckReports()),
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
