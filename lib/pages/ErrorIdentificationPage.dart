import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
import 'dart:io';
import 'submittedpage.dart';

class ErrorIdentification extends StatefulWidget {
  final File? imageFile;
  final List<String> classificationResult;
  final String locationInfo;

  ErrorIdentification({
    required this.imageFile,
    required this.classificationResult,
    required this.locationInfo,
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                        child: Text(
                          'Category:',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                        child: Text(
                          'We identified it as: ${widget.classificationResult.join(', ')}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Display location information
                      Container(
                        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                        child: Text(
                          'The location is ${widget.locationInfo}', // Use widget.locationInfo here
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
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
                              backgroundColor:
                                  Colors.blue[50], // Background color
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/submittedpage');
                            },
                            child: Text('Yes',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.blue[50], // Background color
                            ),
                            onPressed: () {
                              _showDescriptionDialog();
                            },
                            child: Text('No',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
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
    );
  }

  void _showDescriptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text('Please fill in below what the issue is so we can improve:'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                description = value;
              });
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
}
