import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
import 'dart:io';
import 'submittedpage.dart';
import 'api.dart';

class ErrorIdentification extends StatefulWidget {
  final File? imageFile;
  ErrorIdentification({required this.imageFile});

  @override
  State<ErrorIdentification> createState() => _ErrorIdentificationState();
}

class _ErrorIdentificationState extends State<ErrorIdentification> {
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const appBackground(),
          SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: widget.imageFile != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0,20.0,16.0,16.0),
                    child: Center(
                      child: Text(
                        "Nott-A-Problem",
                        style: TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      width: 300,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
                        child: Image.file(widget.imageFile!),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'The image taken by you is shown above.',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category:',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'We identified it as:',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                    Container(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Text(
                      'Is this correct?',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                        ),
                        onPressed: () {
                          classifyImage();
                        },
                        child: Text('Yes', style: TextStyle(color: Colors.black)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                        ),
                        onPressed: () {
                          _showDescriptionDialog();
                        },
                        child: Text('No', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              )
                  : Column(
                children: [
                  Text('Image not available'),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    label: Text('Return Home'),
                    icon: Icon(Icons.turn_left),
                  ),
                ],
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }

  void classifyImage() async {
    if (widget.imageFile != null) {
      var result = await API.getClassification(widget.imageFile!);
      print(result);

      if (result.containsKey('predicted class')) {
        String predictedClass = result['predicted class'];
        print('Predicted Class: $predictedClass');
        Navigator.pushNamed(context, '/submittedpage');
      } else {
        print('Error: Prediction not available');
      }
    }
  }

  void _showDescriptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please fill in below what the issue is so we can improve:'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
            decoration: const InputDecoration(
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
              onPressed: () async {
                await subclassifyImage();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> subclassifyImage() async {
    if (widget.imageFile != null) {
      var result = await API.getSubclassification(widget.imageFile!, 'your_class_name');
      print(result);

      if (result.containsKey('predicted class')) {
        String predictedClass = result['predicted class'];
        print('Predicted Subclass: $predictedClass');
        Navigator.pushNamed(context, '/submittedpage');
      } else {
        print('Error: Prediction not available');
      }
    }
  }
}