//contain problem reporting system database

import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:problem_reporting_system/pages/login/models/userData.dart';
import 'package:problem_reporting_system/pages/problemData.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

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
  }) async {
    //check if problem class is no_event - if yes, then problem not sumitted
    if (titleClass == "no event") {
      //return no problem
      print(titleClass);
      return "No Problem Submitted";
    } else {
      try {
        print("entered recordProblemSubmission");
        //check if it is the same problem
        String isSimilarID = await detectSimilarProblem(
            problemClass: titleClass,
            problemSubClass: subClass,
            problemLocation: location);
        // String reportNum = await detectSimilarProblem(problemClass: titleClass, problemSubClass:subClass, problemLocation: location);
        print("isSimilarID: $isSimilarID");

        if (isSimilarID == "0") {
          print("enter if isSimilarID == 0");
          Future<String> resp = submitProblem(
              indoorLocation: pIndoorLocation,
              titleClass: titleClass,
              subClass: subClass,
              location: location,
              imageURL: imageURL,
              reportNum: 1,
              userTyped: userTyped);
          return resp;
        } else {
          print("enter else isSimilarID != 0");
          print("isSimilarID: $isSimilarID");
          //create output - is this the data? - if yes - then return this problem has already been reported, increase report num, priority change if needed -
          //if no - then go back to submit

          return "This problem has already been reported";
        }
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
  }) async {
    try {
      print("entered submitProblem");
      String uid = await getUserID();
      String problemId = await getProblemId();
      String priority = await getPriority(problemClass: titleClass);
      String title = "$subClass at $location, $indoorLocation";

      print("Indoor Location: $indoorLocation");
      print("Problem ID: $problemId");
      print("Priority: $priority");
      print("Title: $title");
      //upload image to firebase storage
      String storageImageURL = await uploadImage(
          imageFile: imageURL, problemId: problemId, userTyped: userTyped);

      print("Storage Image URL: $storageImageURL");

      String description = "";
      description = await getDescription(storageImageURL);

      print("Description: $description");

      problemData ProblemData = problemData(
        problemClass: titleClass,
        pIndoorLocation: indoorLocation,
        date: currentDate,
        problemDepartment: "Department", //for now
        problemDescription: description,
        problemId: problemId,
        problemImageURL: storageImageURL,
        problemLocation: location,
        problemPriority: priority,
        problemReportNum: reportNum,
        problemStatus: "In Progress",
        problemSubClass: subClass,
        problemTitle: title, //for now
        uid: uid, //for now - put in user report
      );

      await _firestore
          .collection('problemsRecord')
          .doc(problemId)
          .set(ProblemData.toJSon());
      print('Problem data added to firestore...');
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
      print('Uploading image into storage...');
      print('Image file: $imageFile');
      
      if (userTyped) {
        print('User typed');
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('unseen')
            .child('$problemId.JPG'); // Change file extension if necessary
        await storageRef.putFile(imageFile as File);
        final String imageURL = storageRef.getDownloadURL().toString();
        return imageURL;
      } else {
        print('User did not type');
        final storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('submitted')
            .child('$problemId.jpg'); // Change file extension if necessary
        await storageRef.putFile(imageFile as File);
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
        return "high";
      } else if (problemClass == "dangerous animals") {
        return "high";
      } else if (problemClass == "garbage") {
        return "medium";
      } else if (problemClass == "natural disaster") {
        return "high";
      } else if (problemClass == "road conditions") {
        return "medium";
      } else {
        return "low";
      }
    } catch (e) {
      print('An error occurred: $e');
      return "low";
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
          print("i: $i");
          print("problemClass: ${response.docs[i]['problemClass']} ;;;;, $problemClass"); 
          print("problemSubClass: ${response.docs[i]['problemSubClass']} ;;;;, $problemSubClass");
          print("problemLocation: ${response.docs[i]['problemLocation']} ;;;;, $problemLocation ");
          print("problemStatus: ${response.docs[i]['problemStatus']}");
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
  // Future<String> recordIssueType({}) async{}

  // Future<String> assignDepartment({}) async{}
}
