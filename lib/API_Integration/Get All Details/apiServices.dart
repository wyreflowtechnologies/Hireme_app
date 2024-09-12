import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Apis/api.dart';

class ApiService {
  final String baseUrl = '${ApiUrls.baseurl}/api';

  Future<List<dynamic>> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      //print('Raw response body for $endpoint: ${response.body}');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<Map<String, dynamic>> getBasicDetails(String profileId) async {
    final data = await fetchData('$baseUrl/basic-details');
    print(_getProfileData(data, profileId, 'basic details'));
    return _getProfileData(data, profileId, 'basic details');
  }

  Future<Map<String, dynamic>> getProfileSummary(String profileId) async {
    final data = await fetchData('$baseUrl/profile-summaries');
    return _getProfileData(data, profileId, 'profile summary');
  }

  Future<List<dynamic>> fetchListData(String endpoint, String profileId) async {
    final data = await fetchData(endpoint);
    return _filterProfileData(data, profileId);
  }

  Future<List<dynamic>> getKeySkills(String profileId) => fetchListData('$baseUrl/key-skills', profileId);
  Future<List<dynamic>> getEducation(String profileId) => fetchListData('$baseUrl/education', profileId);
  Future<List<dynamic>> getExperience(String profileId) => fetchListData('$baseUrl/experiences', profileId);
  Future<List<dynamic>> getProjects(String profileId) => fetchListData('$baseUrl/projects', profileId);

  Future<Map<String, dynamic>> getPersonalDetails(String profileId) async {
    final data = await fetchData('$baseUrl/personal-details');
    return _getProfileData(data, profileId, 'personal details');
  }

  Future<Map<String, dynamic>> getPersonalLinks(String profileId) async {
    final data = await fetchData('$baseUrl/links');
    return _getProfileData(data, profileId, 'personal links');
  }

  Future<List<dynamic>> getLanguages(String profileId) => fetchListData('$baseUrl/languages', profileId);

  Future<Map<String, dynamic>> getResumeLink(String profileId) async {
    final data = await fetchData('$baseUrl/resumelink');
    return _getProfileData(data, profileId, 'resume link');
  }

  Map<String, dynamic> _getProfileData(List<dynamic> data, String profileId, String dataType) {
    final profileData = data.firstWhere(
          (item) => item['profile'].toString() == profileId,
      orElse: () => null,
    );
    if (profileData == null) {
      print('Profile not found for $dataType');
      return {'status': 'NA'};
    }
    return profileData as Map<String, dynamic>;
  }

  List<dynamic> _filterProfileData(List<dynamic> data, String profileId) {
    return data.where((item) => item['profile'].toString() == profileId).toList();
  }
}

void printProfileDetails(String profileId) async {
  final apiService = ApiService();

  try {
    final basicDetails = await apiService.getBasicDetails(profileId);
    final profileSummary = await apiService.getProfileSummary(profileId);
    final keySkills = await apiService.getKeySkills(profileId);
    final education = await apiService.getEducation(profileId);
    final experience = await apiService.getExperience(profileId);
    final projects = await apiService.getProjects(profileId);
    final personalDetails = await apiService.getPersonalDetails(profileId);
    final personalLinks = await apiService.getPersonalLinks(profileId);
    final languages = await apiService.getLanguages(profileId);
    final resumeLink = await apiService.getResumeLink(profileId);

    print('Basic Details: ${basicDetails.isNotEmpty ? basicDetails : 'NA'}');
    print('Profile Summary: ${profileSummary.isNotEmpty ? profileSummary : 'NA'}');
    print('Key Skills: ${keySkills.isNotEmpty ? keySkills : 'NA'}');
    print('Education: ${education.isNotEmpty ? education : 'NA'}');
    print('Experience: ${experience.isNotEmpty ? experience : 'NA'}');
    print('Projects: ${projects.isNotEmpty ? projects : 'NA'}');
    print('Personal Details: ${personalDetails.isNotEmpty ? personalDetails : 'NA'}');
    print('Personal Links: ${personalLinks.isNotEmpty ? personalLinks : 'NA'}');
    print('Languages: ${languages.isNotEmpty ? languages : 'NA'}');
    print('Resume Link: ${resumeLink.isNotEmpty ? resumeLink : 'NA'}');
  } catch (e) {
    print('Error fetching profile data: $e');
  }
}
