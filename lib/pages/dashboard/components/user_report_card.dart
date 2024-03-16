import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../History/user_report_card_items.dart';

class UserReportCard extends StatefulWidget {
  const UserReportCard({super.key});

  @override
  State<UserReportCard> createState() => _UserReportCardState();
}

class _UserReportCardState extends State<UserReportCard> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference problemsRecord = FirebaseFirestore.instance.collection('problemsRecord');
    return Card(
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
                    child: FutureBuilder(
                      future: problemsRecord.where('uid', isEqualTo: uid).get(),
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
                      else if (snapshot.connectionState == ConnectionState.none) {
                        return CircularProgressIndicator();
                        } else {
                        return CircularProgressIndicator();
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
