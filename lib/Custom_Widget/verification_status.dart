import 'dart:convert';
import 'package:hiremi_version_two/Custom_Widget/Custom_alert_box.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/api.dart';

class VerificationStatus extends StatefulWidget {
  const VerificationStatus({Key? key, required this.percent}) : super(key: key);
  final double percent;

  @override
  State<VerificationStatus> createState() => _VerificationStatusState();
}

class _VerificationStatusState extends State<VerificationStatus> {

  String FullName="";
  String storedEmail="";
  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);

    fetchAndSaveFullName();
    _printSavedEmail();
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
  Future<void> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? 'No email saved';
    print(email);
    storedEmail=email;
  }
  Future<void> fetchAndSaveFullName() async {
    const String apiUrl = "${ApiUrls.baseurl}/api/registers/";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        storedEmail = prefs.getString('email') ?? 'No email saved';

        for (var user in data) {
          if (user['email'] == storedEmail) {
            setState(() {
              FullName = user['full_name'] ?? 'No name saved';
            });
            await prefs.setString('full_name', FullName);
            print('Full name saved: $FullName');
            break;
          }
        }

        if (FullName.isEmpty) {
          print('No matching email found');
        }
      } else {
        print('Failed to fetch full name');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    double percentage = widget.percent*100;
    print("percentage is $percentage");
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.95,
      height: screenHeight * 0.23, // Updated height based on screen height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            screenWidth * 0.03), // Adjusted based on screen width
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: screenWidth * 0.95,
              height:
                  screenHeight * 0.14, // Updated height based on screen height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    screenWidth * 0.02), // Adjusted based on screen width
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1659DC),
                    Color(0xFF6EA6FA),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    screenWidth * 0.04), // Adjusted based on screen width
                child: Row(
                  children: [
                    Container(
                      height: screenHeight *
                          0.1, // Updated height based on screen height
                      width: screenHeight *
                          0.1, // Updated width based on screen height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(screenHeight *
                            0.05), // Adjusted based on screen height
                      ),
                      child: CircularPercentIndicator(
                        radius: screenHeight *
                            0.05, // Adjusted based on screen height
                        lineWidth: screenHeight *
                            0.0075, // Adjusted based on screen height
                        percent: widget.percent,
                        center: Text(
                          '${(widget.percent * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: Color(0xFF34AD78),
                            fontWeight: FontWeight.bold,
                            fontSize: screenHeight *
                                0.02, // Adjusted based on screen height
                          ),
                        ),
                        progressColor: Color(0xFF34AD78),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width:
                          screenWidth * 0.03, // Adjusted based on screen width
                    ),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text to the start
                      children: [
                        Text(
                          'Complete & Verify Your Profile.',
                          style: TextStyle(
                            fontSize: screenWidth *
                                0.035, // Adjusted based on screen width
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight *
                              0.02, // Adjusted based on screen height
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  height: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  decoration: BoxDecoration(
                                    color: widget.percent>=0.25?Color(0xFF34AD78):Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth *
                                            0.035), // Adjusted based on screen width
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color:widget.percent>=0.250? Colors.white: const Color(0xFFC1272D),
                                    size: screenWidth *
                                        0.03, // Adjusted based on screen width
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.005, // Adjusted based on screen height
                                ),
                                Text(
                                  'Profile\nCreated',
                                  style: TextStyle(
                                    fontSize: screenWidth *
                                        0.01, // Adjusted based on screen width
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.05, // Adjusted based on screen width
                                  height: screenHeight *
                                      0.003, // Adjusted based on screen height
                                  color: widget.percent>=0.250? Color(0xFF34AD78):Colors.white,
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.02, // Adjusted based on screen height
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.05, // Adjusted based on screen width
                                  height: screenHeight *
                                      0.003, // Adjusted based on screen height
                                  color: widget.percent>=0.50? Color(0xFF34AD78):Colors.white,
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.02, // Adjusted based on screen height
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  height: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  decoration: BoxDecoration(
                                    color: widget.percent>=0.50? Color(0xFF34AD78):Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth *
                                            0.035), // Adjusted based on screen width
                                  ),
                                  child: Icon(
                                    Icons.call,
                                    color: widget.percent>=0.50? Colors.white: const Color(0xFFC1272D),
                                    size: screenWidth *
                                        0.03, // Adjusted based on screen width
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.005, // Adjusted based on screen height
                                ),
                                Text(
                                  'Contact\ninformation',
                                  style: TextStyle(
                                    fontSize: screenWidth *
                                        0.01, // Adjusted based on screen width
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.05, // Adjusted based on screen width
                                  height: screenHeight *
                                      0.003, // Adjusted based on screen height
                                  color: widget.percent>=0.50? Color(0xFF34AD78):Colors.white,
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.02, // Adjusted based on screen height
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.05, // Adjusted based on screen width
                                  height: screenHeight *
                                      0.003, // Adjusted based on screen height
                                  color:widget.percent>=0.75? Color(0xFF34AD78):Colors.white,
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.02, // Adjusted based on screen height
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  height: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  decoration: BoxDecoration(
                                    color: widget.percent>=0.75?Color(0xFF34AD78):Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth *
                                            0.035), // Adjusted based on screen width
                                  ),
                                  child: Icon(
                                    Icons.school,
                                    color: widget.percent>=0.75? Colors.white: const Color(0xFFC1272D),
                                    size: screenWidth *
                                        0.03, // Adjusted based on screen width
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.005, // Adjusted based on screen height
                                ),
                                Text(
                                  'Education\nInformation',
                                  style: TextStyle(
                                    fontSize: screenWidth *
                                        0.01, // Adjusted based on screen width
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.05, // Adjusted based on screen width
                                  height: screenHeight *
                                      0.003, // Adjusted based on screen height
                                  color: widget.percent>=0.75? Color(0xFF34AD78):Colors.white,
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.02, // Adjusted based on screen height
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.05, // Adjusted based on screen width
                                  height: screenHeight *
                                      0.003, // Adjusted based on screen height
                                  color:widget.percent>=1? Color(0xFF34AD78):Colors.white,
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.02, // Adjusted based on screen height
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  height: screenWidth *
                                      0.07, // Adjusted based on screen width
                                  decoration: BoxDecoration(
                                    color: widget.percent>=1? Color(0xFF34AD78):Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        screenWidth *
                                            0.035), // Adjusted based on screen width
                                  ),
                                  child: Icon(
                                    Icons.account_balance,
                                    color: widget.percent>=1? Colors.white: const Color(0xFFC1272D),
                                    size: screenWidth *
                                        0.03, // Adjusted based on screen width
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight *
                                      0.005, // Adjusted based on screen height
                                ),
                                Text(
                                  'Verification\nPayment',
                                  style: TextStyle(
                                    fontSize: screenWidth *
                                        0.01, // Adjusted based on screen width
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.02, // Adjusted based on screen height
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.04), // Adjusted based on screen width
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Row(
                      children: [
                        Text(
                          FullName.split(' ').first,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth *
                                0.04, // Adjusted based on screen width
                          ),
                        ),
                        SizedBox(
                          width: screenWidth *
                              0.02, // Adjusted based on screen width
                        ),
                        Container(
                          // height: screenHeight * 0.03,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.1),
                            border: Border.all(color: const Color(0xFFC1272D)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.01),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: const Color(0xFFC1272D),
                                  size: screenWidth * 0.02,
                                ),
                                Text(
                                  ' Not verified',
                                  style: TextStyle(
                                    color: const Color(0xFFC1272D),
                                    fontSize: screenWidth *
                                        0.02, // Adjusted based on screen width
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.fingerprint,
                          color: const Color(0xFFC1272D),
                          size: screenWidth *
                              0.02, // Adjusted based on screen width
                        ),
                        Text(
                          'App ID: ',
                          style: TextStyle(
                            color: const Color(0xFFC1272D),
                            fontSize: screenWidth *
                                0.02, // Adjusted based on screen width
                          ),
                        ),
                        Text(
                          '-- -- -- --',
                          style: TextStyle(
                            fontSize: screenWidth *
                                0.02, // Adjusted based on screen width
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right:
                        screenWidth * 0.04), // Adjusted based on screen width
                child: Center(
                  child: Container(
                    height: screenHeight * 0.035,
                    // Adjusted based on screen height

                    decoration: BoxDecoration(
                      color:Color(0xFF34AD78),
                      borderRadius: BorderRadius.circular(
                          screenWidth * 0.02), // Adjusted based on screen width
                    ),
                    child: TextButton(
                      onPressed: () {
                        _showVerificationDialog();
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            'images/new_releases (1).png',
                            height: MediaQuery.of(context).size.width * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: screenWidth *
                                0.01, // Adjusted based on screen width
                          ),
                          Text(
                            'Verify Now >',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth *
                                  0.02, // Adjusted based on screen width
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
