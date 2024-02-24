import 'package:flutter/material.dart';
import 'dart:io';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';
import 'package:problem_reporting_system/pages/appBackground.dart';
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
  bool isSecondPredictionDisplayed = false;
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children:[
            appBackground(),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                            margin: EdgeInsets.fromLTRB(16,0,16,16.0),
                            width: 300,
                            height: 300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0), // Adjust the value as needed
                              child: Image.file(widget.imageFile!),
                            ),
                          ),
                        ),
                        const Text(
                          'The image taken by you is shown above.',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Card(
                          margin: EdgeInsets.all(16.0),
                          elevation: 4, // Add elevation for a shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'We identified it as\nClass: ${widget.firstPredictionResult[0].replaceAll('_', ' ')}\nSubclass: ${widget.firstPredictionResult[1]}',
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Location: ${widget.locationInfo}',
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
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Is this correct?',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Submitted()));
                              },
                              icon: const Icon(Icons.check,color: Colors.green,),
                              label: Text('Yes' ,style: TextStyle(color: Colors.green)),
                            ),
                            TextButton.icon(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SecondPredictionPage(
                                    imageFile: widget.imageFile,
                                    secondPredictionResult:
                                        widget.secondPredictionResult,
                                    locationInfo: widget.locationInfo,
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
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Image not available'),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Return'),
                        ),
                      ],
                    ),
                        ),
            ),
    ],
        ),
      ),
    );
  }
}
