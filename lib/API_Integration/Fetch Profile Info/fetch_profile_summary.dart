import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Apis/api.dart';

class FetchProfileSummaryService {
  final String url = '${ApiUrls.baseurl}/api/profile-summaries/';

  Future<String?> fetchProfileSummary(String profileId) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> summaries = json.decode(response.body);
      final summary = summaries.firstWhere(
            (summary) => summary['profile'].toString() == profileId,
        orElse: () => null,
      );
      return summary?['summary'];
    } else {
      print('Failed to fetch profile summary: ${response.body}');
      return null;
    }
  }
}
