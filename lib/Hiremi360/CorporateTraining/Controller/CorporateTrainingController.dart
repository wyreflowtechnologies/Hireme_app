// controllers/mentorship_controller.dart
import 'dart:convert';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/Hiremi360/CorporateTraining/Model/CorporateTrainingModel.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/Model/MentorshipModel.dart';
import 'package:http/http.dart' as http;


class CorporateTrainingController {
  final String apiUrl = '${ApiUrls.baseurl}/api/corporatetraining/';

  Future<void> EnrollInCorporateTraining(CorporateTrainingModel corporateTrainingData) async {
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(corporateTrainingData.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print("corporateTraining data successfully posted");
      } else {
        print("Failed to post corporateTraining data, status code: ${response.statusCode}");
        print("${response.body}");
      }
    } catch (e) {
      print("Error posting corporateTraining data: $e");
    }
  }
}
