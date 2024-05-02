// Written by Grp B
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<String> getDescription(String imageURL, String subclass) async {
  try {
    // Download the image
    final response = await http.get(Uri.parse(imageURL));

    if (response.statusCode == 200) {
      // Convert the response body to bytes
      Uint8List bytes = response.bodyBytes;

      // Convert bytes to base64
      String base64Image = base64Encode(bytes);
      // Call API with the base64 encoded image
      final apiResponse = await http.post(
        Uri.parse(
            'https://api-vd42zjxz4a-as.a.run.app/get_desc'), 
        body: {'url': base64Image, 'subclass': subclass},
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
