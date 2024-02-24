import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<String> getDescription(String imageURL) async {
  try {
    // Download the image
    // final response = await http.get(Uri.parse(imageURL));

    // if (response.statusCode == 200) {
    //   // Convert the response body to base64
    //   String base64Image = base64Encode(response.bodyBytes);
    //   print('base64Image: $base64Image');
    final response = await http.get(Uri.parse(imageURL));

    if (response.statusCode == 200) {
      // Convert the response body to bytes
      Uint8List bytes = response.bodyBytes;

      // Resize the image to 512x512
      List<int> compressedBytes = await FlutterImageCompress.compressWithList(
        bytes,
        minHeight: 512,
        minWidth: 512,
        quality: 100,
      );

      // Convert bytes to base64
      String base64Image = base64Encode(compressedBytes);
      print('base64Image: $base64Image');
      // Call your API with the base64 encoded image
      final apiResponse = await http.post(
        Uri.parse(
            'http://192.168.0.109:5000/get_desc'), // Change the URL accordingly
        body: {'url': base64Image},
      );

      if (apiResponse.statusCode == 200) {
        print('API Response Body: ${apiResponse.body}');

        // Try parsing the response body as JSON
        try {
          final data = jsonDecode(apiResponse.body);
          // Store the description from the response
          String description = data['description'];
          return description;
        } catch (e) {
          print('Failed to parse JSON: $e');
          return 'Failed to parse JSON: $e';
        }
        // final data = jsonDecode(response.body);

        // return data.toString();
        // if (data.containsKey('description')) {
        //   return data['description'].toString();
        // } else {
        //   return 'Description not found in response';
        // }
      } else {
        print('Server responded with status code ${apiResponse.statusCode}.');
        return 'Server responded with status code ${apiResponse.statusCode}.';
      }
    } else {
      return 'Failed to download image: ${response.statusCode}';
    }
  } catch (e) {
    print('An error occurred: $e');
    return 'An error occurred: $e';
  }
}
