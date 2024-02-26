import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
import 'dart:io';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';
import 'package:problem_reporting_system/pages/duplicationUI.dart';
import 'package:problem_reporting_system/pages/ThirdPredictionPage.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'submittedpage.dart';

class ErrorIdentification extends StatefulWidget {
  final File? imageFile;
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
  State<ErrorIdentification> createState() => _ErrorIdentificationState();
}

class _ErrorIdentificationState extends State<ErrorIdentification> {
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Image.asset(
          'assets/nottinghamlogo.jpg',
          height: 200,
          width: 200,
          color: Colors.blue[50],
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.blue[50],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                              margin:
                                  EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    print(widget.firstPredictionResult[0]
                                        .replaceAll('_', ' ')
                                        .toLowerCase()
                                        .toString());
                                    if (widget.firstPredictionResult[0]
                                            .replaceAll('_', ' ')
                                            .toLowerCase() ==
                                        'no event') {
                                      //return no problem is submitted
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
                                                  problemSubClass: widget
                                                      .firstPredictionResult[1],
                                                  problemLocation:
                                                      widget.locationInfo);

                                      print("isSimilarID: $isSimilarID");

                                      if (isSimilarID.toString() == "0") {
                                        print(
                                            "Problem_Submission_Database( ).....");
                                        Problem_Submission_Database()
                                            .recordProblemSubmission(
                                          pIndoorLocation: widget.roomNumber,
                                          titleClass: widget
                                              .firstPredictionResult[0]
                                              .replaceAll('_', ' '),
                                          subClass:
                                              widget.firstPredictionResult[1],
                                          description:
                                              description, // dont have descriptiond
                                          location: widget.locationInfo,
                                          imageURL: widget.imageFile!,
                                          userTyped: false,
                                        );
                                        print(
                                            "Problem_Submission_Database over( ).....");
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          SecondPredictionPage(
                                        imageFile: widget.imageFile,
                                        secondPredictionResult:
                                            widget.secondPredictionResult,
                                        locationInfo: widget.locationInfo,
                                        roomNumber: widget.roomNumber,
                                      ),
                                    ));
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
            ),
          ),
        ],
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
          title:
              Text('Please fill in below what the issue is so we can improve:'),
          content: TextField(
            onChanged: (value) {
              description = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter description...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                print('Description: $description');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Submitted(),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
