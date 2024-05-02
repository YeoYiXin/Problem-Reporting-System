// Written by Grp B
import 'package:cloud_firestore/cloud_firestore.dart';

class WritePoint {
  Future<void> writePoint({
    required String uid,
  }) async {
    final _firestore = FirebaseFirestore.instance;
    try {
      final documentSnapshot =
          await _firestore.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        final points = documentSnapshot.get('points') ?? 0;
        await _firestore
            .collection('users')
            .doc(uid)
            .update({'points': points + 1});
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
