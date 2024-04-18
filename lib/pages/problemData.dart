import 'package:cloud_firestore/cloud_firestore.dart';
//YYX
//map user data to json
class problemData {
  final String problemClass;
  final String pIndoorLocation;
  final Timestamp date;
  final String problemDepartment;
  final String problemDescription;
  final String problemId;
  final String problemImageURL;
  final String problemLocation;
  final String problemPriority;
  final int problemReportNum;
  final String problemStatus;
  final String problemSubClass;
  final String problemTitle;
  final String uid;
  final double latitude;
  final double longitude;

  problemData({
    required this.problemClass,
    required this.pIndoorLocation,
    required this.date,
    required this.problemDepartment,
    required this.problemDescription,
    required this.problemId,
    required this.problemImageURL,
    required this.problemLocation,
    required this.problemPriority,
    required this.problemReportNum,
    required this.problemStatus,
    required this.problemSubClass,
    required this.problemTitle,
    required this.uid,
    required this.latitude,
    required this.longitude,
  });

  //return user data as map
  Map<String, dynamic> toJSon() => {
        'problemClass': problemClass,
        'pIndoorLocation': pIndoorLocation,
        'date': date,
        'problemDepartment': problemDepartment,
        'problemDescription': problemDescription,
        'problemId': problemId,
        'problemImageURL': problemImageURL,
        'problemLocation': problemLocation,
        'problemPriority': problemPriority,
        'problemReportNum': problemReportNum,
        'problemStatus': problemStatus,
        'problemSubClass': problemSubClass,
        'problemTitle': problemTitle,
        'uid': uid,
        'latitude': latitude,
        'longitude': longitude,
      };
}
