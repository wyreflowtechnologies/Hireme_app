import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Apis/api.dart';


class CreateProfile {
  final String url = '${ApiUrls.baseurl}/api/profiles/';

  Future<String?> createProfile(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return responseData['id'].toString();
    } else {
      return null;
    }
  }
}
