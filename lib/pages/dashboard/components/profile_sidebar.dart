import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../CheckReports.dart';
import '../changePasswordPage.dart';
import '../editProfilePage.dart';
import '../functions/getName.dart';
import '../functions/getProfilePic.dart';

Widget buildProfileDrawer(BuildContext context) {
  User? currentUser = FirebaseAuth.instance.currentUser;
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