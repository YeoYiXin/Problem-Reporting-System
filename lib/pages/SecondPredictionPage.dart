import 'dart:io';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/services/verifyUnseen.dart';
import 'submittedpage.dart';

class SecondPredictionPage extends StatelessWidget {
  final File? imageFile;
  final List<String> secondPredictionResult;
  final String locationInfo;

  SecondPredictionPage({
    required this.imageFile,
    required this.secondPredictionResult,
    required this.locationInfo,
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Submitted()));
                    },
                    child: Text('Yes'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Show the description dialog if th
                      bool isLegit = await verifyUnseen(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Montes_de_Vitoria_-_Pieza_de_Vitoria_04.jpg/800px-Montes_de_Vitoria_-_Pieza_de_Vitoria_04.jpg');
                      if (isLegit) {
                        _showDescriptionDialog(context);
                      } else {
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please describe the issue'),
          content: TextField(
            onChanged: (value) {
              // Handle onChanged
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Submitted()));
              },
            ),
          ],
        );
      },
    );
  }
}
