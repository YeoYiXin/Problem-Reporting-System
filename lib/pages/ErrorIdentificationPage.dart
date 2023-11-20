import 'package:flutter/material.dart';
import 'dart:io';

class ErrorIdentification extends StatefulWidget {
  final File? imageFile;
  ErrorIdentification({required this.imageFile});

  @override
  State<ErrorIdentification> createState() => _ErrorIdentificationState();
}

class _ErrorIdentificationState extends State<ErrorIdentification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Image.asset(
          'assets/nottylogo1.jpeg',
          height: 200,
          width: 200,
          color: Colors.white,
          colorBlendMode: BlendMode.darken,
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: widget.imageFile != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Text(
                      'Below is the picture you took:',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16.0),
                    width: 300,
                    height: 300,
                    child: Image.file(widget.imageFile!),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    child: Text(
                      'The error identified is:',
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
                        onPressed: () {
                          Navigator.pushNamed(context, '/submittedpage');
                        },
                        child: Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/homepage');
                        },
                        child: Text('No'),
                      ),
                    ],
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
    );
  }
}
