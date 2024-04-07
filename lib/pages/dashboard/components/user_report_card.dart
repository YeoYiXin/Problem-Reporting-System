import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/user_report_card_items.dart';

class UserReportCard extends StatefulWidget {
  const UserReportCard({Key? key});

  @override
  State<UserReportCard> createState() => _UserReportCardState();
}

class _UserReportCardState extends State<UserReportCard> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference problemsRecord = FirebaseFirestore.instance.collection('problemsRecord');
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
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
                    color: Colors.black,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Positioned(
                    // right: 0,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Opacity(
                            opacity: 0.5,
                            child: Image.asset('assets/megaphone.png'))),
                  ),
                  SizedBox(
                    height: 200.0, // Adjust the height as needed
                    child: StreamBuilder<QuerySnapshot>(
                        stream: problemsRecord.where('uid', isEqualTo: uid).snapshots(),
                        builder:(context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return UserReportCardItem(
                                  title: snapshot.data!.docs[index]['problemTitle'],
                                  date: snapshot.data!.docs[index]['date']!,
                                  status: snapshot.data!.docs[index]['problemStatus']!,
                                );
                              },
                            );
                          }
                          else if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return Center(child: Text('No data available'));
                          }
                        }
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
