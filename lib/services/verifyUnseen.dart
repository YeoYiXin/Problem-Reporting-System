import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

Future<bool> verifyUnseen(String url) async {
  try {
    final response = await http.post(
      Uri.parse('http://172.20.10.3:5000/verify_unseen'),
      body: {'url': url},
    );

    if (response.statusCode == 200) {
      // Convert the response body to bytes
      Uint8List bytes = response.bodyBytes;
      // Convert bytes to base64
      String base64Image = base64Encode(bytes);
      print('base64Image: $base64Image');
      // Call your API with the base64 encoded image
      final apiResponse = await http.post(
        Uri.parse('http://172.20.10.3:5000/verify_unseen'),
        body: {'url': base64Image},
      );

      // Try parsing the response body as JSON
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

  //   final response = await http.post(

  //     Uri.parse('http://192.168.166.114:5000/verify_unseen'),

  //     // Uri.parse('https://apiold-vd42zjxz4a-as.a.run.app/verify_unseen'),
  //     body: {'url': url},
  //   );

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return data['verified'] ?? true;
  //   } else {
  //     print('Server responded with status code ${response.statusCode}.');
  //     return false;
  //   }
  // } catch (e) {
  //   print('An error occurred: $e');
  //   return true;
  // }
}
