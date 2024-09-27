import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
import 'package:hiremi_version_two/Models/register_model.dart';
import 'package:hiremi_version_two/verification_screens/verifiaction_screen2.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Apis/api.dart';

class VerificationScreen1 extends StatefulWidget {
  const VerificationScreen1({Key? key}) : super(key: key);

  @override
  State<VerificationScreen1> createState() => _VerificationScreen1State();
}

class _VerificationScreen1State extends State<VerificationScreen1> {
final _formKey = GlobalKey<FormState>();
  Gender? _selectedGender = Gender.Male;
  String? _selectedState;
  DateTime? _selectedDate;
String _userId="";
String _fullName="";

  // List<String> _states = ['State 1', 'State 2', 'State 3', 'State 4'];

  final List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Jammu and Kashmir',
    'Ladakh',
    'Lakshadweep',
    'Puducherry',
  ];

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _collegeNameController = TextEditingController();
  final TextEditingController _collegeStateController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _passingYearController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();


  void _handleGenderChange(Gender? value) {
    setState(() {
      _selectedGender = value;
    });
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _fullNameController.dispose();
    _fatherNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _birthPlaceController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _collegeNameController.dispose();
    _branchController.dispose();
    _degreeController.dispose();
    _passingYearController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
@override
void initState() {
  super.initState();
  _fetchUserData();
  if (_fullName.isEmpty) {
    _fetchFullName();
  }
}
Future<void> _fetchUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedEmail = prefs.getString('email');
  print("Stored Email: $storedEmail");

  if (storedEmail != null) {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseurl}/api/registers/'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('All user data: $data');

        final userData = data.firstWhere(
              (user) => user['email'] == storedEmail,
          orElse: () => null,
        );

        if (userData != null) {
          print('Matched user data: $userData');
          setState(() {
             _userId = userData['id'].toString();
             _phoneController.text=userData['phone_number'];
             _whatsappController.text=userData['whatsapp_number'];
          });
        } else {
          print('No user found with the stored email');
        }
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  } else {
    print('No email stored');
  }
}
Future<void> _updateStoredNumber() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('stored_number', '50'); // Set the new number here
}
Future<void> _fetchFullName() async {
  final prefs = await SharedPreferences.getInstance();
  String? fullName = prefs.getString('full_name') ?? 'No name saved';
  setState(() {
    _fullName = fullName;
  });
}

Future<void> _updateUserData() async {
  if (!_isAllFieldsValid()) return;

  try {
    final response = await http.patch(
      Uri.parse('${ApiUrls.baseurl}/api/registers/$_userId/'),

      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        // 'full_name': _fullNameController.text,
        // 'father_name': _fatherNameController.text,
        // 'email': _emailController.text,
        // 'date_of_birth': _dobController.text,
        // 'birth_place': _birthPlaceController.text,
        // 'gender': _selectedGender.toString().split('.').last,
        'phone_number':_phoneController.text,
        'whatsapp_number':_whatsappController.text,
        // Include other fields similarly
      }),
    );

    if (response.statusCode == 200) {
      print('User data updated successfully');
      _updateStoredNumber();
      Navigator.push(
        context,
        SlidePageRoute(page: VerificationScreen2()),
      );
    } else {
      print("$_userId");
      print('Failed to update user data: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error: $e');
  }
}

  bool _isAllFieldsValid() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    double imageSize = MediaQuery.of(context).size.width * 0.6;
    double imageHeight = MediaQuery.of(context).size.height * 0.157;
      print("Build");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Review & Verify Your Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircularPercentIndicator(
                    radius: screenHeight * 0.05,
                    lineWidth: 6,
                    percent: 0.25,
                    center: const Text(
                      '25%',
                      style: TextStyle(
                          color: Color(0xFF34AD78), fontWeight: FontWeight.bold),
                    ),
                    progressColor: Color(0xFF34AD78),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(height: screenHeight * 0.0075),
                   Text(
                    _fullName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.0075),
                  Container(
                    // height: screenHeight * 0.03,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.1),
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
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.0425),
            Container(
              height: 1,
              width: screenWidth * 0.9,
              color: Colors.grey,
            ),


            Form(
              key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.all(screenWidth*0.04),
                        child: const Text(
                          'Contact Information',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      buildLabeledTextField(
                        context,
                        "Phone Number",
                        "+91",
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a 10 digit phone number';
                          }
                          if (value.length > 10) {
                            return 'Please enter a 10 digit Phone number';
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Special characters are not allowed';
                          }
                          return null;
                        },
                      ),
                      buildLabeledTextField(
                        context,
                        "WhatsApp Number",
                        "+91",
                        keyboardType: TextInputType.phone,
                        controller: _whatsappController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your WhatsApp number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid WhatsApp number';
                          }
                          if (value.length > 10) {
                            return 'Please enter a valid WhatsApp number';
                          }

                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please enter a valid WhatsApp number without special characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFC1272D),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_isAllFieldsValid()) {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (ctx) => const VerificationScreen1()));
                                    _updateUserData();
                                  } else {
                                    setState(() {});
                                  }
                                },
                                child: Text(
                                  'Review & Next >',
                                  style: TextStyle(
                                      fontSize: screenHeight * 0.015,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
Widget buildLabeledTextField(
    BuildContext context,
    String label,
    String hintText, {
      bool showPositionedBox = false,
      IconData? prefixIcon,
      bool obscureText = false,
      List<String>? dropdownItems,
      TextEditingController? controller,
      String? Function(String?)? validator,
      VoidCallback? onTap,
      TextInputType? keyboardType,
    }) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(color: Colors.black),
              ),
              const TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04),
        child: dropdownItems != null
            ? DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          value: controller?.text.isNotEmpty == true
              ? controller?.text
              : null,
          hint: Text(hintText),
          onChanged: (String? newValue) {
            setState(() {
              controller?.text = newValue!;
            });
          },
          items: dropdownItems.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          validator: validator,
          isExpanded: true,
        )
            : TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          obscureText: obscureText,
          validator: validator,
          onTap: onTap,
          keyboardType: keyboardType,
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
    ],
  );
}

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }



  // Widget buildGenderField() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(
  //             horizontal: MediaQuery.of(context).size.width * 0.04),
  //         child: RichText(
  //           text: const TextSpan(
  //             children: [
  //               TextSpan(
  //                 text: 'Gender',
  //                 style: TextStyle(color: Colors.black),
  //               ),
  //               TextSpan(
  //                 text: " *",
  //                 style: TextStyle(color: Colors.red),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding:
  //             EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
  //         child: Row(
  //           children: [
  //             Radio(
  //               value: Gender.Male,
  //               groupValue: _selectedGender,
  //               onChanged: _handleGenderChange,
  //             ),
  //             const Text('Male'),
  //             Radio(
  //               value: Gender.Female,
  //               groupValue: _selectedGender,
  //               onChanged: _handleGenderChange,
  //             ),
  //             const Text('Female'),
  //             Radio(
  //               value: Gender.Other,
  //               groupValue: _selectedGender,
  //               onChanged: _handleGenderChange,
  //             ),
  //             const Text('Other'),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
  //     ],
  //   );
  // }
  //
  // Widget buildStateDropdown() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(
  //       horizontal: MediaQuery.of(context).size.width * 0.045,
  //       vertical: MediaQuery.of(context).size.height * 0.01,
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: MediaQuery.of(context).size.height * 0.01),
  //       ],
  //     ),
  //   );
  // }
}
