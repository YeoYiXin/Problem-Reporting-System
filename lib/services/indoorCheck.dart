import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/ErrorIdentificationPage.dart';
import 'location.dart';
import 'dart:io';

class IndoorCheck {
  final LocationService locationService;
  IndoorCheck(this.locationService);

  final List<String> indoorAreas = [
    "Block A; Trent Building",
    "Block B and B1; Faculty of Science and Engineering",
    "Block C and C1; Faculty of Science and Engineering",
    "Block D; Faculty of Engineering",
    "Block E; Faculty of Arts and Social Sciences",
    "Block F1; Central Teaching 1",
    "Block F2; Information Services - IT Support",
    "Block F3; Central Teaching 2",
    "Block F4; Central Teaching 3",
    "Block G; Library",
    "Block H; Student Association",
    "Block I1; Tioman Hall",
    "Block I2; Langkawi Hall",
    "Block I3; Redang Hall",
    "Block I4; Pangkor Hall",
    "Block I5; Kapas Hall",
    "Block J1; Sipadan Hall",
    "Block J2; Mabul Hall",
    "Block J3; Lankayan Hall",
    "Block J4; Rawa Hall",
    "Block J5; Gemia Hall",
    "Block J6; Perhentian Hall",
    "Block SH 1; Nexus",
    "Block SH 2; Radius",
    "Block K; Sports Complex",
    "Block L1; Warden House",
    "Block L2; Warden House (Tioman Lodge)",
    "Block L3; Warden House (Langkawi Lodge)",
    "Block L4; HR Office (Redang Lodge)",
    "Block VH 1; Visitor House 1 (Pedu)",
    "Block VH 2; Visitor House 2 (Titiwangsa)",
    "Block VH 3; Visitor House 3 (Chini)",
    "Block VH 4; Visitor House 4 (Kenyir)",
    "Block M; Islamic Centre",
    "Block N; Engineering Research Building",
    "Engineering Mixing Lab",
    "Creche; Taska, Childcare Centre"
  ];

  void checkHouseName(
      BuildContext context,
      String value,
      double latitude,
      double longitude,
      File imageFile,
      List<String> firstPredictionResult,
      List<String> secondPredictionResult,
      String locationInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String roomNumber = ''; // Declare roomNumber variable
        return AlertDialog(
          title: Text('Enter Room Number'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Room Number',
            ),
            onChanged: (input) {
              roomNumber = input; // Update roomNumber with user input
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // Perform action when OK is pressed
                print('Room Number: $roomNumber'); // Example action
                Navigator.of(context).pop();
                // Pass the room number to the callback function
                _onRoomNumberEntered(
                    context,
                    roomNumber,
                    imageFile,
                    firstPredictionResult,
                    secondPredictionResult,
                    locationInfo);
              },
            ),
          ],
        );
      },
    );
  }

  // Callback function to handle the room number entered by the user
  void _onRoomNumberEntered(
      BuildContext context,
      String roomNumber,
      File imageFile,
      List<String> firstPredictionResult,
      List<String> secondPredictionResult,
      String locationInfo) {
    // Navigate to ErrorIdentification page and pass the room number
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ErrorIdentification(
          imageFile: imageFile,
          firstPredictionResult: firstPredictionResult,
          secondPredictionResult: secondPredictionResult,
          locationInfo: locationInfo,
          roomNumber: roomNumber,
        ),
      ),
    );
  }
}
