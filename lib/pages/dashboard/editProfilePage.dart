import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'functions/getProfilePic.dart';
import 'functions/writeProfilePic.dart';
import 'services/chooseProfilePic.dart';


class editProfilePage extends StatefulWidget {
  const editProfilePage({super.key});

  @override
  State<editProfilePage> createState() => editProfilePageState();
}

class editProfilePageState extends State<editProfilePage> {

  User? currentUser;
  Uint8List? _image;
  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState((){});
    _image = img;
  }
  void saveProfile() async {
    if (_image != null) {
      String resp = await StoreData().updateUserData(userId: currentUser!.uid, file: _image!);
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
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
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
                GetProfilePic(uid: currentUser!.uid)
                   : CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 64,
                    child: Icon(
                      Icons.person_2_sharp,
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
