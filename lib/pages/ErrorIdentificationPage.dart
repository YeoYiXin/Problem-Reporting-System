import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';
import 'package:problem_reporting_system/pages/ThirdPredictionPage.dart';
import 'package:problem_reporting_system/pages/FourthPredictionPage.dart';
import 'package:problem_reporting_system/pages/duplicationUI.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
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
  final String imageURL;

  ErrorIdentification({
    required this.imageFile,
    required this.firstPredictionResult,
    required this.secondPredictionResult,
    required this.thirdPredictionResult,
    required this.fourthPredictionResult,
    required this.locationInfo,
    required this.roomNumber,
    required this.latitude,
    required this.longitude,
    required this.imageURL,
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
            appBackground(), // Use the background from SecondPredictionPage
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                      child: Container(
                        width: 300,
                        height: 300,
                        child: Image.file(widget.imageFile),
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
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  'Subclass: ${widget.firstPredictionResult[1]}',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  'Location: ${widget.locationInfo}',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                Text(
                                  'Room Number: ${widget.roomNumber}',
                                  style: TextStyle(fontSize: 20.0),
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
                                                NoEventThankYou()));
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
                                        imageURL: widget.imageFile!,
                                        userTyped: false,
                                        latitude: widget.latitude,
                                        longitude: widget.longitude,
                                      );
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Submitted()));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            contentPadding:
                                                EdgeInsets.all(10.0),
                                            content: DuplicationUI(
                                              problemId: isSimilarID,
                                              imageUrl: widget.imageFile!,
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
                                child: Text('Yes'),
                              ),
                              ElevatedButton(
                                onPressed: () {
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
                                                        SecondPredictionPage(
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
                                                      imageURL: widget.imageURL,
                                                    ),
                                                  ));
                                                },
                                              ),
                                              ListTile(
                                                title: Text('Subclass'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ThirdPredictionPage(
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
                                                      imageURL: widget.imageURL,
                                                    ),
                                                  ));
                                                },
                                              ),
                                            ], // <-- Closing square bracket for ListBody children
                                          ),
                                        ),
                                      );
                                    }, // <-- Closing parenthesis for showDialog builder
                                  ); // <-- Closing parenthesis for showDialog method
                                },
                                child: Text('No'),
                              ),
                            ], // <-- Closing square bracket for Row children
                          ),
                        ], // <-- Closing square bracket for Column children
                      ),
                    ),
                  ),
                ], // <-- Closing square bracket for children of Center
              ),
            ),
          ],
        ),
      ),
    );
  }
}
