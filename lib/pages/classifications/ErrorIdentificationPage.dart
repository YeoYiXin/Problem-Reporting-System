// Written by Grp B
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/classifications/ClassErrorIdentity.dart';
import 'package:problem_reporting_system/pages/classifications/SubClassErrorIdentity.dart';
import 'package:problem_reporting_system/services/duplicationUI.dart';
import 'package:problem_reporting_system/services/noEventDetected.dart';
import 'package:problem_reporting_system/services/problem_submission_database.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'package:problem_reporting_system/services/appBackground.dart';
import 'dart:io';

class ErrorIdentification extends StatefulWidget {
  final File imageFile;
  final List<String> firstPredictionResult;
  final List<String> secondPredictionResult;
  final List<String> thirdPredictionResult;
  final List<String> fourthPredictionResult;
  final String locationInfo;
  final String roomNumber;
  final double latitude;
  final double longitude;

  const ErrorIdentification({super.key,
    required this.imageFile,
    required this.firstPredictionResult,
    required this.secondPredictionResult,
    required this.thirdPredictionResult,
    required this.fourthPredictionResult,
    required this.locationInfo,
    required this.roomNumber,
    required this.latitude,
    required this.longitude,
  });

  @override
  _ErrorIdentificationState createState() => _ErrorIdentificationState();
}

class _ErrorIdentificationState extends State<ErrorIdentification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const appBackground(), // Use the background from SecondPredictionPage
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Nott-A-Problem',
                        style: TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 50,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.file(widget.imageFile),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    margin: const EdgeInsets.all(16.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'First Trial',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Class: ${widget.firstPredictionResult[0].replaceAll('_', ' ')}',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  'Subclass: ${widget.firstPredictionResult[1]}',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  'Location: ${widget.locationInfo}',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  'Room Number: ${widget.roomNumber}',
                                  style: const TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (widget.firstPredictionResult[0]
                                          .replaceAll('_', ' ')
                                          .toLowerCase() ==
                                      'no event') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NoEventThankYou()));
                                  } else {
                                    String isSimilarID =
                                        await Problem_Submission_Database()
                                            .detectSimilarProblem(
                                      problemClass: widget
                                          .firstPredictionResult[0]
                                          .replaceAll('_', ' '),
                                      problemSubClass:
                                          widget.firstPredictionResult[1],
                                      problemLocation: widget.locationInfo,
                                    );
                                    if (isSimilarID == "0") {
                                      Problem_Submission_Database()
                                          .recordProblemSubmission(
                                        pIndoorLocation: widget.roomNumber,
                                        titleClass: widget
                                            .firstPredictionResult[0]
                                            .replaceAll('_', ' '),
                                        subClass:
                                            widget.firstPredictionResult[1],
                                        description:
                                            '', // No description available
                                        location: widget.locationInfo,
                                        imageURL: widget.imageFile,
                                        userTyped: false,
                                        latitude: widget.latitude,
                                        longitude: widget.longitude,
                                      );
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Submitted()));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(10.0),
                                            content: DuplicationUI(
                                              problemId: isSimilarID,
                                              imageUrl: widget.imageFile,
                                              roomNumber: widget.roomNumber,
                                              firstPredictionResult:
                                                  widget.firstPredictionResult,
                                              locationInfo: widget.locationInfo,
                                              latitude: widget.latitude,
                                              longitude: widget.longitude,
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                                child: const Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('What did we get wrong?'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              ListTile(
                                                title: const Text('Class'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClassErrorIdentity(
                                                      imageFile:
                                                          widget.imageFile,
                                                      secondPredictionResult: widget
                                                          .secondPredictionResult,
                                                      fourthPredictionResult: widget
                                                          .fourthPredictionResult,
                                                      locationInfo:
                                                          widget.locationInfo,
                                                      roomNumber:
                                                          widget.roomNumber,
                                                      latitude: widget.latitude,
                                                      longitude:
                                                          widget.longitude,
                                                    ),
                                                  ));
                                                },
                                              ),
                                              ListTile(
                                                title: const Text('Subclass'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        SubClassErrorIdentity(
                                                      imageFile:
                                                          widget.imageFile,
                                                      thirdPredictionResult: widget
                                                          .thirdPredictionResult,
                                                      secondPredictionResult: widget
                                                          .secondPredictionResult,
                                                      fourthPredictionResult: widget
                                                          .fourthPredictionResult,
                                                      locationInfo:
                                                          widget.locationInfo,
                                                      roomNumber:
                                                          widget.roomNumber,
                                                      latitude: widget.latitude,
                                                      longitude:
                                                          widget.longitude,
                                                    ),
                                                  ));
                                                },
                                              ),
                                            ], 
                                          ),
                                        ),
                                      );
                                    }, 
                                  ); 
                                },
                                child: const Text('No'),
                              ),
                            ],
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
      ),
    );
  }
}
