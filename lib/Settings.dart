//
// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/About_us2.dart';
// import 'package:hiremi_version_two/Custom_Widget/Verifiedtrue.dart';
// import 'package:hiremi_version_two/Forget_Your_Password.dart';
// import 'package:hiremi_version_two/Help_Support.dart';
// import 'package:hiremi_version_two/Notofication_screen.dart';
// import 'package:hiremi_version_two/Utils/colors.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key, }) : super(key: key);
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     const Color customRed = Color(0xFFC1272D);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (ctx) => const NotificationScreen(),
//               ));
//             },
//             icon: const Icon(Icons.notifications_outlined),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // User info section
//               const VerifiedProfileWidget(
//                   name: 'Harsh Pawar', appId: 'HM 23458 73432'),
//               SizedBox(height: screenHeight * 0.02),
//               // Account section
//               const Text(
//                 'Account',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Container(
//                 width: screenWidth * 0.9,
//                 padding:  EdgeInsets.all(screenWidth*0.02),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(screenHeight*0.01),
//                 ),
//                 child: RawMaterialButton(
//                   onPressed: () {},
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.person_outline,
//                         color: AppColors.primary,
//                         size: screenHeight * 0.03,
//                       ),
//                       SizedBox(
//                         width: screenWidth * 0.03,
//                       ),
//                       Text(
//                         'Personal Information',
//                         style: TextStyle(fontSize: screenHeight * 0.02),
//                       ),
//                       const Spacer(),
//                       IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.arrow_forward_ios,
//                           size: screenHeight * 0.02,
//                         ),
//                         style: ButtonStyle(
//                             backgroundColor:
//                             WidgetStatePropertyAll(AppColors.bgBlue)),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.03,
//               ),
//               const Text(
//                 'Privacy & Security',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Container(
//                 width: screenWidth * 0.9,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(screenHeight*0.01),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(screenWidth * 0.04),
//                   child: Column(
//                     children: [
//                       // RawMaterialButton(
//                       //   onPressed: () {},
//                       //   child: Row(
//                       //     children: [
//                       //       Icon(
//                       //         Icons.folder_shared_rounded,
//                       //         color: AppColors.primary,
//                       //         size: screenHeight * 0.03,
//                       //       ),
//                       //       SizedBox(
//                       //         width: screenWidth * 0.03,
//                       //       ),
//                       //       // Text(
//                       //       //   'Manage Permission',
//                       //       //   style: TextStyle(fontSize: screenHeight * 0.02),
//                       //       // ),
//                       //       // const Spacer(),
//                       //       // IconButton(
//                       //       //   onPressed: () {},
//                       //       //   icon: Icon(
//                       //       //     Icons.arrow_forward_ios,
//                       //       //     size: screenHeight * 0.02,
//                       //       //   ),
//                       //       //   style: ButtonStyle(
//                       //       //       backgroundColor:
//                       //       //       WidgetStatePropertyAll(AppColors.bgBlue)),
//                       //       // )
//                       //     ],
//                       //   ),
//                       // ),
//                       RawMaterialButton(
//                         onPressed: () {},
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.lock_open_rounded,
//                               color: AppColors.primary,
//                               size: screenHeight * 0.03,
//                             ),
//                             SizedBox(
//                               width: screenWidth * 0.03,
//                             ),
//                             Text(
//                               'Change Password',
//                               style: TextStyle(fontSize: screenHeight * 0.02),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (ctx) => const Forget_Your_Password()));
//                               },
//                               icon: Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: screenHeight * 0.02,
//                               ),
//                               style: ButtonStyle(
//                                   backgroundColor:
//                                   WidgetStatePropertyAll(AppColors.bgBlue)),
//                             )
//                           ],
//                         ),
//                       ),
//                       RawMaterialButton(
//                         onPressed: () {},
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.notifications_outlined,
//                               color: AppColors.primary,
//                               size: screenHeight * 0.03,
//                             ),
//                             SizedBox(
//                               width: screenWidth * 0.03,
//                             ),
//                             Text(
//                               'Job ALert Notification',
//                               style: TextStyle(fontSize: screenHeight * 0.02),
//                             ),
//                             const Spacer(),
//                             Transform.scale(
//                               scale: 0.7,
//                               child: Switch(
//                                 value: false,
//                                 onChanged: (value) {},
//                                 activeColor: customRed,
//                                 activeTrackColor: Colors.grey[300],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RawMaterialButton(
//                         onPressed: () {},
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.lock_open_rounded,
//                               color: AppColors.primary,
//                               size: screenHeight * 0.03,
//                             ),
//                             SizedBox(
//                               width: screenWidth * 0.03,
//                             ),
//                             Text(
//                               'Terms and Condition',
//                               style: TextStyle(fontSize: screenHeight * 0.02),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               onPressed: () async {
//                                 final Uri url =
//                                 Uri.parse('http://www.hiremi.in/terms&condition.html');
//                                 if (!await launchUrl(url)) {
//                                 throw Exception('Could not launch $url');
//                                 }
//                               },
//                               icon: Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: screenHeight * 0.02,
//                               ),
//                               style: ButtonStyle(
//                                   backgroundColor:
//                                   WidgetStatePropertyAll(AppColors.bgBlue)),
//                             )
//                           ],
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.03,
//               ),
//               const Text(
//                 'About & More',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Container(
//                 width: screenWidth * 0.9,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(screenHeight*0.01),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(screenWidth*0.04),
//                   child: Column(
//                     children: [
//                       RawMaterialButton(
//                         onPressed: () {},
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.info,
//                               color: AppColors.primary,
//                               size: screenHeight * 0.03,
//                             ),
//                             SizedBox(
//                               width: screenWidth * 0.03,
//                             ),
//                             Text(
//                               'About Us',
//                               style: TextStyle(fontSize: screenHeight * 0.02),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (ctx) => const About_Us2()));
//                               },
//                               icon: Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: screenHeight * 0.02,
//                               ),
//                               style: ButtonStyle(
//                                   backgroundColor:
//                                   WidgetStatePropertyAll(AppColors.bgBlue)),
//                             )
//                           ],
//                         ),
//                       ),
//                       RawMaterialButton(
//                         onPressed: () {},
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.call,
//                               color: AppColors.primary,
//                               size: screenHeight * 0.03,
//                             ),
//                             SizedBox(
//                               width: screenWidth * 0.03,
//                             ),
//                             Text(
//                               'Help & Support',
//                               style: TextStyle(fontSize: screenHeight * 0.02),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (ctx) => const HelpSupport()));
//                               },
//                               icon: Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: screenHeight * 0.02,
//                               ),
//                               style: ButtonStyle(
//                                   backgroundColor:
//                                   WidgetStatePropertyAll(AppColors.bgBlue)),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/About_us2.dart';
import 'package:hiremi_version_two/Custom_Widget/Verifiedtrue.dart';
import 'package:hiremi_version_two/Forget_Your_Password.dart';
import 'package:hiremi_version_two/Help_Support.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/Profile_Screen.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:hiremi_version_two/Utils/colors.dart';

import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<Map<String, String?>> _getUserInfo() async {
    final fullName = await SharedPreferencesHelper.getFullName();
    final uid = await SharedPreferencesHelper.getUid();
    return {
      'fullName': fullName,
      'uid': uid,
    };
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    const Color customRed = Color(0xFFC1272D);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const NotificationScreen(),
              ));
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<Map<String, String?>>(
                future: _getUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data?['fullName'] == null) {
                    return Text('User information not available');
                  } else {
                    final fullName = snapshot.data?['fullName'];
                    final uid = snapshot.data?['uid'];
                    return VerifiedProfileWidget(
                      name:fullName?.split(' ').first ?? 'N/A',
                      //appId: uid ?? 'N/A',
                    );
                  }
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              // Account section
               Text(
                'Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                width: screenWidth * 0.9,
                padding: EdgeInsets.all(screenWidth * 0.02),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(screenHeight * 0.01),
                ),
                child: RawMaterialButton(
                  onPressed: () {

                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        color: AppColors.primary,
                        size: screenHeight * 0.03,
                      ),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>  ProfileScreen()));
                        },
                        child: Text(
                          'Personal Information',
                          style: TextStyle(fontSize: screenHeight * 0.02),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>  ProfileScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: screenHeight * 0.02,
                        ),
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(AppColors.bgBlue)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const Text(
                'Privacy & Security',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(screenHeight * 0.01),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_open_rounded,
                              color: AppColors.primary,
                              size: screenHeight * 0.03,
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const Forget_Your_Password()));
                              },
                              child: Text(
                                'Change Password',
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const Forget_Your_Password()));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: screenHeight * 0.02,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(AppColors.bgBlue)),
                            )
                          ],
                        ),
                      ),
                      // RawMaterialButton(
                      //   onPressed: () {},
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.notifications_outlined,
                      //         color: AppColors.primary,
                      //         size: screenHeight * 0.03,
                      //       ),
                      //       SizedBox(
                      //         width: screenWidth * 0.03,
                      //       ),
                      //       Text(
                      //         'Job Alert Notification',
                      //         style: TextStyle(fontSize: screenHeight * 0.02),
                      //       ),
                      //       const Spacer(),
                      //       Transform.scale(
                      //         scale: 0.7,
                      //         child: Switch(
                      //           value: false,
                      //           onChanged: (value) {},
                      //           activeColor: customRed,
                      //           activeTrackColor: Colors.grey[300],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      RawMaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.explore_outlined,
                              color: AppColors.primary,
                              size: screenHeight * 0.03,
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            InkWell(
                              onTap: ()async{
                                final Uri url =
                                Uri.parse('http://www.hiremi.in/terms&condition.html');
                                if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                                }
                              },
                              child: Text(
                                'Terms and Condition',
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () async {
                                final Uri url =
                                Uri.parse('http://www.hiremi.in/terms&condition.html');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: screenHeight * 0.02,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(AppColors.bgBlue)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const Text(
                'About & More',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(screenHeight * 0.01),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.import_contacts_sharp,
                              color: AppColors.primary,
                              size: screenHeight * 0.03,
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const About_Us2()));
                              },
                              child: Text(
                                'About Us',
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const About_Us2()));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: screenHeight * 0.02,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(AppColors.bgBlue)),
                            ),
                          ],
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.wifi_calling_3_sharp,
                              color: AppColors.primary,
                              size: screenHeight * 0.03,
                            ),
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const HelpSupport()));
                              },
                              child: Text(
                                'Help & Support',
                                style: TextStyle(fontSize: screenHeight * 0.02),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => const HelpSupport()));
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: screenHeight * 0.02,
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(AppColors.bgBlue)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
