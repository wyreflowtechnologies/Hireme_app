import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Apis/api.dart';

class AddKeySkillsService {
  final String url = '${ApiUrls.baseurl}/api/key-skills/';

  Future<bool> addOrUpdateKeySkills(Map<String, String> details) async {
    final int? profileId = await _getProfileId();
    if (profileId != null) {
      final int? skillId = await _getSkillId(profileId);
      if (skillId != null) {
        return await updateKeySkills(skillId, details);
      } else {
        return await addKeySkills(details);
      }
    } else {
      print('Profile ID not found in SharedPreferences.');
      return false;
    }
  }

  Future<bool> addKeySkills(Map<String, String> details) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(details),
      );

      if (response.statusCode == 201) {
        await _storeKeySkillsLocally(details['skill']!);
        return true;
      } else {
        print('Failed to add key skills. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while adding key skills: $e');
      return false;
    }
  }

  Future<bool> updateKeySkills(int skillId, Map<String, String> details) async {
    try {
      final response = await http.put(
        Uri.parse('$url$skillId/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(details),
      );

      if (response.statusCode == 200) {
        await _storeKeySkillsLocally(details['skill']!);
        return true;
      } else {
        print('Failed to update key skills. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while updating key skills: $e');
      return false;
    }
  }

  Future<void> _storeKeySkillsLocally(String skills) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('keySkills', skills);
  }

  Future<List<String>> getKeySkills() async {
    final prefs = await SharedPreferences.getInstance();
    final String? skills = prefs.getString('keySkills');
    final int? profileId = prefs.getInt('profileId');

    if (skills != null) {
      return skills.split(',').map((skill) => skill.trim()).toList();
    } else if (profileId != null) {
      final serverSkills = await getKeySkillsFromServer(profileId);
      if (serverSkills.isNotEmpty) {
        await _storeKeySkillsLocally(serverSkills.join(', '));
        return serverSkills;
      } else {
        return [];
      }
    } else {
      print('Profile ID not found in SharedPreferences.');
      return [];
    }
  }

  Future<List<String>> getKeySkillsFromServer(int profileId) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> skillsList = jsonDecode(response.body);

        final List<String> skills = skillsList
            .where((skill) {
          final Map<String, dynamic> skillDetails = skill as Map<String, dynamic>;
          final profile = skillDetails['profile'];
          final int profileIdFromDetails = profile is String
              ? int.tryParse(profile) ?? -1
              : profile is int
              ? profile
              : -1;
          return profileIdFromDetails == profileId;
        })
            .map((skillDetails) {
          return (skillDetails as Map<String, dynamic>)['skill'] as String? ?? '';
        })
            .toList();

        return skills;
      } else {
        print('Failed to fetch key skills. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching key skills: $e');
      return [];
    }
  }

  Future<int?> _getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('profileId');
  }

  Future<int?> _getSkillId(int profileId) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> skillsList = jsonDecode(response.body);

        for (var skill in skillsList) {
          final profile = skill['profile'];
          final int profileIdFromDetails = profile is String
              ? int.tryParse(profile) ?? -1
              : profile is int
              ? profile
              : -1;

          if (profileIdFromDetails == profileId) {
            return skill['id'];
          }
        }
        return null; // No matching profileId found
      } else {
        print('Failed to fetch key skills. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred while fetching key skills: $e');
      return null;
    }
  }
}
