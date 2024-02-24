import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';

class ImageClassificationAPI {
  final String baseUrl;

  ImageClassificationAPI(this.baseUrl);

  // Method for first prediction
  Future<List<String>> getClassAndSubclass(String imagePath) async {
    try {
      String classResult = await _postImage(imagePath, 'get_class', null);
      String subclassResult =
          await _postImage(imagePath, 'get_subclass', classResult);
      return [classResult, subclassResult];
    } catch (e) {
      print('Error processing image: $e');
      throw Exception('Error processing image: $e');
    }
  }

  // Method for second prediction
  Future<List<String>> getClassAndSubclassSecond(String imagePath) async {
    try {
      String classResult =
          await _postImage(imagePath, 'get_class_second', null);
      String subclassResult =
          await _postImage(imagePath, 'get_subclass_second', classResult);
      return [classResult, subclassResult];
    } catch (e) {
      print('Error processing image: $e');
      throw Exception('Error processing image: $e');
    }
  }

  Future<String> _postImage(
      String imagePath, String endpoint, String? className) async {
    try {
      print('Sending image to $baseUrl/$endpoint');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/$endpoint'),
      );

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        imagePath,
        contentType: MediaType('image', 'jpeg'),
      ));

      // Include class name in the request if provided
      if (className != null) {
        request.fields['class_name'] = className;
      }

      var response = await request.send();

      print('Received response with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);
        print('Received data: $data');

        // Check for 'error' key or missing/null expected keys
        if (data.containsKey('error') && data['error'] != null) {
          throw Exception('API error: ${data['error']}');
        }

        String? result = data['predicted class'] as String? ??
            data['second highest class'] as String?;
        if (result == null) {
          throw Exception(
              'Failed to get class: Missing expected response data');
        }

        return result;
      } else {
        throw Exception('Failed to get class: ${response.statusCode}');
      }
    } catch (e) {
      print('Error processing image: $e');
      throw Exception('Error processing image: $e');
    }
  }
}
