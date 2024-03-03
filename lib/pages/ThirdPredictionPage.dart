import 'dart:io';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'submittedpage.dart';

class ThirdPredictionPage extends StatelessWidget {
  final File? imageFile;
  final List<String> thirdPredictionResult;
  final String locationInfo;
  final String roomNumber;

  ThirdPredictionPage({
    required this.imageFile,
    required this.thirdPredictionResult,
    required this.locationInfo,
    required this.roomNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('Third Prediction'),
        backgroundColor: Colors.blue[50],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  child: imageFile != null
                      ? Image.file(
                          imageFile!) // Add ! to access non-nullable File
                      : const Text('Image not available'),
                ),
              ),
              SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Third Prediction Results:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: thirdPredictionResult.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Class: ${thirdPredictionResult[0].replaceAll('_', ' ')}',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            'Subclass: ${thirdPredictionResult[1]}',
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
                    onPressed: () {
                      if (thirdPredictionResult[0]
                              .replaceAll('_', ' ')
                              .toLowerCase() ==
                          'no event') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NoEventThankYou()));
                      } else {
                        Problem_Submission_Database().recordProblemSubmission(
                          pIndoorLocation: roomNumber,
                          titleClass:
                              thirdPredictionResult[0].replaceAll('_', ' '),
                          subClass: thirdPredictionResult[1],
                          description: '', //empty
                          location: locationInfo,
                          imageURL: imageFile!,
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
                      _showDescriptionDialog(context);
                    },
                    child: Text('No'),
                  ),
                ],
              ),
            ],
          ),
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
                    imageURL: imageFile!,
                    userTyped: true,
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
