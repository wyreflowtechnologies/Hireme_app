// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/TrainingAndInternshipDescription.dart';
// import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/TrainingService.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class YourProgram extends StatefulWidget {
//   @override
//   State<YourProgram> createState() => _YourProgramState();
// }
//
// class _YourProgramState extends State<YourProgram> {
//   List<dynamic> trainingPrograms = [];
//   List<dynamic> userApplications = [];
//   bool isLoading = true;
//   String SavedId="";
//   String unique_Id="";
//   String userId = ""; // Replace with the actual user ID as needed
//   final TrainingService trainingService = TrainingService(); // Create an instance of the service
//   @override
//   void initState() {
//     super.initState();
//  // Call to fetch programs only if necessary
//     _retrieveIdAndFetchData();
//     _initializeData();
//
//   }
//
//   Future<void> _retrieveIdAndFetchData() async {
//     // Retrieve saved user ID from SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     final int? savedId = prefs.getInt('userId');
//
//     if (savedId != null) {
//       print("Retrieved ID is $savedId");
//
//       // Fetch data from the API
//       final url = Uri.parse('http://13.127.246.196:8000/api/training-applications/');
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         // Parse the response body
//         final List<dynamic> data = json.decode(response.body);
//
//         // Iterate through the data and check if 'register' matches 'SavedId'
//         for (var item in data) {
//           if (item['register'] == savedId) {
//             print('Match found! Unique ID is: ${item['unique_id']}');
//             unique_Id= item['unique_id'];
//             print(unique_Id);
//            // break; // Stop after finding the first match
//           }
//         }
//       } else {
//         print('Failed to load data from the API. Status code: ${response.statusCode}');
//       }
//     } else {
//       print("No ID found in SharedPreferences");
//     }
//   }
//   Future<void> _initializeData() async {
//     userId = await trainingService.retrieveId() ?? '';
//     userApplications = await trainingService.fetchUserApplications();
//     trainingPrograms = await trainingService.fetchTrainingPrograms();
//     setState(() {}); // Update the UI after fetching data
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     double screenWidth = MediaQuery.of(context).size.width;
//     List<Map<String, dynamic>> appliedPrograms = trainingService.getAppliedPrograms(userApplications, userId, trainingPrograms);
//
//     // Filter out the applied programs from the training programs
//     List<dynamic> availablePrograms = trainingPrograms.where((program) {
//       return !appliedPrograms.any((appliedProgram) => appliedProgram['id'] == program['id']);
//     }).toList();
//
//
//
//     return SingleChildScrollView(
//       child: Container(
//         color: const Color.fromARGB(255, 255, 245, 234),
//         padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
//         child: Column(
//           children: [
//             SizedBox(height: screenWidth * 0.045),
//             Text(
//               "Your Programs",
//               style: TextStyle(
//                 fontSize: screenWidth * 0.0525,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             if (appliedPrograms.isEmpty)
//               buildNonActiveProgramContainer(screenWidth)
//             else
//               ...appliedPrograms.map((program) => buildProgramCard(program, screenWidth)).toList(),
//
//             SizedBox(height: screenWidth * 0.045),
//
//
//             Column(
//
//               children: [
//                 Text(
//                   "Available Programs",
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.0525,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//                 // Adding a space or padding between the title and the programs
//                 SizedBox(height: 10),
//
//                 // Display available programs
//                 ...availablePrograms.map((program) => InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Trainingandinternshipdescription(program: program),
//                       ),
//                     );
//                   },
//                   child: buildAvailableProgramCard(program, screenWidth),
//                 )).toList(),
//               ],
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildProgramCard(Map<String, dynamic> program, double screenWidth) {
//     return Container(
//       height: screenWidth * 0.3255,
//       width: screenWidth * 0.97,
//       margin: EdgeInsets.all(screenWidth * 0.04),
//       padding: EdgeInsets.all(screenWidth * 0.005),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(screenWidth * 0.04),
//         gradient: const LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color(0xFF95152F),
//             Color(0xFFEFC59B),
//           ],
//         ),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(screenWidth * 0.035),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: screenWidth * 0.01),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   program['training_program'],
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.04,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.1),
//
//                 Text(
//                   "ActiveProg",
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.04,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenWidth * 0.013),
//
//             Text(
//               program['duration'],
//               style: TextStyle(
//                 fontSize: screenWidth * 0.03,
//                 color: Colors.grey[700],
//               ),
//             ),
//             SizedBox(height: screenWidth * 0.013),
//             Text(
//              "Enroll id is  $unique_Id",
//               style: TextStyle(
//                 fontSize: screenWidth * 0.05,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//
//             SizedBox(height: screenWidth * 0.023),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildAvailableProgramCard(Map<String, dynamic> program, double screenWidth) {
//     return Container(
//       height: screenWidth * 0.3255,
//       width: screenWidth * 0.97,
//       margin: EdgeInsets.all(screenWidth * 0.04),
//       padding: EdgeInsets.all(screenWidth * 0.005),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(screenWidth * 0.04),
//         gradient: const LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color(0xFF95152F),
//             Color(0xFFEFC59B),
//           ],
//         ),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(screenWidth * 0.035),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: screenWidth * 0.01),
//
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   program['training_program'],
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.04,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.1),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     gradient: const LinearGradient(
//                       begin: Alignment.topRight,
//                       end: Alignment.bottomLeft,
//                       colors: [
//                         Color(0xFFEFC59B),
//                         Color(0xFF95152F),
//
//                       ],
//                     ),
//                   ),
//                   padding: EdgeInsets.all(4.0), // Optional padding around CircleAvatar
//                   child: CircleAvatar(
//                     radius: screenWidth * 0.02, // Adjust the radius as needed
//                     backgroundColor: Colors.white, // Background color inside the gradient
//                   ),
//                 ),
//               ],
//             ),
//
//
//
//             SizedBox(height: screenWidth * 0.013),
//
//             Text(
//               program['duration'],
//               style: TextStyle(
//                 fontSize: screenWidth * 0.03,
//                 color: Colors.grey[700],
//               ),
//             ),
//             SizedBox(height: screenWidth * 0.013),
//
//             Row(
//               children: [
//                 Text(
//                   '₹ ${program['discounted_price']}',
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.043,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.01),
//
//                 Text(
//                   '₹ ${program['original_price']}',
//                   style: TextStyle(
//                     fontSize: screenWidth * 0.032,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey,
//                     decoration: TextDecoration.lineThrough,
//                     decorationColor: Colors.grey,
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.07),
//
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       width: 1,
//                       color: Color(0xFF95152F),
//                     ),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
//                   child: Text(
//                     '${program['discount_percentage']}% Off',
//                     style: const TextStyle(
//                       color: Color.fromRGBO(193, 39, 45, 1),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenWidth * 0.023),
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//
//   Widget buildNonActiveProgramContainer(double screenWidth) {
//     return Container(
//       width: screenWidth * 0.97,
//       margin: EdgeInsets.all(screenWidth * 0.04),
//       padding: EdgeInsets.all(screenWidth * 0.005), // Thickness of the border
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(screenWidth * 0.04), // Rounded corners
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color(0xFF95152F), // End color
//             Color(0xFFEFC59B),
//           ],
//         ),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(screenWidth * 0.04),
//         decoration: BoxDecoration(
//           color: Colors.white, // Keep the inner container color as white
//           borderRadius: BorderRadius.circular(screenWidth * 0.01),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Non active programs",
//               style: TextStyle(
//                 fontSize: screenWidth * 0.039,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromRGBO(193, 39, 45, 1),
//               ),
//             ),
//             SizedBox(height: screenWidth * 0.01),
//             Text(
//               "Please Enroll now to jumpstart Your journey.",
//               style: TextStyle(
//                 fontSize: screenWidth * 0.028,
//                 color: Color.fromRGBO(193, 39, 45, 1),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/TrainingAndInternshipDescription.dart';
import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/TrainingService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class YourProgram extends StatefulWidget {
  @override
  State<YourProgram> createState() => _YourProgramState();
}

class _YourProgramState extends State<YourProgram> {
  List<dynamic> trainingPrograms = [];
  List<dynamic> userApplications = [];
  bool isLoading = true;
  String SavedId="";
  String unique_Id="";
  Map<int, String> uniqueIdsMap  = {};
  String userId = ""; // Replace with the actual user ID as needed
  final TrainingService trainingService = TrainingService(); // Create an instance of the service
  @override
  void initState() {
    super.initState();
    // Call to fetch programs only if necessary
    _retrieveIdAndFetchData();
    _initializeData();

  }


  Future<void> _retrieveIdAndFetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');

    if (savedId != null) {
      print("Retrieved ID is $savedId");

      final url = Uri.parse('http://13.127.246.196:8000/api/training-applications/');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        for (var item in data) {
          if (item['register'] == savedId) { // Check if the register ID matches the saved user ID
            uniqueIdsMap[item['TrainingProgram']] = item['unique_id'];
          }
        }
      } else {
        print('Failed to load data from the API. Status code: ${response.statusCode}');
      }
    } else {
      print("No ID found in SharedPreferences");
    }
  }

  Future<void> _initializeData() async {
    userId = await trainingService.retrieveId() ?? '';
    userApplications = await trainingService.fetchUserApplications();
    trainingPrograms = await trainingService.fetchTrainingPrograms();
    setState(() {}); // Update the UI after fetching data
  }




  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    List<Map<String, dynamic>> appliedPrograms = trainingService.getAppliedPrograms(userApplications, userId, trainingPrograms);

// Filter out the applied programs from the training programs
    List<dynamic> availablePrograms = trainingPrograms.where((program) {
      return !appliedPrograms.any((appliedProgram) => appliedProgram['id'] == program['id']);
    }).toList();



    return SingleChildScrollView(
      child: Container(
        color: const Color.fromARGB(255, 255, 245, 234),
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenWidth * 0.045),
            Text(
              "Your Programs",
              style: TextStyle(
                fontSize: screenWidth * 0.0525,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (appliedPrograms.isEmpty)
              buildNonActiveProgramContainer(screenWidth)
            else
              ...appliedPrograms.map((program) {
                // Retrieve the relevant unique ID for this program
                String relevantUniqueId = uniqueIdsMap[program['id']] ?? "No enrollment ID available";
                print("Relevant id is $relevantUniqueId");

                print("Unique IDs Map: $uniqueIdsMap"); // Check what IDs are stored
                print("Current TrainingProgram ID: ${program['id']}"); // Check current program ID
                print("Relevant id is $relevantUniqueId");
                return buildProgramCard(program, screenWidth, relevantUniqueId);

              }).toList(),
            SizedBox(height: screenWidth * 0.045),


            Column(

              children: [
                Text(
                  "Available Programs",
                  style: TextStyle(
                    fontSize: screenWidth * 0.0525,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Adding a space or padding between the title and the programs
                SizedBox(height: 10),

                // Display available programs
                ...availablePrograms.map((program) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Trainingandinternshipdescription(program: program),
                      ),
                    );
                  },
                  child: buildAvailableProgramCard(program, screenWidth),
                )).toList(),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget buildProgramCard(Map<String, dynamic> program, double screenWidth, String uniqueId) {
    return Container(
      height: screenWidth * 0.3255,
      width: screenWidth * 0.97,
      margin: EdgeInsets.all(screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.005),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF95152F),
            Color(0xFFEFC59B),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  program['training_program'],
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: screenWidth * 0.1),
                Text(
                  "ActiveProg",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.013),
            Text(
              program['duration'],
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: screenWidth * 0.013),
            Text(
              "Enroll ID: $uniqueId",
              style: TextStyle(
                fontSize: screenWidth * 0.043,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenWidth * 0.023),
          ],
        ),
      ),
    );
  }

  Widget buildAvailableProgramCard(Map<String, dynamic> program, double screenWidth) {
    return Container(
      height: screenWidth * 0.3255,
      width: screenWidth * 0.97,
      margin: EdgeInsets.all(screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.005),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF95152F),
            Color(0xFFEFC59B),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.035),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenWidth * 0.01),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  program['training_program'],
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: screenWidth * 0.1),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFEFC59B),
                        Color(0xFF95152F),

                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(4.0), // Optional padding around CircleAvatar
                  child: CircleAvatar(
                    radius: screenWidth * 0.02, // Adjust the radius as needed
                    backgroundColor: Colors.white, // Background color inside the gradient
                  ),
                ),
              ],
            ),



            SizedBox(height: screenWidth * 0.013),

            Text(
              program['duration'],
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: screenWidth * 0.013),

            Row(
              children: [
                Text(
                  '₹ ${program['discounted_price']}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.043,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),

                Text(
                  '₹ ${program['original_price']}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.032,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                  ),
                ),
                SizedBox(width: screenWidth * 0.07),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Color(0xFF95152F),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  child: Text(
                    '${program['discount_percentage']}% Off',
                    style: const TextStyle(
                      color: Color.fromRGBO(193, 39, 45, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.023),
          ],
        ),
      ),
    );
  }





  Widget buildNonActiveProgramContainer(double screenWidth) {
    return Container(
      width: screenWidth * 0.97,
      margin: EdgeInsets.all(screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.005), // Thickness of the border
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.04), // Rounded corners
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF95152F), // End color
            Color(0xFFEFC59B),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white, // Keep the inner container color as white
          borderRadius: BorderRadius.circular(screenWidth * 0.01),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Non active programs",
              style: TextStyle(
                fontSize: screenWidth * 0.039,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(193, 39, 45, 1),
              ),
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              "Please Enroll now to jumpstart Your journey.",
              style: TextStyle(
                fontSize: screenWidth * 0.028,
                color: Color.fromRGBO(193, 39, 45, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

