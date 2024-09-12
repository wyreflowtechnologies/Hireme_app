//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hiremi_version_two/Notofication_screen.dart';
// import 'package:hiremi_version_two/bottomnavigationbar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class VerifiedPage extends StatefulWidget {
//   const VerifiedPage({Key? key}) : super(key: key);
//
//   @override
//   State<VerifiedPage> createState() => _VerifiedPageState();
// }
//
// class _VerifiedPageState extends State<VerifiedPage> {
//   String email = " "; // Initial value for testing
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//     _printSavedEmail();
//   }
//
//   Future<void> _initializeNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher'); // Default icon
//
//     final InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   Future<void> _printSavedEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedEmail = prefs.getString('email') ?? 'No email saved';
//     setState(() {
//       email = savedEmail;
//     });
//     print(email);
//     _checkEmail();
//   }
//
//   Future<void> _checkEmail() async {
//     // Example URL for fetching user data by email
//     const String apiUrl = "http://13.127.81.177:8000/api/registers/";
//
//     try {
//       final response = await http.get(Uri.parse('$apiUrl?email=$email'));
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         // Update user verification based on fetched data
//         for (var user in data) {
//           if (user['email'] == email) {
//             await updateUserVerificationStatus(user['id']);
//             break;
//           }
//         }
//
//         if (data.isEmpty) {
//           print('No user found for email: $email');
//         }
//       } else {
//         print('Failed to fetch user data');
//         print('Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   Future<void> updateUserVerificationStatus(int userId) async {
//     // Example URL for updating user verification
//     final String updateUrl = "http://13.127.81.177:8000/api/registers/$userId/";
//
//     try {
//       final response = await http.patch(
//         Uri.parse(updateUrl),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           'verified': true,
//         }),
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('User verification updated successfully: $data');
//
//         if (data['verified'] == true) {
//           _showVerificationNotification();
//         }
//       } else {
//         print('Failed to update user verification');
//         print('Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   Future<void> _showVerificationNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'verification_channel',  // Channel ID
//       'Account Verification',  // Channel Name
//       channelDescription: 'Notification when user account is verified',  // Channel Description
//       importance: Importance.max,
//       playSound: true,
//       enableVibration: true,
//       priority: Priority.high,
//     );
//
//
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//
//     await flutterLocalNotificationsPlugin.show(
//       0, // Notification ID
//       'Account Verified', // Notification title
//       'Your account has been successfully verified!', // Notification body
//       platformChannelSpecifics,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Hiremi's Home",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (ctx) => const NotificationScreen()));
//             },
//             icon: const Icon(Icons.notifications),
//           )
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: screenHeight * 0.02,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'images/new_releases.png',
//                   width: screenWidth * 0.05,
//                   height: screenWidth * 0.05,
//                 ),
//                 Text(
//                   ' Payment Successful & Successfully Verified',
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: screenWidth * 0.037,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: screenHeight * 0.02,
//             ),
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   height: screenHeight * 0.45,
//                   child: Image.asset(
//                     'images/confetti bg.png',
//                     fit: BoxFit.cover,
//                     width: screenWidth,
//                   ),
//                 ),
//                 Positioned(
//                   top: screenHeight * 0.06,
//                   child: Image.asset(
//                     'images/Product quality-pana.png',
//                     width: screenWidth * 0.8,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: screenHeight * 0.02,
//             ),
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'images/new_releases.png',
//                       width: screenWidth * 0.05,
//                       height: screenWidth * 0.05,
//                     ),
//                     Text(
//                       ' Verified users can access jobs & internships at Hiremi.',
//                       style: TextStyle(fontSize: screenWidth * 0.025),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: screenHeight * 0.02,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('  '), // Placeholder for space
//                     Image.asset(
//                       'images/new_releases.png',
//                       width: screenWidth * 0.05,
//                       height: screenWidth * 0.05,
//                     ),
//                     Text(
//                       ' Verified users also get personalized career guidance.',
//                       style: TextStyle(fontSize: screenWidth * 0.025),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: screenHeight * 0.06,
//                 ),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     Navigator.pushAndRemoveUntil(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //           builder: (context) => const NewNavbar(isV: true)),
//                 //
//                 //     );
//                 //   },
//                 //   style: ButtonStyle(
//                 //     foregroundColor:
//                 //     WidgetStateProperty.all<Color>(Colors.white),
//                 //     backgroundColor:
//                 //     WidgetStateProperty.all<Color>(const Color(0xFFC1272D)),
//                 //     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                 //       RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(8.0),
//                 //       ),
//                 //     ),
//                 //   ),
//                 //   child: Text(
//                 //     'Continue Exploration >',
//                 //     style: TextStyle(fontSize: screenWidth * 0.025),
//                 //   ),
//                 // ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const NewNavbar(isV: true),
//                       ),
//                           (route) => false, // This will remove all previous routes
//                     );
//                   },
//                   style: ButtonStyle(
//                     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                     backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC1272D)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     'Continue Exploration >',
//                     style: TextStyle(fontSize: screenWidth * 0.025),
//                   ),
//                 ),
//
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Apis/api.dart';
class VerifiedPage extends StatefulWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  String email = " "; // Initial value for testing
  String UID="";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _printSavedEmail();
    _fetchVerificationUID();
  }
  Future<void> _fetchVerificationUID() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');

    if (savedId == null) {
      print("No id found in SharedPreferences");
      return;
    }

    const String verificationUrl = "${ApiUrls.baseurl}/api/verification-details/";

    try {
      final response = await http.get(Uri.parse(verificationUrl));

      if (!mounted) return; // Check if the widget is still mounted

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var item in data) {
          if (item['register'] == savedId) {
            final String uid = item['uid'];
            UID=uid;
            print('UID: $uid');

            // Save the UID in SharedPreferences
            await prefs.setString('uid', uid);

            if (!mounted) return; // Check again if the widget is still mounted

            // Show the dialog with the UID

            break;
          }
        }
      } else {
        print('Failed to fetch verification details');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  void showCustomSuccessDialog(BuildContext context, String uid) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var borderRadius = BorderRadius.circular(8);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                  width: screenWidth,
                  height: screenHeight,
                ),
              ),
              Center(
                child: Container(
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.only(
                              top: screenHeight * 0.04, bottom: screenHeight * 0.05),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            color: AppColors.green,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Image.asset('images/Group 33528.png'),
                                SizedBox(height: screenHeight * 0.02),
                                const Text(
                                  'Congratulations!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                          child: Column(
                            children: [
                              Text(
                                'Your App ID is $uid,',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              const Text(
                                'Additional benefits are unlocked,\n Independently Explore Hiremi.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: borderRadius,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Explore Hiremi',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher'); // Default icon

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tapped logic here
        if (response.payload != null) {
          debugPrint('notification payload: ${response.payload}');
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const NotificationScreen()));
        }
      },
    );
  }

  Future<void> _showVerificationNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'verification_channel', // Channel ID
      'Account Verification', // Channel Name
      channelDescription: 'Notification when user account is verified',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      //  playSound: true,
      enableLights: true,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Account Verified', // Notification title
      'Your account has been successfully verified!', // Notification body
      platformChannelSpecifics,
      payload: 'Account Verified',
    );
  }

  Future<void> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email') ?? 'No email saved';
    setState(() {
      email = savedEmail;
    });
    print(email);
    _checkEmail();
  }

  Future<void> _checkEmail() async {
    const String apiUrl = "${ApiUrls.baseurl}/api/registers/";

    try {
      final response = await http.get(Uri.parse('$apiUrl?email=$email'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var user in data) {
          if (user['email'] == email) {
            await updateUserVerificationStatus(user['id']);
            break;
          }
        }

        if (data.isEmpty) {
          print('No user found for email: $email');
        }
      } else {
        print('Failed to fetch user data');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateUserVerificationStatus(int userId) async {
    final String updateUrl = "${ApiUrls.baseurl}/api/registers/$userId/";

    try {
      final response = await http.patch(
        Uri.parse(updateUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'verified': true,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('User verification updated successfully: $data');

        if (data['verified'] == true) {
          _showVerificationNotification();
        }
      } else {
        print('Failed to update user verification');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        // This function is called when the back button is pressed
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NewNavbar(isV: true),
          ),
              (route) => false, // This will remove all previous routes
        );
        showCustomSuccessDialog(context, UID);
        // Return false to prevent the default back action
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hiremi's Home",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const NotificationScreen()));
              },
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/new_releases.png',
                    width: screenWidth * 0.05,
                    height: screenWidth * 0.05,
                  ),
                  Text(
                    ' Payment Successful & Successfully Verified',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: screenWidth * 0.037,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: screenHeight * 0.45,
                    child: Image.asset(
                      'images/confetti bg.png',
                      fit: BoxFit.cover,
                      width: screenWidth,
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.06,
                    child: Image.asset(
                      'images/Product quality-pana.png',
                      width: screenWidth * 0.8,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/new_releases.png',
                        width: screenWidth * 0.05,
                        height: screenWidth * 0.05,
                      ),
                      Text(
                        ' Verified users can access jobs & internships at Hiremi.',
                        style: TextStyle(fontSize: screenWidth * 0.025),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('  '), // Placeholder for space
                      Image.asset(
                        'images/new_releases.png',
                        width: screenWidth * 0.05,
                        height: screenWidth * 0.05,
                      ),
                      Text(
                        ' Verified users also get personalized career guidance.',
                        style: TextStyle(fontSize: screenWidth * 0.025),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewNavbar(isV: true),
                        ),
                            (route) => false, // This will remove all previous routes
                      );
                      showCustomSuccessDialog(context, UID);
      
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFC1272D)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Continue Exploration >',
                      style: TextStyle(fontSize: screenWidth * 0.025),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}