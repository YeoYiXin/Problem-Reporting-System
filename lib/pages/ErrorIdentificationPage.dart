import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';
import 'package:problem_reporting_system/pages/ThirdPredictionPage.dart';
import 'package:problem_reporting_system/pages/duplicationUI.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'package:problem_reporting_system/pages/submittedpage.dart';
import 'dart:io';

class ErrorIdentification extends StatefulWidget {
  final File imageFile;
  final List<String> firstPredictionResult;
  final List<String> secondPredictionResult;
  final List<String> thirdPredictionResult;
  final String locationInfo;
  final String roomNumber;

  ErrorIdentification({
    required this.imageFile,
    required this.firstPredictionResult,
    required this.secondPredictionResult,
    required this.thirdPredictionResult,
    required this.locationInfo,
    required this.roomNumber,
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
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey, // Example background color
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(
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
                      child: widget.imageFile != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.all(16.0),
                                    width: 300,
                                    height: 300,
                                    child: Image.file(widget.imageFile!),
                                  ),
                                ),
                                Container(
                                  child: const Center(
                                    child: Text(
                                      'The image taken by you is shown above.',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      16.0, 16.0, 16.0, 16.0),
                                  child: Text(
                                    'Category:',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    'We identified it as:\nClass: ${widget.firstPredictionResult[0].replaceAll('_', ' ')}\nSubclass: ${widget.firstPredictionResult[1]}',
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'The location is ${widget.locationInfo}',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Room Number: ${widget.roomNumber}',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'Is this correct?',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                            problemLocation:
                                                widget.locationInfo,
                                          );
                                          if (isSimilarID == "0") {
                                            Problem_Submission_Database()
                                                .recordProblemSubmission(
                                              pIndoorLocation:
                                                  widget.roomNumber,
                                              titleClass: widget
                                                  .firstPredictionResult[0]
                                                  .replaceAll('_', ' '),
                                              subClass: widget
                                                  .firstPredictionResult[1],
                                              description:
                                                  '', // No description available
                                              location: widget.locationInfo,
                                              imageURL: widget.imageFile!,
                                              userTyped: false,
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
                                                    roomNumber:
                                                        widget.roomNumber,
                                                    firstPredictionResult: widget
                                                        .firstPredictionResult,
                                                    locationInfo:
                                                        widget.locationInfo,
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
                                              title: Text(
                                                  'Which prediction was wrong?'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: [
                                                    ListTile(
                                                      title: Text('Class'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              SecondPredictionPage(
                                                            imageFile: widget
                                                                .imageFile,
                                                            secondPredictionResult:
                                                                widget
                                                                    .secondPredictionResult,
                                                            locationInfo: widget
                                                                .locationInfo,
                                                            roomNumber: widget
                                                                .roomNumber,
                                                          ),
                                                        ));
                                                      },
                                                    ),
                                                    ListTile(
                                                      title: Text('Subclass'),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        Navigator.of(context)
                                                            .push(
                                                                MaterialPageRoute(
                                                          builder: (context) =>
                                                              ThirdPredictionPage(
                                                            imageFile: widget
                                                                .imageFile,
                                                            thirdPredictionResult:
                                                                widget
                                                                    .thirdPredictionResult,
                                                            locationInfo: widget
                                                                .locationInfo,
                                                            roomNumber: widget
                                                                .roomNumber,
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
                                      child: Text('No'),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(),
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
