import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<bool> verifyUnseen(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Convert the response body to bytes
      Uint8List bytes = response.bodyBytes;
      // Convert bytes to base64
      String base64Image = base64Encode(bytes);
      print('base64Image: $base64Image');
      // Call API with the base64 encoded image
      final apiResponse = await http.post(
        Uri.parse('https://api-vd42zjxz4a-as.a.run.app/verify_unseen'),
        body: {'url': base64Image},
      );

      try {
        if (apiResponse.statusCode == 200) {
          final data = jsonDecode(apiResponse.body);
          return data['verified'] ?? true;
        } else {
          print('Server responded with status code ${apiResponse.statusCode}.');
          return false;
        }
      } catch (e) {
        print('An error occurred: $e');
        return true;
      }
    } else {
      print('Failed to download image: ${response.statusCode}');
      return true;
    }
  } catch (e) {
    print('An error occurred: $e');
    return true;
  }
}
