import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:problem_reporting_system/pages/duplicationUI.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/services/verifyUnseen.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import '../submittedpage.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';

class SecondSubClassErrorIdentity extends StatelessWidget {
  final File imageFile;
  final List<String> secondPredictionResult;
  final List<String> fourthPredictionResult;
  final String locationInfo;
  final String roomNumber;
  final double latitude;
  final double longitude;
  final String description = '';

  SecondSubClassErrorIdentity({
    required this.imageFile,
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Image.file(
                            imageFile), // Add ! to access non-nullable File
                      ),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Fourth Trial',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: fourthPredictionResult.isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Class: ${fourthPredictionResult[0].replaceAll('_', ' ')}',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                      Text(
                                        'Subclass: ${fourthPredictionResult[1]}',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'The location is  $locationInfo',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print(fourthPredictionResult[0]
                              .replaceAll('_', ' ')
                              .toLowerCase()
                              .toString());
                          if (fourthPredictionResult[0]
                                  .replaceAll('_', ' ')
                                  .toLowerCase() ==
                              'no event') {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoEventThankYou()));
                          } else {
                            String isSimilarID =
                                await Problem_Submission_Database()
                                    .detectSimilarProblem(
                                        problemClass: fourthPredictionResult[0]
                                            .replaceAll('_', ' '),
                                        problemSubClass:
                                            fourthPredictionResult[1],
                                        problemLocation: locationInfo);
                            print("isSimilarID: $isSimilarID");
                            if (isSimilarID.toString() == "0") {
                              print(
                                  "Problem_Submission_Database second( ).....");
                              Problem_Submission_Database()
                                  .recordProblemSubmission(
                                pIndoorLocation: roomNumber,
                                titleClass: fourthPredictionResult[0]
                                    .replaceAll('_', ' '),
                                subClass: fourthPredictionResult[1],
                                description: description,
                                location: locationInfo,
                                imageURL: imageFile,
                                userTyped: false,
                                latitude: latitude,
                                longitude: longitude,
                              );
                              print(
                                  "Problem_Submission_Database over second( ).....");

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Submitted()));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: DuplicationUI(
                                      problemId: isSimilarID,
                                      imageUrl: imageFile,
                                      roomNumber: roomNumber,
                                      firstPredictionResult:
                                          fourthPredictionResult,
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
                        child: Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print(fourthPredictionResult[0]
                              .replaceAll('_', ' ')
                              .toLowerCase()
                              .toString());

                          String problemId = await Problem_Submission_Database()
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
                            barrierDismissible:
                                false, // Prevent dismissing the dialog by tapping outside
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(), // Loading indicator
                                    SizedBox(height: 16),
                                    Text('Verifying...'), // Loading text
                                  ],
                                ),
                              );
                            },
                          );

                          // Show the description dialog if th
                          bool isLegit = await verifyUnseen(imageURL);

                          if (isLegit) {
                            final storageRef = firebase_storage
                                .FirebaseStorage.instance
                                .ref()
                                .child('submitted')
                                .child('$problemId.jpg');
                            await storageRef.delete();
                            _showDescriptionDialog(context);
                          } else {
                            final storageRef = firebase_storage
                                .FirebaseStorage.instance
                                .ref()
                                .child('submitted')
                                .child('$problemId.jpg');
                            await storageRef.delete();

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("No problem identified"),
                                  content: Text(
                                      "If there is a problem, kindly retake the picture."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/homepage');
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text('No'),
                      ),
                    ],
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
                print("Problem_Submission_Database second second( ).....");
                print(
                    description.replaceAll('_', ' ').toLowerCase().toString());
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
                    imageURL: imageFile!,
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
