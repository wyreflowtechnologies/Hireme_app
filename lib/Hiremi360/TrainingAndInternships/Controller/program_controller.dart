// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/training_program.dart';
// import '../models/user_application.dart';
//
// class ProgramController {
//   Future<String> retrieveUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     final int? savedId = prefs.getInt('userId');
//     return savedId != null ? savedId.toString() : "";
//   }
//
//   Future<List<TrainingProgram>> fetchTrainingPrograms() async {
//     final response = await http.get(Uri.parse('http://13.127.246.196:8000/api/Training/'));
//     if (response.statusCode == 200) {
//       List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((data) => TrainingProgram.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load training programs');
//     }
//   }
//
//   Future<List<UserApplication>> fetchUserApplications() async {
//     final response = await http.get(Uri.parse('http://13.127.246.196:8000/api/training-applications/'));
//     if (response.statusCode == 200) {
//       List<dynamic> jsonData = json.decode(response.body);
//       return jsonData.map((data) => UserApplication.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load user applications');
//     }
//   }
// }
