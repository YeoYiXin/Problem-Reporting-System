import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:problem_reporting_system/pages/dashboard/editProfilePage.dart';
import 'package:problem_reporting_system/pages/dashboard/functions/getPoints.dart';
import 'package:problem_reporting_system/pages/dashboard/services/update.dart';
import 'package:problem_reporting_system/pages/dashboard/services/updatesCard.dart';
import 'package:problem_reporting_system/pages/dashboard/services/Camera.dart';
import 'package:problem_reporting_system/pages/dashboard/services/report.dart';
import 'package:problem_reporting_system/pages/dashboard/services/reportsCard.dart';
import 'package:problem_reporting_system/pages/dashboard/changePasswordPage.dart';
import '../CheckReports.dart';

import 'package:problem_reporting_system/pages/dashboard/functions/getName.dart';

import 'functions/getProfilePic.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int _selectedIndex = 0;
  Camera camera = Camera();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    // Set the callback to trigger a rebuild when an image is selected
    camera.onImageSelected = () {
      setState(() {});
    };

    // Get the current user when the widget initializes
    currentUser = FirebaseAuth.instance.currentUser;
  }


  List<Update> updates = [
    Update(issue: 'Lamp post near F1 not working', status: 'Status:'),
    Update(issue: 'Air conditioner in F3B08 is now not working', status: 'Status:'),
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
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Text(
                    "Nott-A-Problem",
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 50,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0), // Add padding
                    child: ElevatedButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Set background color to white
                        foregroundColor:
                            Colors.black, // Set text color to black
                        elevation:
                            10, // Add elevation to create a pop-out effect
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16.0), // Rounded edges
                          side: BorderSide(
                              color: Colors.grey.shade200), // Border color
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child:
                                // _image != null ?
                                GetProfilePic(uid: currentUser!.uid),
                                  //    : CircleAvatar(
                                  // backgroundColor: Colors.grey,
                                  // radius: 20,
                                  // child: Icon(
                                  //   Icons.person_2_sharp,
                                  //   color: Colors.white,
                                  //   size: 15,
                                  // ),
                                // ),
                              ),
                              const SizedBox(
                                  width:
                                      8.0), // Adjust the spacing between icon and label
                              // Wrap USERNAME and Level in a common parent widget
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    GetName(uid: currentUser!.uid, section: "MainName"),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.yellow,
                                            size: 20), // Add the icon here
                                        const Gap(10),
                                        const Text(
                                          'Points:',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.black),
                                        ),
                                        const Gap(5),
                                        GetPoints(uid: currentUser!.uid),
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
                          const Color(0xFF8C00FF).withOpacity(0.7), // Light blue
                          const Color(0xFFFF9CE6).withOpacity(0.5), // Dark blue
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
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: const Text(
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
                            children: [
                              Positioned(
                                // right: 0,
                                child: SizedBox(
                                    width: MediaQuery.sizeOf(context).width / 2,
                                    child: Image.asset('assets/megaphone.png')),
                              ),
                              SizedBox(
                                height: 150.0, // Adjust the height as needed
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: reports.length,
                                  itemBuilder: (context, index) {
                                    return ReportCardItem(
                                        report: reports[index]);
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
                Expanded(
                  child: ListView(
                    children: updates
                        .map((update) => UpdateCard(update: update))
                        .toList(),
                  ),
                ),
                Container(
                  height: 70,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 0),
                    child: GNav(
                      selectedIndex: _selectedIndex,
                      onTabChange: _navigateToPage,
                      backgroundColor: Colors.transparent,
                      color: Colors.grey.shade700,
                      activeColor: Colors.white,
                      tabBackgroundColor: Colors.grey.shade800,
                      gap: 8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      tabs: const [
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
                          const Color(0xFF87CDFF).withOpacity(0.7), // Light blue
                          const Color(0xFF003BFF).withOpacity(0.5), // Dark blue
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[// _image != null ?
                        GetProfilePic(uid: currentUser!.uid),
                        //    : CircleAvatar(
                        // backgroundColor: Colors.grey,
                        // radius: 20,
                        // child: Icon(
                        //   Icons.person_2_sharp,
                        //   color: Colors.white,
                        //   size: 15,
                        // ),
                        // ),
                        GetName(uid: currentUser!.uid,section: "sidebar"),
                        GetName(uid: currentUser!.uid, section: "email"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "History",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.assignment, size: 30),
                          title: const Text('My Reports',
                              style: TextStyle(fontSize: 20)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckReports()),
                            );
                          },
                        ),
                        const Divider(),
                        const Text(
                          "Account Settings",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.edit, size: 30),
                          title: const Text('Change Profile Picture',
                              style: TextStyle(fontSize: 20)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return editProfilePage();
                            }
                            ));
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.edit, size: 30),
                          title: const Text('Change Password',
                              style: TextStyle(fontSize: 20)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const changePasswordPage();
                            }
                            ));
                          },
                        ),
                        const Divider(),
                        const Text(
                          "More",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.description, size: 30),
                          title: const Text('Terms of Service', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Terms of Service'),
                                  content: SingleChildScrollView(
                                    child: Text(
                                      '''
Welcome to Nott-A-Problem. These terms and conditions govern your use of the App. By downloading, installing, or using the App, you agree to be bound by these terms. If you do not agree with any part of these terms, please refrain from using the App.

1. Description of Services:
- The App provides a platform for the University of Nottingham Malaysia community to report faulty facilities by taking a picture and submitting it.
- The App utilizes artificial intelligence to detect the issue and its location automatically.

2. User Responsibilities:
- Users are responsible for the accuracy and validity of the information provided through the App.
- Users must ensure that they have permission to report issues in the locations depicted in the pictures they submit.
- Users must comply with all applicable laws and University regulations when using the App.

3. Permission Requirements:
- By using the App, you consent to allow access to your device's camera and location services to enable the reporting functionality.

4. Data Privacy:
- The App may collect and process personal data as described in the University of Nottingham Malaysia's privacy policy.
- Users' personal data will be handled in accordance with applicable data protection laws and University policies.

5. Intellectual Property:
- All intellectual property rights related to the App, including its design, content, and functionality, belong to the University of Nottingham Malaysia.
- Users may not reproduce, modify, or distribute any part of the App without prior written consent.

6. Limitation of Liability:
- The University of Nottingham Malaysia shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with the use of the App.
- The University does not guarantee the accuracy, reliability, or completeness of any information provided through the App.

7. Termination:
- The University reserves the right to terminate or suspend a user's access to the App at any time without prior notice if they violate these terms or misuse the App.

8. Governing Law and Jurisdiction:
- These terms and conditions shall be governed by and construed in accordance with the laws of Malaysia.
- Any disputes arising from these terms shall be subject to the exclusive jurisdiction of the courts of Malaysia.

9. Changes to Terms and Conditions:
- The University reserves the right to modify or update these terms and conditions at any time. Users will be notified of any changes, and continued use of the App constitutes acceptance of the revised terms.

10. Contact Information:
- If you have any questions or concerns regarding these terms and conditions, please contact us by clicking the help option in the profile bar.
              ''',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
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
                          title: const Text('Help', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Hyperlink to email admin'),
                                  content: const Text('.'),
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
                          leading: const Icon(Icons.people_alt_outlined, size: 30),
                          title:
                              const Text('About us', style: TextStyle(fontSize: 20)),
                          onTap: () {
                            // Your about us logic here
                          },
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, size: 30),
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.redAccent),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/loginpage', //dont have register route yet
                            );
                            // Logout logic here
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const Divider(),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
