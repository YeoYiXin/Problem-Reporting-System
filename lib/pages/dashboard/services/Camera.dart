import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:problem_reporting_system/pages/ErrorIdentificationPage.dart';
import 'package:problem_reporting_system/pages/ImageClassificationAPI%20.dart';
import 'package:http_parser/http_parser.dart';

class Camera {
  File? imageFile;
  VoidCallback? onImageSelected;
  List<String> classificationResult = [];

  Future<void> onTapCameraButton(BuildContext context) async {
    await getImage(context: context, source: ImageSource.camera);
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
      // Convert File to MultipartFile
      http.MultipartFile image = await http.MultipartFile.fromPath(
        'file',
        imageFile!.path,
        contentType: new MediaType('image', 'jpeg'),
      );

      // Initialize the image classification API.
<<<<<<< Updated upstream
      ImageClassificationAPI api = ImageClassificationAPI(
        'http://192.168.56.1:5000',
      );
=======
      ImageClassificationAPI api =
          ImageClassificationAPI('http://192.168.0.109:5000');
>>>>>>> Stashed changes

      // Perform the image classification API call
      String result = await api.getClass(image);

      // Check if the result is "no_event"
      if (result == 'no_event') {
        // Set a default value or message
        result = 'Unrecognized Event';
      }

      // Assign the classification result
      classificationResult = [result];

      // Navigate to ErrorIdentification page with the result
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ErrorIdentification(
            imageFile: imageFile,
            classificationResult: classificationResult,
          ),
        ),
      );
    } catch (e) {
      print('Error processing image: $e');
      // Handle error (e.g., display an error message)
    }
  }
}
