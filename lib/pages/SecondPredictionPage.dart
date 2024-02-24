import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/services/verifyUnseen.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'submittedpage.dart';

class SecondPredictionPage extends StatelessWidget {
  final File? imageFile;
  final List<String> secondPredictionResult;
  final String locationInfo;
  final String roomNumber;

  final String description = ''; // dont have

  SecondPredictionPage({
    required this.imageFile,
    required this.secondPredictionResult,
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
        title: Text('Second Prediction'),
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
                  'Second Prediction Results:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: secondPredictionResult.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Class: ${secondPredictionResult[0].replaceAll('_', ' ')}',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            'Subclass: ${secondPredictionResult[1]}',
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
                      print(secondPredictionResult[0]
                          .replaceAll('_', ' ')
                          .toLowerCase()
                          .toString());
                      if (secondPredictionResult[0]
                              .replaceAll('_', ' ')
                              .toLowerCase() ==
                          'no event') {
                        //return no problem is submitted
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NoEventThankYou()));
                      } else {
                        print("Problem_Submission_Database second( ).....");
                        Problem_Submission_Database().recordProblemSubmission(
                          pIndoorLocation: roomNumber,
                          titleClass:
                              secondPredictionResult[0].replaceAll('_', ' '),
                          subClass: secondPredictionResult[1],
                          description: description, //empty
                          location: locationInfo,
                          imageURL: imageFile!,
                          userTyped: false,
                        );
                        print(
                            "Problem_Submission_Database over second( ).....");

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Submitted()));
                      }
                    },
                    child: Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String problemId =
                          await Problem_Submission_Database().getProblemId();
                      final storageRef = firebase_storage
                          .FirebaseStorage.instance
                          .ref()
                          .child('submitted')
                          .child('$problemId.jpg');
                      await storageRef.putFile(imageFile as File);
                      final String imageURL = await storageRef.getDownloadURL();

                      // Show the description dialog if th
                      bool isLegit = await verifyUnseen(imageURL);

                      if (isLegit) {
                        final storageRef = firebase_storage
                            .FirebaseStorage.instance
                            .ref()
                            .child('submitted')
                            .child('$problemId.jpg');
                        await storageRef.delete();
                        Navigator.pushNamed(context, '/homepage');
                        _showDescriptionDialog(context);
                      } else {
                        final storageRef = firebase_storage
                            .FirebaseStorage.instance
                            .ref()
                            .child('submitted')
                            .child('$problemId.jpg');
                        await storageRef.delete();
                        Navigator.pushNamed(context, '/homepage');
                      }
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
