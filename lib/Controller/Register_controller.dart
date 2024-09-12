// registration_controller.dart

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../Models/register_model.dart';
//
// class RegistrationController {
//   static const String _baseUrl = 'http://13.127.81.177:8000/api';
//
//   Future<bool> registerUser(User user, BuildContext context) async {
//     try {
//       var url = Uri.parse('$_baseUrl/registers/');
//       var response = await http.post(
//         url,
//         body: jsonEncode(user.toJson()),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 201) {
//         print(response.body);
//         print("${response.statusCode}");
//         return true; // Registration successful
//       } else {
//         String? errorMessage;
//         // Extract the error message if present
//         try {
//           final responseBody = jsonDecode(response.body);
//           print("responseBody is $responseBody");
//           errorMessage = responseBody['error'] ?? responseBody['message'] ?? 'Registration failed. Please try again.';
//         } catch (_) {
//           errorMessage = 'Registration failed. Please try again.';
//         }
//
//         print('Error hai bro : $errorMessage');
//
//         // Show SnackBar with the error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage!),
//             duration: const Duration(seconds: 3),
//           ),
//         );
//
//         return false; // Registration failed
//       }
//     } catch (e) {
//       // Handle network or server errors
//       print('Error sending request: $e');
//
//       return false; // Registration failed
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
import 'package:hiremi_version_two/Login.dart';
import 'package:http/http.dart' as http;
import '../Apis/api.dart';
import '../Models/register_model.dart';

class RegistrationController {
  static  String _baseUrl = '${ApiUrls.baseurl}/api';

  Future<bool> registerUser(User user, BuildContext context) async {
    try {
      var url = Uri.parse('$_baseUrl/registers/');
      var response = await http.post(
        url,
        body: jsonEncode(user.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print("HEllo i am in registration");
        Navigator.pushReplacement(
          context,
          SlidePageRoute(page: const LogIn()),
        );
        return true; // Registration successful
      } else {
        print(response.statusCode);
        print(response.body);
        String errorMessage = 'Registration failed. Please try again.';

        try {
          final responseBody = jsonDecode(response.body);
          if (responseBody is Map<String, dynamic>) {
            // Handle the error field
            if (responseBody.containsKey('error')) {
              final errorString = responseBody['error'].toString();

              // Extract the string part manually
              final regex = RegExp(r"string='([^']+)'");
              final match = regex.firstMatch(errorString);
              if (match != null) {
                errorMessage = match.group(1) ?? errorMessage;
                print(errorString);
                print(errorMessage);
              }
            }
          }
        } catch (e) {
          print('Error parsing response: $e');
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 3),
          ),
        );

        return false; // Registration failed
      }
    }
    catch (e) {
      print('Error sending request: $e');
      return false; // Registration failed
    }
  }
}
