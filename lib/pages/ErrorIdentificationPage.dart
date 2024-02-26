import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
import 'dart:io';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.imageFile != null) ...[
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.8,
                            child: Image.file(widget.imageFile!),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'The image taken by you is shown above.',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 16.0),
                      Text(
                        'Category:',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'We identified it as:\nClass: ${widget.firstPredictionResult[0].replaceAll('_', ' ')}\nSubclass: ${widget.firstPredictionResult[1]}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'The location is ${widget.locationInfo}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Room Number: ${widget.roomNumber}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Is this correct?',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print(widget.firstPredictionResult[0]
                                  .replaceAll('_', ' ')
                                  .toLowerCase()
                                  .toString());
                              if (widget.firstPredictionResult[0]
                                      .replaceAll('_', ' ')
                                      .toLowerCase() ==
                                  'no event') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NoEventThankYou()));
                              } else {
                                Problem_Submission_Database()
                                    .recordProblemSubmission(
                                  pIndoorLocation: widget.roomNumber,
                                  titleClass: widget.firstPredictionResult[0]
                                      .replaceAll('_', ' '),
                                  subClass: widget.firstPredictionResult[1],
                                  description: description,
                                  location: widget.locationInfo,
                                  imageURL: widget.imageFile!,
                                  userTyped: false,
                                );
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Submitted()));
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
                                    title: Text('Which prediction was wrong?'),
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
                                                  imageFile: widget.imageFile,
                                                  secondPredictionResult: widget
                                                      .secondPredictionResult,
                                                  locationInfo:
                                                      widget.locationInfo,
                                                  roomNumber: widget.roomNumber,
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
                                                  imageFile: widget.imageFile,
                                                  thirdPredictionResult: widget
                                                      .thirdPredictionResult,
                                                  locationInfo:
                                                      widget.locationInfo,
                                                  roomNumber: widget.roomNumber,
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
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showDescriptionDialog(BuildContext context) {
  final TextEditingController _descriptionController = TextEditingController();
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
