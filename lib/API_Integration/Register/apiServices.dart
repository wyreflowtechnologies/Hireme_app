import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Apis/api.dart';
import '../createProfile.dart';

CreateProfile _apiService = CreateProfile();

class RegisterService {
  final String url = '${ApiUrls.baseurl}/api/registers/';

  Future<String?> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      var profile = {
        "register": responseData['id'].toString()
      };
      var profileId = await _apiService.createProfile(profile);
      print(profileId);
      return profileId;
    } else {
      return null;
    }
  }
}
