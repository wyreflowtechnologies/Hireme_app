import 'dart:convert';
import 'package:hiremi_version_two/Models/VerifyModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/api.dart';


class VerifyController {

  Future<String?> getStoredEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }


  Future<Verifymodel?> fetchUserProfile(String profileId) async {
    try {
      // Make the API request directly with the profileId
      final response = await http.get(
        Uri.parse('http://13.127.246.196:8000/api/registers/$profileId'),
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a single profile object
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Convert the JSON data into the Verifymodel object
        return Verifymodel.fromJson(data);
      }
    } catch (e) {
      print('Error: $e'); // Handle any errors during the API call or parsing
    }

    return null; // Return null in case of an error or invalid response
  }



  Future<bool> updateUserProfile(Verifymodel verifyModel) async {
    try {
      final response = await http.patch(
        Uri.parse('${ApiUrls.baseurl}/api/registers/${verifyModel.id}/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(verifyModel.toJson()),
      );

      if (response.statusCode == 200) {
        print("response body is ${response.body}");
        print('Update successful');
        return true;
      } else {

        print('Update failed with status code: ${response.statusCode}');
        print('VerifyModel ID: ${verifyModel.id}');

        print('Response bodysdjhbdshb: ${response.body}');
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
    return false;
  }

}
