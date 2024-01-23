import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API {
  static Future<Map<String, dynamic>> getClassification(File image) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/get_class'));
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } catch (e) {
      print('Error: $e');
      return {'error': 'Failed to get classification'};
    }
  }

  static Future<Map<String, dynamic>> getSubclassification(
      File image, String className) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:5000/get_class'));
    request.fields['class_name'] = className;
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      return json.decode(responseBody);
    } catch (e) {
      print('Error: $e');
      return {'error': 'Failed to get subclassification'};
    }
  }
}
