import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Apis/api.dart';

class FetchProjectsService {
  final String baseUrl = '${ApiUrls.baseurl}/api';

  Future<List<Map<String, String>>> fetchProjects(int profileId) async {
    final response = await http.get(Uri.parse('$baseUrl/projects'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<dynamic> filteredData = data.where((item) => item['profile'] == profileId).toList();

      return filteredData.map((item) => {
        'title': item['project_name'] as String,
        'duration': '2 Months',//item['duration'] as String,
        'description': item['description'] as String,
        'link': item['link'] as String,
      }).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
