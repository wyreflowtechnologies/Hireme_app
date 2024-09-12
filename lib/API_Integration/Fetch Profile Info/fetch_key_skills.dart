import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Apis/api.dart';

class FetchKeySkillsService {
  final String url = '${ApiUrls.baseurl}/api/key-skills/';

  Future<List<String>> fetchKeySkills(int profileId) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> skillsList = json.decode(response.body);
      final keySkills = skillsList
          .where((skill) => skill['profile'] == profileId)
          .map<String>((skill) => skill['skill'] as String)
          .toList();
      print(keySkills);
      return keySkills;
    } else {
      print('Failed to fetch key skills: ${response.body}');
      return [];
    }
  }
}
