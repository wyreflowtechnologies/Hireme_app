import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Apis/api.dart';

class AddProjectDetailsService {
  final String baseUrl = '${ApiUrls.baseurl}/api/projects/';

  // Method to add or update project details based on the presence of the profileId and detailId
  Future<bool> addOrUpdateProjectDetails(Map<String, String> details, int profileId) async {
    details['profile'] = profileId.toString(); // Ensure profileId is included
    final int? detailId = await _getDetailId(profileId);
    if (detailId != null) {
      return await updateProjectDetails(detailId, details);
    } else {
      return await addProjectDetails(details);
    }
  }

  // Method to add new project details
  Future<bool> addProjectDetails(Map<String, String> details) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(details),
      );

      if (response.statusCode == 201) {
        await _storeProjectDetailsLocally(details);
        return true;
      } else {
        print('Failed to add project details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while adding project details: $e');
      return false;
    }
  }

  // Method to update existing project details
  Future<bool> updateProjectDetails(int detailId, Map<String, String> details) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$detailId/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(details),
      );

      if (response.statusCode == 200) {
        await _storeProjectDetailsLocally(details);
        return true;
      } else {
        print('Failed to update project details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while updating project details: $e');
      return false;
    }
  }

  // Method to store project details locally in SharedPreferences
  Future<void> _storeProjectDetailsLocally(Map<String, String> details) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('projectDetails', jsonEncode(details));
  }

  // Method to get project details from either local storage or the server
  Future<Map<String, String>> getProjectDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final String? details = prefs.getString('projectDetails');
    final int? profileId = prefs.getInt('profileId');

    if (details != null) {
      return Map<String, String>.from(jsonDecode(details));
    } else if (profileId != null) {
      final serverDetails = await getProjectDetailsFromServer(profileId);
      if (serverDetails != null) {
        await _storeProjectDetailsLocally(serverDetails);
        return serverDetails;
      } else {
        return {};
      }
    } else {
      print('Profile ID not found in SharedPreferences.');
      return {};
    }
  }

  // Method to fetch project details from the server
  Future<Map<String, String>?> getProjectDetailsFromServer(int profileId) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> detailsList = jsonDecode(response.body);

        for (var details in detailsList) {
          final profile = details['profile'];
          final int profileIdFromDetails = profile is String
              ? int.tryParse(profile) ?? -1
              : profile is int
              ? profile
              : -1;

          if (profileIdFromDetails == profileId) {
            final Map<String, String> projectDetails = {};
            details.forEach((key, value) {
              projectDetails[key] = value.toString();
            });
            await _storeProjectDetailsLocally(projectDetails);
            return projectDetails;
          }
        }
        return null; // No matching profileId found
      } else {
        print('Failed to fetch project details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching project details: $e');
      return null;
    }
  }

  // Method to get the profile ID from local storage
  Future<int?> _getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('profileId');
  }

  // Method to get the detail ID from the server based on profile ID
  Future<int?> _getDetailId(int profileId) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> detailsList = jsonDecode(response.body);

        for (var details in detailsList) {
          final profile = details['profile'];
          final int profileIdFromDetails = profile is String
              ? int.tryParse(profile) ?? -1
              : profile is int
              ? profile
              : -1;

          if (profileIdFromDetails == profileId) {
            return details['id'];
          }
        }
        return null; // No matching profileId found
      } else {
        print('Failed to fetch project details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching project details: $e');
      return null;
    }
  }
}
