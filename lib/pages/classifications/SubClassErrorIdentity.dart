import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'
    as firebase_storage; // Add this line
import 'package:problem_reporting_system/pages/duplicationUI.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
import 'package:problem_reporting_system/services/verifyUnseen.dart';
import 'package:problem_reporting_system/pages/classifications/ClassErrorIdentity.dart';
import 'package:problem_reporting_system/pages/classifications/SecondSubClassErrorIdentity.dart';

class SubClassErrorIdentity extends StatelessWidget {
  final File imageFile;
  final List<String> thirdPredictionResult;
  final List<String> secondPredictionResult;
  final List<String> fourthPredictionResult;
  final String locationInfo;
  final String roomNumber;
  final double latitude;
  final double longitude;

  SubClassErrorIdentity({
    required this.imageFile,
    required this.thirdPredictionResult,
    required this.secondPredictionResult,
    required this.fourthPredictionResult,
    required this.locationInfo,
    required this.roomNumber,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            appBackground(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      'Nott-A-Problem',
                      style: TextStyle(
                        fontFamily: 'Lobster',
                        fontSize: 50,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: imageFile != null
                          ? Image.file(imageFile)
                          : const Text('Image not available'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    margin: EdgeInsets.all(16.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Third Trial:',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          ...(thirdPredictionResult.isNotEmpty
                              ? [
                                  Text(
                                    'Class: ${thirdPredictionResult[0].replaceAll('_', ' ')}',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Text(
                                    'Subclass: ${thirdPredictionResult[1]}',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ]
                              : [
                                  Text(
                                    'The location is $locationInfo',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ]),
                          SizedBox(height: 16),
                          Text(
                            'Is this correct?',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (thirdPredictionResult[0]
                                          .replaceAll('_', ' ')
                                          .toLowerCase() ==
                                      'no event') {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NoEventThankYou()));
                                  } else {
                                    Problem_Submission_Database()
                                        .recordProblemSubmission(
                                      pIndoorLocation: roomNumber,
                                      titleClass: thirdPredictionResult[0]
                                          .replaceAll('_', ' '),
                                      subClass: thirdPredictionResult[1],
                                      description: '', //empty
                                      location: locationInfo,
                                      imageURL: imageFile,
                                      userTyped: false,
                                      latitude: latitude,
                                      longitude: longitude,
                                    );
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Submitted()));
                                  }
                                },
                                child: Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  // Upload the image to Firebase Storage
                                  String problemId =
                                      await Problem_Submission_Database()
                                          .getProblemId();
                                  final storageRef = firebase_storage
                                      .FirebaseStorage.instance
                                      .ref()
                                      .child('submitted')
                                      .child('$problemId.jpg');
                                  await storageRef.putFile(imageFile);
                                  final String imageURL =
                                      await storageRef.getDownloadURL();
                                  print("imageURL: $imageURL");
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('What did we get wrong?'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              ListTile(
                                                title: Text('Class'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClassErrorIdentity(
                                                      imageFile: imageFile,
                                                      secondPredictionResult:
                                                          secondPredictionResult,
                                                      fourthPredictionResult:
                                                          fourthPredictionResult,
                                                      locationInfo:
                                                          locationInfo,
                                                      roomNumber: roomNumber,
                                                      latitude: latitude,
                                                      longitude: longitude,
                                                    ),
                                                  ));
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Subclass'),
                                                onTap: () async {
                                                  // Verify the unseen image
                                                  bool isLegit =
                                                      await verifyUnseen(
                                                          imageURL);

                                                  if (isLegit) {
                                                    // If the image is legitimate, proceed to _showDescriptionDialog
                                                    _showDescriptionDialog(
                                                        context);
                                                  } else {
                                                    // If the image is not legitimate, show a pop-up and navigate to the homepage
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "No problem identified"),
                                                          content: Text(
                                                              "If there is a problem, kindly retake the picture."),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/homepage');
                                                              },
                                                              child: Text(
                                                                  'Homepage'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDescriptionDialog(BuildContext context) {
    final TextEditingController _descriptionController =
        TextEditingController();
    String description = _descriptionController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please describe the issue'),
          content: TextField(
            onChanged: (value) {
              // Handle onChanged
              description = value;
            },
            decoration: InputDecoration(hintText: "Enter description..."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                if (description.replaceAll('_', ' ').toLowerCase() ==
                    'no event') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoEventThankYou()));
                } else {
                  Problem_Submission_Database().recordProblemSubmission(
                    pIndoorLocation: roomNumber,
                    titleClass: description,
                    subClass: "",
                    description: description, //empty
                    location: locationInfo,
                    imageURL: imageFile,
                    userTyped: true,
                    latitude: latitude,
                    longitude: longitude,
                  );
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Submitted()));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
