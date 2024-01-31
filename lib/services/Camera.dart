import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:problem_reporting_system/pages/resultDisplay.dart';
import 'package:problem_reporting_system/pages/ImageClassificationAPI%20.dart';
import 'package:http_parser/http_parser.dart';

class Camera {
  File? imageFile;
  VoidCallback? onImageSelected;

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

      // Initialize the image classification API
      ImageClassificationAPI api = ImageClassificationAPI(
        'http://localhost:5000',
      );

      // Perform the image classification API call
      String result = await api.getClass(image);

      // Navigate to ResultDisplay page with the result
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultDisplay(result: result),
        ),
      );
    } catch (e) {
      print('Error processing image: $e');
      // Handle error (e.g., display an error message)
    }
  }
}
