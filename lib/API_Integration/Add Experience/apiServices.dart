import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Apis/api.dart';

class AddExperienceService {
  final String url = '${ApiUrls.baseurl}/api/experiences/';

  Future<bool> addExperience(Map<String, dynamic> details) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? profileId = prefs.getInt('profileId');

      if (profileId == null) {
        print('Profile ID not found in SharedPreferences.');
        return false;
      }

      // Check for existing experience
      final existingDetails = await getExperienceDetailsFromServer(profileId);
      if (existingDetails.isNotEmpty) {
        // Assuming there's only one experience per profile
        final existingDetail = existingDetails.first;
        final int experienceId = int.parse(existingDetail['id']!);
        return await updateExperience(experienceId, details);
      } else {
        return await _addNewExperience(details);
      }
    } catch (e) {
      print('Error occurred while adding/updating experience details: $e');
      return false;
    }
  }

  Future<bool> _addNewExperience(Map<String, dynamic> details) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(details),
      );

      if (response.statusCode == 201) {
        await _storeExperienceDetailsLocally(details);
        return true;
      } else {
        print('Failed to add experience details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while adding experience details: $e');
      return false;
    }
  }

  Future<bool> updateExperience(int id, Map<String, dynamic> details) async {
    try {
      final response = await http.put(
        Uri.parse('$url$id/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(details),
      );

      if (response.statusCode == 200) {
        await _updateExperienceDetailsLocally(details);
        return true;
      } else {
        print('Failed to update experience details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while updating experience details: $e');
      return false;
    }
  }

  Future<void> _storeExperienceDetailsLocally(Map<String, dynamic> details) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingDetails = prefs.getStringList('experienceDetails') ?? [];
    existingDetails.add(jsonEncode(details));
    await prefs.setStringList('experienceDetails', existingDetails);
  }

  Future<void> _updateExperienceDetailsLocally(Map<String, dynamic> details) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingDetails = prefs.getStringList('experienceDetails') ?? [];

    // Find and update the existing detail in the local storage
    for (int i = 0; i < existingDetails.length; i++) {
      final Map<String, dynamic> existingDetail = jsonDecode(existingDetails[i]);
      if (existingDetail['profile'] == details['profile']) {
        existingDetails[i] = jsonEncode(details);
        break;
      }
    }
    await prefs.setStringList('experienceDetails', existingDetails);
  }

  Future<void> _storeExperienceDetailsListLocally(List<Map<String, String>> detailsList) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedDetailsList = detailsList.map((details) => jsonEncode(details)).toList();
    await prefs.setStringList('experienceDetails', encodedDetailsList);
  }

  Future<List<Map<String, String>>> getExperienceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final details = prefs.getStringList('experienceDetails');
    final int? profileId = prefs.getInt('profileId');

    if (details != null) {
      try {
        final decodedDetails = details.map((detail) {
          final Map<String, dynamic> decodedDetail = jsonDecode(detail);
          return decodedDetail.map((key, value) => MapEntry(key, value.toString()));
        }).toList();
        return _filterDetailsByProfileId(decodedDetails, profileId);
      } catch (e) {
        print('Error occurred while decoding experience details: $e');
        return [];
      }
    } else if (profileId != null) {
      final serverDetails = await getExperienceDetailsFromServer(profileId);
      if (serverDetails.isNotEmpty) {
        await _storeExperienceDetailsListLocally(serverDetails);
        return serverDetails;
      } else {
        return [];
      }
    } else {
      print('Profile ID not found in SharedPreferences.');
      return [];
    }
  }

  Future<List<Map<String, String>>> getExperienceDetailsFromServer(int profileId) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> detailsList = jsonDecode(response.body);

        final List<Map<String, String>> experienceDetailsList = detailsList.map((details) {
          final Map<String, String> experienceDetails = {};
          details.forEach((key, value) {
            experienceDetails[key] = value.toString();
          });
          return experienceDetails;
        }).toList();

        return _filterDetailsByProfileId(experienceDetailsList, profileId);
      } else {
        print('Failed to fetch experience details. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching experience details: $e');
      return [];
    }
  }

  List<Map<String, String>> _filterDetailsByProfileId(List<Map<String, String>> detailsList, int? profileId) {
    if (profileId == null) {
      print('Profile ID is null.');
      return [];
    }
    return detailsList.where((details) {
      final profile = details['profile'];
      final int profileIdFromDetails = profile != null ? int.tryParse(profile) ?? -1 : -1;
      return profileIdFromDetails == profileId;
    }).toList();
  }
}
