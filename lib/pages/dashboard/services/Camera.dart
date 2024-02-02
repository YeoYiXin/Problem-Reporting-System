import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/ErrorIdentificationPage.dart';

class Camera {
  File? imageFile;
  VoidCallback? onImageSelected;

  void onTapCameraButton(BuildContext context) {
    Future.delayed(Duration.zero, () {
      getImage(context: context, source: ImageSource.camera);
    });
  }

  void getImage({required BuildContext context, required ImageSource source}) {
    ImagePicker().pickImage(source: source).then((file) {
      if (file?.path != null) {
          imageFile = File(file!.path);
          onImageSelected?.call();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ErrorIdentification(imageFile: imageFile),
          ),
        );
      }
    });
  }
}