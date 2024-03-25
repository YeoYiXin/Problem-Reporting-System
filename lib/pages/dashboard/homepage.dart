import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
import 'package:problem_reporting_system/pages/dashboard/components/profile_button.dart';
import 'package:problem_reporting_system/pages/dashboard/components/user_report_card.dart';
import 'package:problem_reporting_system/pages/dashboard/services/recent_reports_items.dart';
import 'components/bottom_navigation_bar.dart';
import 'components/profile_sidebar.dart';
import 'components/recent_reports.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  User? currentUser;

  @override
  void initState() {
    super.initState();
    // Get the current user when the widget initializes
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: buildProfileDrawer(context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            appBackground(),
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
                  ProfileButton(currentUser: currentUser),
                  UserReportCard(),
                  RecentProblemsSection(),
                  // Container(
                  //   margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  //   child: const Text(
                  //     'Recent Problems',
                  //     textAlign: TextAlign.left,
                  //     style: TextStyle(
                  //       fontSize: 20.0,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  // ), //updates for fixtures and reports
                  // Expanded(
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.vertical,
                  //     itemBuilder: (context, index) {
                  //       return UpdateCardItems();
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
