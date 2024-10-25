//
// import 'package:hiremi_version_two/api_services/base_services.dart';
// import 'package:http/http.dart';
//
//
//
//
//
// class UserService extends BaseService {
//
//   Future<Response> createPostApi( Map<String, dynamic> body,  String apiUrl)
//   async
//   {
//     final response = await postHttp( data: body,api: apiUrl);
//     print("Hello");
//     print(response.body);
//     print(response.statusCode);
//
//
//     return response;
//   }
//
//
//
// }
//
import 'package:hiremi_version_two/api_services/base_services.dart';
import 'package:http/http.dart';

class UserService extends BaseService {

  Future<Response> createPostApi(Map<String, dynamic> body, String apiUrl) async {
    try {
      // Perform the post request
      final response = await postHttp(data: body, api: apiUrl);

      // Log response details (consider using a logging package for production)
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }

      // Return the response for further processing
      return response;
    } catch (e) {
      // Handle exceptions and log them
      print('An error occurred: $e');
      // Optionally, you might want to return a default response or rethrow the exception
      rethrow; // Rethrow to allow handling at the call site if needed
    }
  }
}
