import 'package:flutter/material.dart';
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
                        child: Center(
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
                          'We identified it as:',
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
                              // Call the method to classify the image using the API
                              classifyImage();
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
                              // Show the description dialog
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

  //Method to make API request for classification
  void classifyImage() async {
    if (widget.imageFile != null) {
      var result = await API.getClassification(widget.imageFile!);
      print(result);

      // Handle the result as needed in your app
      if (result.containsKey('predicted class')) {
        String predictedClass = result['predicted class'];
        // Do something with the predicted class (e.g., update UI)
        print('Predicted Class: $predictedClass');
        // You may navigate to the submitted page or perform other actions based on the prediction
        Navigator.pushNamed(context, '/submittedpage');
      } else {
        // Handle the case where the result doesn't contain the predicted class
        print('Error: Prediction not available');
      }
    }
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
            decoration: const InputDecoration(
              hintText: 'Enter description...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Make API request for subclassification based on the description
                await subclassifyImage();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Add this method to make API request for subclassification
  Future<void> subclassifyImage() async {
    if (widget.imageFile != null) {
      var result = await API.getSubclassification(widget.imageFile!,
          'your_class_name'); // Replace with actual class name!!!!!!!!!!!
      print(result);

      // Handle the result as needed in your app
      if (result.containsKey('predicted class')) {
        String predictedClass = result['predicted class'];
        // Do something with the predicted class (e.g., update UI)
        print('Predicted Subclass: $predictedClass');
        // You may navigate to the submitted page or perform other actions based on the prediction
        Navigator.pushNamed(context, '/submittedpage');
      } else {
        // Handle the case where the result doesn't contain the predicted class
        print('Error: Prediction not available');
      }
    }
  }
}
