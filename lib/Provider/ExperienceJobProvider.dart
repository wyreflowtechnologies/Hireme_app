import 'package:flutter/material.dart';
import 'package:hiremi_version_two/API_Integration/Internship/Apiservices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/api.dart';

class ExperiencedJobsProvider with ChangeNotifier {
  List<dynamic> _jobs = [];
  List<dynamic> _applications = [];
  int? userId;

  List<dynamic> get jobs => _jobs;
  List<dynamic> get applications => _applications;

  Future<void> ExfetchJobs() async {
    final apiService = ApiService('${ApiUrls.baseurl}/api/experiencejob/');
    _jobs = await apiService.fetchData();
    notifyListeners();
  }

  Future<void> ExfetchApplications() async {
    final apiService = ApiService('${ApiUrls.baseurl}/api/experience-job-applications/');
    _applications = await apiService.fetchData();
    notifyListeners();
  }

  Future<void> retrieveId() async {
    // Retrieve userId from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId');
    notifyListeners();
  }

  Set get appliedJobs {
    return _applications
        .where((application) => application['register'] == userId)
        .map((application) => application['experiencejob'])
        .toSet();
  }
}
