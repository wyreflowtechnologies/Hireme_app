import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Apis/api.dart';

class LinksApiService {
  final String baseUrl = '${ApiUrls.baseurl}/api/links/';

  Future<bool> addOrUpdateLinks(Map<String, String> links) async {
    final int? profileId = await _getProfileId();
    if (profileId != null) {
      final int? detailId = await _getLinksDetailId(profileId);
      if (detailId != null) {
        return await updateLinks(detailId, links);
      } else {
        return await addLinks(links);
      }
    } else {
      print('Profile ID not found in SharedPreferences.');
      return false;
    }
  }

  Future<bool> addLinks(Map<String, String> links) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(links),
      );

      if (response.statusCode == 201) {
        await _storeLinksLocally(links);
        return true;
      } else {
        print('Failed to add links. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while adding links: $e');
      return false;
    }
  }

  Future<bool> updateLinks(int detailId, Map<String, String> links) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$detailId/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(links),
      );

      if (response.statusCode == 200) {
        await _storeLinksLocally(links);
        return true;
      } else {
        print('Failed to update links. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error occurred while updating links: $e');
      return false;
    }
  }

  Future<void> _storeLinksLocally(Map<String, String> links) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('personalLinks', jsonEncode(links));
  }

  Future<Map<String, String>> getLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? details = prefs.getString('personalLinks');
    final int? profileId = prefs.getInt('profileId');

    if (details != null) {
      try {
        return Map<String, String>.from(jsonDecode(details));
      } catch (e) {
        print('Error occurred while decoding links details: $e');
        return {};
      }
    } else if (profileId != null) {
      final serverDetails = await getLinksFromServer(profileId);
      if (serverDetails.isNotEmpty) {
        await _storeLinksLocally(serverDetails);
        return serverDetails;
      } else {
        return {};
      }
    } else {
      print('Profile ID not found in SharedPreferences.');
      return {};
    }
  }

  Future<Map<String, String>> getLinksFromServer(int profileId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?profile_id=$profileId'));

      if (response.statusCode == 200) {
        final List<dynamic> linksList = jsonDecode(response.body);

        final List<Map<String, String>> links = linksList.map((link) {
          final Map<String, dynamic> decodedLink = link as Map<String, dynamic>;
          return decodedLink.map((key, value) => MapEntry(key, value.toString()));
        }).toList();

        final filteredLinks = _filterLinksByProfileId(links, profileId);
        return filteredLinks.isNotEmpty ? filteredLinks.first : {};
      } else {
        print('Failed to fetch links. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error occurred while fetching links: $e');
      return {};
    }
  }

  List<Map<String, String>> _filterLinksByProfileId(List<Map<String, String>> linksList, int profileId) {
    return linksList.where((links) {
      final profile = links['profile'];
      final int profileIdFromLinks = profile != null ? int.tryParse(profile) ?? -1 : -1;
      return profileIdFromLinks == profileId;
    }).toList();
  }

  Future<int?> _getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('profileId');
  }

  Future<int?> _getLinksDetailId(int profileId) async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> linksList = jsonDecode(response.body);

      for (var links in linksList) {
        final profile = links['profile'];
        final int profileIdFromLinks = profile is String
            ? int.tryParse(profile) ?? -1
            : profile is int
            ? profile
            : -1;

        if (profileIdFromLinks == profileId) {
          return links['id'];
        }
      }
      return null; // No matching profileId found
    } else {
      print('Failed to fetch links details. Status code: ${response.statusCode}');
      return null;
    }
  }
}
