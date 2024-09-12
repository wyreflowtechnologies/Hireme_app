import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServiceforAuthenciation {
  // Your Django API base URL
  final String baseUrl = 'https://your-django-api.com';

  // Your API username and password
  final String username = 'your_username';
  final String password = 'your_password';

  // Method to make an API request
  Future<http.Response> makeRequest({
    required String endpoint,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    // Encode the username and password into a base64 string
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    // Set default headers
    Map<String, String> requestHeaders = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
    };

    // Merge with custom headers if provided
    if (headers != null) {
      requestHeaders.addAll(headers);
    }

    // Build the complete URL
    final String url = '$baseUrl$endpoint';

    // Choose the HTTP method
    http.Response response;
    switch (method.toUpperCase()) {
      case 'POST':
        response = await http.post(
          Uri.parse(url),
          headers: requestHeaders,
          body: jsonEncode(body),
        );
        break;
      case 'PUT':
        response = await http.put(
          Uri.parse(url),
          headers: requestHeaders,
          body: jsonEncode(body),
        );
        break;
      case 'DELETE':
        response = await http.delete(
          Uri.parse(url),
          headers: requestHeaders,
        );
        break;
      case 'GET':
      default:
        response = await http.get(
          Uri.parse(url),
          headers: requestHeaders,
        );
        break;
    }

    // Handle errors or return response
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('Failed to make $method request to $url: ${response.statusCode}');
    }
  }
}