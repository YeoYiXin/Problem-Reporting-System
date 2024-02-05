import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:problem_reporting_system/pages/ErrorIdentificationPage.dart';
import 'package:problem_reporting_system/pages/GeolocationService.dart';
import 'package:problem_reporting_system/pages/ImageClassificationAPI%20.dart';
import 'package:http_parser/http_parser.dart';
import 'package:geolocator/geolocator.dart';

class Camera {
  File? imageFile;
  VoidCallback? onImageSelected;
  List<String> classificationResult = [];
  GeolocationService geolocationService = GeolocationService();

  Future<void> onTapCameraButton(BuildContext context) async {
    await getLocationAndImage(context: context, source: ImageSource.camera);
  }

  Future<void> getLocationAndImage(
      {required BuildContext context, required ImageSource source}) async {
    // Request location permissions
    bool isLocationPermissionGranted =
        await _requestLocationPermission(context);

    if (isLocationPermissionGranted) {
      // Get user's location coordinates
      Position? userLocation = await _getUserLocation();

      if (userLocation != null) {
        await getImage(context: context, source: source);
      } else {
        // Handle the case when location cannot be retrieved
        print('Error getting user location');
      }
    } else {
      // Handle the case when location permission is not granted
      print('Location permission not granted');
    }
  }

  Future<bool> _requestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      // Display a message to the user about the importance of location
      // or navigate to a settings page where they can manually enable location
      // You can customize this part based on your app's UX design.
      // For simplicity, we'll just print a message for demonstration purposes.
      print('Location permission required for this feature');
      return false;
    }
  }

  Future<Position?> _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      print('Error getting user location: $e');
      return null;
    }
  }

  Future<void> getImage(
      {required BuildContext context, required ImageSource source}) async {
    ImagePicker().pickImage(source: source).then((file) {
      if (file?.path != null) {
        imageFile = File(file!.path);
        onImageSelected?.call();
        _processImage(context);
      }
    });
  }

  Future<void> _processImage(BuildContext context) async {
    try {
      // Show loading screen while processing
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        ),
      );
      // Convert File to MultipartFile
      http.MultipartFile image = await http.MultipartFile.fromPath(
        'file',
        imageFile!.path,
        contentType: new MediaType('image', 'jpeg'),
      );

      // Initialize the image classification API.
      ImageClassificationAPI api = ImageClassificationAPI(
        'http://172.18.130.249:5000',
      );

      // Perform the image classification API call
      String result = await api.getClass(image);

      // Check if the result is "no_event"
      if (result == 'no_event') {
        // Set a default value or message
        result = 'Unrecognized Event';
      }

      // Assign the classification result
      classificationResult = [result];

      // Get user's location coordinates
      Position? userLocation = await geolocationService.getCurrentLocation();

      String locationInfo = '';

      if (userLocation != null) {
        locationInfo =
            'Latitude: ${userLocation.latitude}, Longitude: ${userLocation.longitude}';
      } else {
        locationInfo = 'Location information not available';
      }

      // Navigate to ErrorIdentification page with the result and location information
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ErrorIdentification(
            imageFile: imageFile,
            classificationResult: classificationResult,
            locationInfo: locationInfo,
          ),
        ),
      );
    } catch (e) {
      print('Error processing image: $e');
      // Handle error (e.g., display an error message)
    }
  }
}

// Loading Screen Widget
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
