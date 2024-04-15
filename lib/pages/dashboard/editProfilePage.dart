import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'functions/writeProfilePic.dart';
import 'services/chooseProfilePic.dart';


class editProfilePage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> user;

  editProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  State<editProfilePage> createState() => editProfilePageState();
}

class editProfilePageState extends State<editProfilePage> {

  Uint8List? _image;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {
    if (_image != null) {
      String resp = await StoreData().updateUserData(userId: widget.user.id, file: _image!);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Profile picture saved!'),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('No image selected!'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Profile Picture'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: <Widget>[
                _image != null ?
                CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                )
                    : CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 64,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo
                      ,color: Colors.black,
                      size:40,
                    ),
                  ),
                  bottom: -10,
                  left: 80,
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: saveProfile, child: Text('Save Profile Picture!'))
          ],
        ),
      ),
    );
  }
}
