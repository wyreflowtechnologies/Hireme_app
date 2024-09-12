
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/ConformationAlertbox.dart';
import 'package:hiremi_version_two/Custom_Widget/Custom_alert_box.dart';
import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/BasicDetails/AddBasicDetails.dart';
import 'package:hiremi_version_two/Forget_Your_Password.dart';
import 'package:hiremi_version_two/Help_Support.dart';

import 'package:hiremi_version_two/Settings.dart';
import 'package:hiremi_version_two/about_us.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerChild extends StatefulWidget {
  final bool isVerified; // Changed dynamic to bool

  const DrawerChild({Key? key, required this.isVerified}) : super(key: key);

  @override
  State<DrawerChild> createState() => _DrawerChildState();
}

class _DrawerChildState extends State<DrawerChild> {
  String _fullName = "";
  String _storedNumber = '25';

  Future<void> _fetchFullName() async {
    final prefs = await SharedPreferences.getInstance();
    String? fullName = prefs.getString('full_name') ?? 'No name saved';
    setState(() {
      _fullName = fullName;
    });
  }
  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: const CustomAlertbox(),
        );
      },
    );

  }
  void _showConformationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: const ConformationAlertbox(),
        );
      },
    );
  }
  Future<void> _fetchStoredNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedNumber = prefs.getString('stored_number');
    setState(() {
      _storedNumber = storedNumber ?? '0';
    });

    print("stored number is $_storedNumber");
  }

  @override
  void initState() {
    super.initState();
    _fetchStoredNumber();
    if (_fullName.isEmpty) {
      _fetchFullName();
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.05),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircularPercentIndicator(
                    //   radius: screenWidth * 0.10,
                    //   lineWidth: 4,
                    //   percent: widget.isVerified ? 1 : double.tryParse(_storedNumber)! / 100,
                    //   center: Text(
                    //     '${(widget.isVerified ? 1 : double.tryParse(_storedNumber)! / 100) * 100}%',
                    //     style: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold),
                    //   ),
                    //   progressColor: Colors.green,
                    //   backgroundColor: Colors.transparent,
                    // ),
                    CircularPercentIndicator(
                      radius: screenWidth * 0.10,
                      lineWidth: 4,
                      percent: widget.isVerified ? 1 : (int.tryParse(_storedNumber) ?? 0) / 100,
                      center: Text(
                        '${(widget.isVerified ? 1 : (int.tryParse(_storedNumber) ?? 0) / 100) * 100}%',
                        style: TextStyle(fontSize: screenWidth * 0.03, fontWeight: FontWeight.bold),
                      ),
                      progressColor: Color(0xFF34AD78),
                      backgroundColor: Colors.transparent,
                    ),

                    SizedBox(height: screenHeight * 0.01),
                    Text(
                        _fullName.split(' ').first,
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Container(
                      height: screenHeight * 0.03,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.1),
                        border: Border.all(
                          color: widget.isVerified
                              ? Colors.green
                              : const Color(0xFFC1272D),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.01),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: widget.isVerified
                                  ? Colors.green
                                  : const Color(0xFFC1272D),
                              size: screenWidth * 0.02,
                            ),
                            Text(
                              widget.isVerified ? ' Verified' : ' Not verified',
                              style: TextStyle(
                                  color: widget.isVerified
                                      ?  const Color(0xFF34AD78)
                                      : const Color(0xFFC1272D),
                                  fontSize: screenWidth * 0.02),
                            ),
                          ],
                        ),
                      ),
                    ),


                    SizedBox(height: screenHeight * 0.01),
                    TextButton(
                      onPressed: () {
                        if (widget.isVerified) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const AddBasicDetails()));
                        } else {
                          _showVerificationDialog();
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFC1272D)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.02),
                          ),
                        ),
                      ),
                      child: Text(
                        'Edit Profile >',
                        style: TextStyle(fontSize: screenWidth * 0.02),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                  ],
                ),
              ),
              Container(
                width: screenWidth * 0.9,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(height: screenHeight * 0.04),
              InkWell(
                onTap: (){

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (ctx) =>  SettingsScreen()));

                  if (widget.isVerified) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const SettingsScreen()));
                  } else {
                    _showVerificationDialog();
                  }
                },
                child: ListTile(
                    leading: Container(
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBEEEE),
                        borderRadius: BorderRadius.circular(screenHeight * 0.01),
                      ),
                      child: const Icon(
                        Icons.settings,
                        color: Color(0xFFC1272D),
                      ),
                    ),
                    title: Text(
                      'Settings',
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          if (widget.isVerified) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const SettingsScreen()));
                          } else {
                            _showVerificationDialog();
                          }
                        },
                        icon: const Icon(Icons.navigate_next))),
              ),
              SizedBox(height: screenHeight * 0.005),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    SlidePageRoute(page: Forget_Your_Password()),
                  );
                },
                child: ListTile(
                    leading: Container(
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBEEEE),
                        borderRadius: BorderRadius.circular(screenHeight * 0.01),
                      ),
                      child: const Icon(
                        Icons.lock_open_outlined,
                        color: Color(0xFFC1272D),
                      ),
                    ),
                    title: Text(
                      'Change Password',
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            SlidePageRoute(page: Forget_Your_Password()),
                          );
                        },
                        icon: const Icon(Icons.navigate_next))),
              ),
              SizedBox(height: screenHeight * 0.005),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const About_Us()));
                },
                child: ListTile(
                    leading: Container(
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBEEEE),
                        borderRadius: BorderRadius.circular(screenHeight * 0.01),
                      ),
                      child: const Icon(
                        Icons.info,
                        color: Color(0xFFC1272D),
                      ),
                    ),
                    title: Text(
                      'About App',
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const About_Us()));
                        },
                        icon: const Icon(Icons.navigate_next))),
              ),
              SizedBox(height: screenHeight * 0.005),
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const HelpSupport()));
                },
                child: ListTile(
                    leading: Container(
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBEEEE),
                        borderRadius: BorderRadius.circular(screenHeight * 0.01),
                      ),
                      child: const Icon(
                        Icons.support_agent_outlined,
                        color: Color(0xFFC1272D),
                      ),
                    ),
                    title: Text(
                      'Help and Support',
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const HelpSupport()));
                        },
                        icon: const Icon(Icons.navigate_next))),
              ),
              SizedBox(
                height: screenHeight * 0.27,
              ),
              InkWell(
                onTap: ()async{
                  // final sharedPref = await SharedPreferences.getInstance();
                  // sharedPref.setBool(HiremiScreenState.KEYLOGIN, false);
                  // //  await sharedPref.clear(); // This will clear all the saved preferences
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(builder: (ctx) => const LogIn()),
                  //       (Route<dynamic> route) => false,
                  // );
                  _showConformationDialog();
                },
                child: ListTile(
                    leading: Container(
                      height: screenHeight * 0.04,
                      width: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBEEEE),
                        borderRadius: BorderRadius.circular(screenHeight * 0.01),
                      ),
                      child: const Icon(
                        Icons.support_agent_outlined,
                        color: Color(0xFFC1272D),
                      ),
                    ),
                    title: Text(
                      'Log out',
                      style: TextStyle(fontSize: screenWidth * 0.034),
                    ),
                    trailing: IconButton(
                        onPressed: () async {
                          // final sharedPref = await SharedPreferences.getInstance();
                          // sharedPref.setBool(HiremiScreenState.KEYLOGIN, false);
                          // //  await sharedPref.clear(); // This will clear all the saved preferences
                          // Navigator.of(context).pushAndRemoveUntil(
                          //   MaterialPageRoute(builder: (ctx) => const LogIn()),
                          //       (Route<dynamic> route) => false,
                          // );
                          _showConformationDialog();

                        },

                        icon: const Icon(Icons.navigate_next))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
