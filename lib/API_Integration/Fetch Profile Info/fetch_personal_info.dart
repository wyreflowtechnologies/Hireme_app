import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Apis/api.dart';

class FetchPersonalInfoService {
  final String baseUrl = '${ApiUrls.baseurl}/api'; // Replace with your API base URL

  Future<Map<String, String>> fetchPersonalInfo(int profileId) async {
    final response = await http.get(Uri.parse('$baseUrl/personal-details'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      var personalInfo = data.firstWhere((item) => item['profile'] == profileId, orElse: () => {});

      return personalInfo.isNotEmpty
          ? {
        'Gender': personalInfo['gender']?.toString() ?? 'Not available',
        'Marital Status': personalInfo['marital_status']?.toString() ?? 'Not available',
        'Date of Birth (DOB)': personalInfo['date_of_birth']?.toString() ?? 'Not available',
        'Current Address': personalInfo['current_address']?.toString() ?? 'Not available',
        'Permanent Address': personalInfo['permanent_address']?.toString() ?? 'Not available',
        'Career Break': personalInfo['career_break']?.toString() ?? 'Not available',
        'Differently Abled': personalInfo['differently_abled']?.toString() ?? 'Not available',
        'Native Language': personalInfo['native_language']?.toString() ?? 'Not available',
      }
          : {};
    } else {
      throw Exception('Failed to load personal information');
    }
  }
}
