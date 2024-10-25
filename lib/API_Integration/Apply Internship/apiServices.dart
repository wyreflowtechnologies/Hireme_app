import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../SuccesfullyAppliedalert.dart';

class ApiServices {
  static const String baseUrl = '${ApiUrls.baseurl}/api';

  static Future<void> applyForInternship(int internshipId, BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? profileId = prefs.getString('profileId');

    if (profileId == null) {
      throw Exception('Profile ID not found in shared preferences');
    }

    try {
      // Fetch the register value for the profileId
      final profileUrl = '$baseUrl/profiles/$profileId';
      final profileResponse = await http.get(Uri.parse(profileUrl));
      if (profileResponse.statusCode != 200) {
        throw Exception('Failed to load profile: ${profileResponse.body}');
      }
      final profileData = jsonDecode(profileResponse.body);
      final String registerValue = profileData['register'].toString();

      // Prepare the payload for the internship application
      final applicationData = {
        'candidate_status': 'Pending',
        'register': registerValue,
        'internship': internshipId.toString(),
      };

      // Post the application data
      final applicationUrl = '$baseUrl/internship-applications/';
      final response = await http.post(
        Uri.parse(applicationUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(applicationData),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to apply for internship: ${response.body}');
      }

      // Show the SuccessfullyAppliedAlert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SuccessfullyAppliedAlert(),
          );
        },
      );
    } catch (error) {
      print('Error in applyForInternship: $error');
      throw Exception('Failed to apply for internship: $error');
    }
  }
}
