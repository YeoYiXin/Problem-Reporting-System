//contain problem reporting system database
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:problem_reporting_system/pages/dashboard/functions/writePoints.dart';
import 'package:problem_reporting_system/pages/problemData.dart';
import 'package:intl/intl.dart';
import 'package:problem_reporting_system/pages/problemDescAPI.dart';

class Problem_Submission_Database {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String currentDate = DateFormat('EEEE, d MMMM y').format(DateTime.now());

  Future<String> recordProblemSubmission({
    required String pIndoorLocation,
    required String titleClass,
    required String subClass,
    required String description,
    required String location,
    required File imageURL,
    required bool userTyped,
    required double latitude,
    required double longitude,
  }) async {
    //check if problem class is no_event - if yes, then problem not sumitted
    if (titleClass.toLowerCase() == "no event") {
      //return no problem
      print(titleClass);
      return "No Problem Submitted";
    } else {
      try {
        print("entered recordProblemSubmission");
        //check if it is the same problem
        Future<String> resp = submitProblem(
            indoorLocation: pIndoorLocation,
            titleClass: titleClass,
            subClass: subClass,
            location: location,
            imageURL: imageURL,
            reportNum: 1,
            userTyped: userTyped,
            latitude: latitude,
            longitude: longitude);
        return resp;
      } catch (e) {
        print('An error occurred: $e');
        return "An error occurred";
      }
    }
  }

  Future<String> submitProblem({
    required String indoorLocation,
    required String titleClass,
    required String subClass,
    required String location,
    required File imageURL,
    required int reportNum,
    required bool userTyped,
    required double latitude,
    required double longitude,
  }) async {
    try {
      print("entered submitProblem");
      String uid = await getUserID();
      String problemId = await getProblemId();
      String priority = await getPriority(problemClass: titleClass);
      
      String title = "";
      if (userTyped){
        title= "$titleClass at $location, $indoorLocation";
      }else{
        title= "$subClass at $location, $indoorLocation";
      }
      String department = await getDepartment(
          titleClass: titleClass, subClass: subClass, location: location);

      print("Indoor Location: $indoorLocation");
      print("Problem ID: $problemId");
      print("Priority: $priority");
      print("Title: $title");
      //upload image to firebase storage
      String storageImageURL = await uploadImage(
          imageFile: imageURL, problemId: problemId, userTyped: userTyped);

      print("Storage Image URL: $storageImageURL");

      String description = "";
      description = await getDescription(storageImageURL, subClass);

      print("Description: $description");

      problemData ProblemData;

      if (userTyped) {
        ProblemData = problemData(
          problemClass: titleClass,
          pIndoorLocation: indoorLocation,
          date: Timestamp.now(),
          problemDepartment: department,
          problemDescription: description,
          problemId: problemId,
          problemImageURL: storageImageURL,
          problemLocation: location,
          problemPriority: priority,
          problemReportNum: reportNum,
          problemStatus: "In Progress",
          problemSubClass: titleClass,
          problemTitle: title,
          uid: uid,
          latitude: latitude,
          longitude: longitude,
        );
      } else {
        ProblemData = problemData(
          problemClass: titleClass,
          pIndoorLocation: indoorLocation,
          date: Timestamp.now(),
          problemDepartment: department,
          problemDescription: description,
          problemId: problemId,
          problemImageURL: storageImageURL,
          problemLocation: location,
          problemPriority: priority,
          problemReportNum: reportNum,
          problemStatus: "In Progress",
          problemSubClass: subClass,
          problemTitle: title,
          uid: uid,
          latitude: latitude,
          longitude: longitude,
        );
      }

      await _firestore
          .collection('problemsRecord')
          .doc(problemId)
          .set(ProblemData.toJSon());
      print('Problem data added to firestore...');
      await recordIssueType(
          titleClass: titleClass, subClass: subClass, reportNum: reportNum);
      print('Issue type recorded...');
      WritePoint().writePoint(uid: uid);
      print('User points updated...');
      return "Submission done";
    } catch (e) {
      print('An error occurred: $e');
      return "An error occurred";
    }
  }

  Future<String> uploadImage(
      {required File imageFile,
      required String problemId,
      required bool userTyped}) async {
    try {
      //upload image to firebase storage

      if (userTyped) {
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('unseen')
            .child('$problemId.jpg'); // Change file extension if necessary
        await storageRef.putFile(imageFile);
        final String imageURL = await storageRef.getDownloadURL();
        return imageURL;
      } else {
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('submitted')
            .child('$problemId.jpg'); // Change file extension if necessary
        await storageRef.putFile(imageFile);
        final String imageURL = await storageRef.getDownloadURL();
        return imageURL;
      }

      // Get download URL of the uploaded image
    } catch (e) {
      print('An error occurred: $e');
      return "An error occurred";
    }
  }

  Future<String> getPriority({required String problemClass}) async {
    try {
      //get priority of problem class
      if (problemClass == "cracks") {
        return "High";
      } else if (problemClass == "dangerous animals") {
        return "High";
      } else if (problemClass == "garbage") {
        return "Medium";
      } else if (problemClass == "natural disaster") {
        return "High";
      } else if (problemClass == "road conditions") {
        return "Medium";
      } else {
        return "Low";
      }
    } catch (e) {
      print('An error occurred: $e');
      return "Low";
    }
  }

  Future<String> getProblemId() async {
    try {
      final response = await _firestore.collection('problemsRecord').get();
      if (response.docs.isNotEmpty) {
        print("response.docs. not empty");
        print(response.docs.length.toString());
        return "#WA-${response.docs.length + 1}";
      } else {
        print("response.docs. is not empty");
        return "#WA-1";
      }
    } catch (e) {
      print('An error occurred: $e');
      return "1";
    }
  }

  Future<String> detectSimilarProblem({
    required String problemClass,
    required String problemSubClass,
    required String problemLocation,
  }) async {
    bool isSimilar = false;
    var i = 0;
    try {
      final response = await _firestore.collection('problemsRecord').get();
      print("response.docs.length: ${response.docs.length}");
      if (response.docs.isNotEmpty) {
        for (; i < response.docs.length; i++) {
          if (response.docs[i]['problemClass'] == problemClass &&
              response.docs[i]['problemSubClass'] == problemSubClass &&
              response.docs[i]['problemLocation'] == problemLocation &&
              response.docs[i]['problemStatus'].toString().toLowerCase() ==
                  "in progress") {
            print("isSimilar: true");
            isSimilar = true;
            break;
          }
        }
        if (isSimilar) {
          return response.docs[i]['problemId'].toString();
        } else {
          return "0";
        }
      }
      return "0";
    } catch (e) {
      print('An error occurred: $e');
      return "0";
    }
  }

  Future<String> getUserID() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      // Handle the case where no user is signed in
      return "No user sign in"; // You might want to handle this differently based on your app's requirements
    }
  }

  Future<String> getImageURL({required String problemId}) async {
    try {
      final response = await _firestore
          .collection('problemsRecord')
          .where('problemId', isEqualTo: problemId)
          .get();
      if (response.docs.isNotEmpty) {
        return response.docs[0]['problemImageURL'];
      } else {
        return "No image found";
      }
    } catch (e) {
      print('An error occurred: $e');
      return "An error occurred";
    }
  }

  Future<void> recordIssueType({
    required String titleClass,
    required String subClass,
    required int reportNum,
  }) async {
    try {
      final response = await _firestore.collection('issues').get();
      if (response.docs.isNotEmpty) {
        for (var doc in response.docs) {
          if (doc['class'] == titleClass.toLowerCase()) {
            // Class exists
            int availableIndex = 1;
            bool subClassExist = false;

            // Check for existing subclasses and find the first available index
            while (doc['subclass$availableIndex'] != null) {
              if (doc['subclass$availableIndex'] == subClass.toLowerCase()) {
                subClassExist = true;
                break;
              }
              availableIndex++;
            }

            if (subClassExist) {
              // Subclass exists, update its report number
              await _firestore.collection('issues').doc(doc.id).update({
                'numReport$availableIndex':
                    doc['numReport$availableIndex'] + reportNum,
              });
              print("Report number updated for subclass $subClass");
            } else {
              // Subclass doesn't exist, add it with report number
              await _firestore.collection('issues').doc(doc.id).update({
                'subclass$availableIndex': subClass.toLowerCase(),
                'numReport$availableIndex': reportNum,
              });
              print(
                  "New subclass $subClass added with report number $reportNum");
            }
            return;
          }
        }
      }

      // If class doesn't exist, add it along with the subclass and report number
      await _firestore.collection('issues').add({
        'class': titleClass.toLowerCase(),
        'subclass1': titleClass.toLowerCase(),
        'numReport1': reportNum,
      });
      print(
          "New class $titleClass added with subclass $subClass and report number $reportNum");
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Future<String> getDepartment(
      {required String titleClass,
      required String subClass,
      required String location}) async {
    //if user type, then assign security department -- current plan
    // Mapping locations to departments
    Map<String, String> locationToDepartment = {
      "Block I1; Tioman Hall": "Accommodation Team",
      "Block I2; Langkawi Hall": "Accommodation Team",
      "Block I3; Redang Hall": "Accommodation Team",
      "Block I4; Pangkor Hall": "Accommodation Team",
      "Block I5; Kapas Hall": "Accommodation Team",
      "Block J1; Sipadan Hall": "Accommodation Team",
      "Block J2; Mabul Hall": "Accommodation Team",
      "Block J3; Lankayan Hall": "Accommodation Team",
      "Block J4; Rawa Hall": "Accommodation Team",
      "Block J5; Gemia Hall": "Accommodation Team",
      "Block J6; Perhentian Hall": "Accommodation Team",
    };
    // Check if the location matches any predefined location
    if (locationToDepartment.containsKey(location)) {
      return locationToDepartment[location]!;
    }
    if (titleClass.toLowerCase() == "electrical") {
      if (subClass.toLowerCase() == "air conditioner") {
        return "Air Conditioning Team";
      } else {
        return "Mechanical and Electrical Team";
      }
    } else if (titleClass.toLowerCase() == "furniture") {
      if (subClass.toLowerCase() == "cabinet") {
        return "Civil Team";
      } else {
        return "Furniture Team";
      }
    } else if (titleClass.toLowerCase() == "plumbing") {
      return "Plumbing Team";
    } else if (titleClass.toLowerCase() == "pests") {
      if (subClass.toLowerCase == "snake") {
        return "Security Department";
      } else {
        return "Cleaning Team";
      }
    } else if (titleClass.toLowerCase() == "outdoor") {
      if (subClass.toLowerCase() == "road damage") {
        return "Civil Team";
      } else {
        return "Landscape Team";
      }
    } else if (titleClass.toLowerCase() == "room damage") {
      return "Civil Team";
    } else {
      return "Security Department"; //for now
    }
  }
}
