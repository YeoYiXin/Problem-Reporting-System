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

  const SecondSubClassErrorIdentity({super.key,
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
            const appBackground(),
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
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
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.file(
                            imageFile), // Add ! to access non-nullable File
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
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                      Text(
                                        'Subclass: ${fourthPredictionResult[1]}',
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'The location is  $locationInfo',
                                      style: const TextStyle(fontSize: 20.0),
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
                                builder: (context) => const NoEventThankYou()));
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
                                  builder: (context) => const Submitted()));
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
                        child: const Text('Yes'),
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
                              return const AlertDialog(
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
                            _showDescriptionDialog(context, imageFile);
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
                                  title: const Text("No problem identified"),
                                  content: const Text(
                                      "If there is a problem, kindly retake the picture."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/homepage');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text('No'),
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

  void _showDescriptionDialog(BuildContext context, File imageURL) {
    final TextEditingController descriptionController =
        TextEditingController();
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
                print("Problem_Submission_Database second second( ).....");
                print(
                    description.replaceAll('_', ' ').toLowerCase().toString());
                if (description.replaceAll('_', ' ').toLowerCase() ==
                    'no event') {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NoEventThankYou()));
                } else {
                  Problem_Submission_Database().recordProblemSubmission(
                    pIndoorLocation: roomNumber,
                    titleClass: description,
                    subClass: "",
                    description: "", 
                    location: locationInfo,
                    imageURL: imageURL,
                    userTyped: true,
                    latitude: latitude,
                    longitude: longitude,
                  );
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Submitted()));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
