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

class SubClassErrorIdentity extends StatelessWidget {
  final File imageFile;
  final List<String> thirdPredictionResult;
  final List<String> secondPredictionResult;
  final List<String> fourthPredictionResult;
  final String locationInfo;
  final String roomNumber;
  final double latitude;
  final double longitude;

  const SubClassErrorIdentity({
    super.key,
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
            const appBackground(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      'Nott-A-Problem',
                      style: TextStyle(
                        fontFamily: 'Lobster',
                        fontSize: 50,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: imageFile != null
                          ? Image.file(imageFile)
                          : const Text('Image not available'),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            // Center-align "Third Trial" text
                            child: Text(
                              'Third Trial:',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...(thirdPredictionResult.isNotEmpty
                              ? [
                                  Text(
                                    'Class: ${thirdPredictionResult[0].replaceAll('_', ' ')}',
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                  Text(
                                    'Subclass: ${thirdPredictionResult[1]}',
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ]
                              : [
                                  Text(
                                    'The location is $locationInfo',
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ]),
                          const SizedBox(height: 16),
                          const Text(
                            'Is this correct?',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (thirdPredictionResult[0]
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
                                      problemClass: thirdPredictionResult[0]
                                          .replaceAll('_', ' '),
                                      problemSubClass: thirdPredictionResult[1],
                                      problemLocation: locationInfo,
                                    );
                                    if (isSimilarID == "0") {
                                      Problem_Submission_Database()
                                          .recordProblemSubmission(
                                        pIndoorLocation: roomNumber,
                                        titleClass: thirdPredictionResult[0]
                                            .replaceAll('_', ' '),
                                        subClass: thirdPredictionResult[1],
                                        description:
                                            '', // No description available
                                        location: locationInfo,
                                        imageURL: imageFile,
                                        userTyped: false,
                                        latitude: latitude,
                                        longitude: longitude,
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
                                              imageUrl: imageFile,
                                              roomNumber: roomNumber,
                                              firstPredictionResult:
                                                  thirdPredictionResult,
                                              locationInfo: locationInfo,
                                              latitude: latitude,
                                              longitude: longitude,
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
                                        title: const Text(
                                            'What did we get wrong?'),
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
                                                title: const Text('Subclass'),
                                                onTap: () async {
                                                  // Show loading dialog
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible:
                                                        false, // Prevent dismissing the dialog by tapping outside
                                                    builder:
                                                        (BuildContext context) {
                                                      return const AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            CircularProgressIndicator(), // Loading indicator
                                                            SizedBox(
                                                                height: 16),
                                                            Text(
                                                                'Verifying...'), // Loading text
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
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
                                                          title: const Text(
                                                              "No problem identified"),
                                                          content: const Text(
                                                              "If there is a problem, kindly retake the picture."),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pushNamed(
                                                                    context,
                                                                    '/homepage');
                                                              },
                                                              child: const Text(
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

  void _showDescriptionDialog(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    String description = descriptionController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please describe the issue'),
          content: TextField(
            onChanged: (value) {
              // Handle onChanged
              description = value;
            },
            decoration: const InputDecoration(hintText: "Enter description..."),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                if (description.replaceAll('_', ' ').toLowerCase() ==
                    'no event') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NoEventThankYou()));
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Submitted()));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
