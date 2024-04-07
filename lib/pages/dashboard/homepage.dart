import 'package:cloud_firestore/cloud_firestore.dart';
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
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              print(snapshot.data!.data());
              return Scaffold(
                endDrawer: buildProfileDrawer(context, snapshot.data!),
                body: Stack(
                  children: [
                    appBackground(),
                    SafeArea(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
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
                            ProfileButton(user: snapshot.data!),
                            UserReportCard(),
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
                            ),
                            RecentProblemsSection(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          }
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }
}
