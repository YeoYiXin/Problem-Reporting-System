import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:problem_reporting_system/pages/ErrorIdentificationPage.dart';
import 'package:problem_reporting_system/pages/GeolocationService.dart';
import 'package:problem_reporting_system/pages/ImageClassificationAPI .dart';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';

class Camera {
  File? imageFile;
  VoidCallback? onImageSelected;
  List<String> firstPredictionResult = [];
  List<String> secondPredictionResult = [];
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

      // Initialize the image classification API.
      ImageClassificationAPI api =
          ImageClassificationAPI('http://172.20.10.3:5000');

      // Perform the first image classification API call to get both class and subclass
      List<String> firstResults =
          await api.getClassAndSubclass(imageFile!.path);

      List<String> secondResults =
          await api.getClassAndSubclassSecond(imageFile!.path);

      // Assigning first prediction results
      firstPredictionResult = firstResults;

      // Assigning first prediction results
      secondPredictionResult = secondResults;

      // Get user's location coordinates
      Position? userLocation = await geolocationService.getCurrentLocation();

      String locationInfo = userLocation != null
          ? 'Latitude: ${userLocation.latitude}, Longitude: ${userLocation.longitude}'
          : 'Location information not available';

      // Navigate to ErrorIdentification page with the result and location information
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ErrorIdentification(
            imageFile: imageFile,
            firstPredictionResult: firstPredictionResult,
            secondPredictionResult: secondPredictionResult,
            locationInfo: locationInfo,
          ),
        ),
      );
    } catch (e) {
      print('Error processing image: $e');
      // Handle error
    }
  }
}

// Loading Screen Widget
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
