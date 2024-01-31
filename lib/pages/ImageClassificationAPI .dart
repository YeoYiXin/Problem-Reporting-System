import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageClassificationAPI {
  final String baseUrl;

  ImageClassificationAPI(this.baseUrl);

  Future<String> _postImage(String endpoint, http.MultipartFile image) async {
    try {
      print('Sending image to $baseUrl/$endpoint');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/$endpoint'),
      );

      request.files.add(image);

      var response = await request.send();

      print(
          'Received response with status code: ${response.statusCode}'); // Print statement for debugging

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);
        print('Received data: $data'); // Print statement for debugging
        return data['predicted class'];
      } else {
        throw Exception('Failed to get class: ${response.statusCode}');
      }
    } catch (e) {
      print('Error processing image: $e'); // Print statement for debugging
      throw Exception('Error processing image: $e');
    }
  }

  Future<String> getClass(http.MultipartFile image) async {
    return _postImage('get_class', image);
  }

  Future<String> getSecondClass(http.MultipartFile image) async {
    return _postImage('get_class_second', image);
  }

  Future<String> getSubclass(String className, http.MultipartFile image) async {
    return _postImage('get_subclass', image);
  }

  Future<String> getSecondSubclass(
      String className, http.MultipartFile image) async {
    return _postImage('get_subclass_second', image);
  }
}
