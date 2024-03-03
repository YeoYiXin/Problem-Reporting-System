import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:problem_reporting_system/pages/ErrorIdentificationPage.dart';
import 'package:problem_reporting_system/pages/GeolocationService.dart';
import 'package:problem_reporting_system/pages/ImageClassificationAPI .dart';
import 'package:problem_reporting_system/pages/SecondPredictionPage.dart';
import 'package:problem_reporting_system/pages/outside.dart';
import 'package:problem_reporting_system/services/location.dart';
import 'package:problem_reporting_system/services/indoorCheck.dart';

class Camera {
  File? imageFile;
  VoidCallback? onImageSelected;
  List<String> firstPredictionResult = [];
  List<String> secondPredictionResult = [];
  List<String> thirdPredictionResult = [];
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

  LocationService locationService = LocationService();

  Future<void> _processImage(BuildContext context) async {
    try {
      // Show loading screen while processing
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoadingScreen(),
        ),
      );

      // Initialize the image classification API.

      ImageClassificationAPI api = ImageClassificationAPI(
        'http://192.168.166.114:5000',
      );

      // ImageClassificationAPI api =
      //     ImageClassificationAPI('https://apiold-vd42zjxz4a-as.a.run.app');

      // Perform the first image classification API call to get both class and subclass
      List<String> firstResults =
          await api.getClassAndSubclass(imageFile!.path);

      List<String> secondResults =
          await api.getClassAndSubclassSecond(imageFile!.path);

      List<String> thirdResults =
          await api.getClassAndSubclassThird(imageFile!.path);

      // Assigning  prediction results
      firstPredictionResult = firstResults;

      secondPredictionResult = secondResults;

      thirdPredictionResult = thirdResults;

      // Get user's location coordinates
      Position? userLocation = await geolocationService.getCurrentLocation();

      String locationInfo = userLocation != null
          ? locationService.isInsideArea(
              userLocation.latitude, userLocation.longitude)
          : 'Location information not available';

      if (locationInfo == "Outside Specified Areas") {
        print("Outside Specified Areas");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OutsideCampus()));
      }

      // Check if the user is in one of the indoor areas
      if (locationInfo.isNotEmpty) {
        // If the user is in an indoor area, prompt them to enter the room number
        IndoorCheck indoorCheck = IndoorCheck(locationService);
        indoorCheck.checkHouseName(
            context,
            '',
            userLocation!.latitude,
            userLocation.longitude,
            imageFile!,
            firstResults,
            secondResults,
            thirdResults,
            locationInfo);
      }
    } catch (e) {
      print('Error processing image: $e');
      // Handle error
    }
  }
}

// Loading Screen Widget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
