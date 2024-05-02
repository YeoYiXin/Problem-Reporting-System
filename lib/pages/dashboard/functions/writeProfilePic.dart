// Written by Grp B
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> updateUserData({
    required String userId,
    required Uint8List file,
  }) async {
    String resp = "Some Error Occurred";
    try {
      String imageURL = await uploadImageToStorage('profileImage', file);
      await _firestore.collection('users').doc(userId).update({
        'profilePicURL': imageURL,
      });
      resp = 'success';
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
