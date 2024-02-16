import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> verifyUnseen(String url) async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/verify_unseen'),
      body: {'url': url},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['verified'] ?? false;
    } else {
      print('Server responded with status code ${response.statusCode}.');
      return false;
    }
  } catch (e) {
    print('An error occurred: $e');
    return true;
  }
}
