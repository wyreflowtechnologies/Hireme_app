import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Apis/api.dart';

class FetchPersonalLinksService {
  final String baseUrl = '${ApiUrls.baseurl}/api'; // Replace with your API base URL

  Future<Map<String, String>> fetchPersonalLinks(int profileId) async {
    final response = await http.get(Uri.parse('$baseUrl/links'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      var personalLinks = data.firstWhere((item) => item['profile'] == profileId, orElse: () => {});

      return personalLinks.isNotEmpty
          ? {
        'linkedin_url': personalLinks['linkedin_url']?.toString() ?? 'Not available',
        'github_url': personalLinks['github_url']?.toString() ?? 'Not available',
      }
          : {
        'linkedin_url': 'Not available',
        'github_url': 'Not available',
      };
    } else {
      throw Exception('Failed to load personal links');
    }
  }
}
