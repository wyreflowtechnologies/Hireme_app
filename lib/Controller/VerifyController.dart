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

  Future<Verifymodel?> fetchUserProfile(String storedEmail) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseurl}/api/registers/'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final userProfileData = data.firstWhere(
              (profile) => profile['email'] == storedEmail,
          orElse: () => null,
        );

        if (userProfileData != null) {
          return Verifymodel.fromJson(userProfileData);
        }
      }
    } catch (e) {
      print('Errorsdsd: $e');
    }
    return null;
  }

  // Future<bool> updateUserProfile(Verifymodel verifyModel) async {
  //   try {
  //     final response = await http.patch(
  //       Uri.parse('http://13.127.81.177:8000/api/registers/${verifyModel.id}/'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(verifyModel.toJson()),
  //     );
  //
  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  //   return false;
  // }
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
        print('Update successful');
        return true;
      } else {
        print('Update failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
    return false;
  }

}
