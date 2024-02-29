import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:problem_reporting_system/pages/dashboard/homepage.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DuplicationUI extends StatefulWidget {
  final String problemId;
  final File imageUrl;
  final String roomNumber;
  final List<String> firstPredictionResult;
  final String locationInfo;

  const DuplicationUI({
    required this.problemId,
    required this.imageUrl,
    required this.roomNumber,
    required this.firstPredictionResult,
    required this.locationInfo,
  });

  @override
  _DuplicationUIState createState() => _DuplicationUIState();
}

class _DuplicationUIState extends State<DuplicationUI> {
  late Future<DocumentSnapshot> _problemFuture;
  String description = '';

  @override
  void initState() {
    super.initState();
    _problemFuture = FirebaseFirestore.instance
        .collection('problemsRecord')
        .doc(widget.problemId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _problemFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Problem details not found'));
        } else {
          final problemData = snapshot.data!;
          final title = problemData.get('problemTitle');
          final location = problemData.get('problemLocation');
          final indoorLocation = problemData.get('pIndoorLocation');

          return Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(20),
                      Image.file(widget.imageUrl, height: 300, width: 300),
                      Gap(20),
                      Text(
                        '$location, at $indoorLocation',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(20),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await writeReportNumber(widget.problemId);
                              await checkIncrementPriority(widget.problemId);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Problem has been updated!'),
                                  content: Text('Thank you for your time!'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text('Yes'),
                          ),
                          Gap(20),
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              print(
                                  "Problem_Submission_Database duplication ui( ).....");
                              Problem_Submission_Database()
                                  .recordProblemSubmission(
                                pIndoorLocation: widget.roomNumber,
                                titleClass: widget.firstPredictionResult[0]
                                    .replaceAll('_', ' '),
                                subClass: widget.firstPredictionResult[1],
                                description:
                                    description, // dont have descriptiond
                                location: widget.locationInfo,
                                imageURL: widget.imageUrl!,
                                userTyped: false,
                              );
                              print(
                                  "Problem_Submission_Database over duplication ui( ).....");

                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Submitted(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Text('No'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future<void> writeReportNumber(String problemId) async {
    final _firestore = FirebaseFirestore.instance;
    try {
      final documentSnapshot =
          await _firestore.collection('problemsRecord').doc(problemId).get();
      if (documentSnapshot.exists) {
        final reportNum = documentSnapshot.get('problemReportNum') ?? 0;
        await _firestore
            .collection('problemsRecord')
            .doc(problemId)
            .update({'problemReportNum': reportNum + 1});
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Future<void> checkIncrementPriority(String problemId) async {
    final _firestore = FirebaseFirestore.instance;
    try {
      final documentSnapshot =
          await _firestore.collection('problemsRecord').doc(problemId).get();
      if (documentSnapshot.exists) {
        final reportNum = documentSnapshot.get('problemReportNum') ?? 0;
        if (reportNum > 5) {
          final priority = documentSnapshot.get('problemPriority').toString();
          if (priority == 'low') {
            await _firestore
                .collection('problemsRecord')
                .doc(problemId)
                .update({'problemPriority': 'medium'});
          } else if (priority == 'medium') {
            await _firestore
                .collection('problemsRecord')
                .doc(problemId)
                .update({'problemPriority': 'high'});
          } else {
            await _firestore
                .collection('problemsRecord')
                .doc(problemId)
                .update({'problemPriority': 'high'});
          }
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
