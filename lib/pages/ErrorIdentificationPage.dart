import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
import 'dart:io';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';
import 'package:problem_reporting_system/pages/noEventDetected.dart';
import 'package:problem_reporting_system/pages/problem_submission_database.dart';
import 'submittedpage.dart';

class ErrorIdentification extends StatefulWidget {
  final File? imageFile;
  final List<String> firstPredictionResult;
  final List<String> secondPredictionResult;
  final String locationInfo;
  final String roomNumber;

  ErrorIdentification({
    required this.imageFile,
    required this.firstPredictionResult,
    required this.secondPredictionResult,
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(
              children: [
                appBackground(),
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: widget.imageFile != null
                        ? Column(
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
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
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
                                    Padding(
                                      padding:
                                        const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Text(
                                  'We identified it as\nClass: ${widget.firstPredictionResult[0].replaceAll('_', ' ')}\nSubclass: ${widget.firstPredictionResult[1]}',
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
                                      ],),
                                    ),
                              ),
                                     Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'Is this correct?',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    ),
                                    onPressed: () {
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

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Submitted()));
                                      }
                                    },
                                    icon: const Icon(Icons.check,color: Colors.green,),
                                    label: Text('Yes' ,style: TextStyle(color: Colors.green)),
                                  ),
                                  TextButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    ),
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
                                    icon: const Icon(Icons.close, color: Colors.red),
                                    label: Text('No', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                              ],
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  )),
            ],)));
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
              // You can use the 'description' variable here
              print('Description: $description');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Submitted(),
                ),
              ); // Close the dialog
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}
