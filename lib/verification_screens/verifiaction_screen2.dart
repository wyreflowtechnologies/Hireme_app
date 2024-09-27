import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
import 'package:hiremi_version_two/Custom_Widget/dropdown.dart';
import 'package:hiremi_version_two/Models/register_model.dart';
import 'package:hiremi_version_two/verification_screens/verification_screen3.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Apis/api.dart';

class VerificationScreen2 extends StatefulWidget {
  const VerificationScreen2({Key? key}) : super(key: key);

  @override
  State<VerificationScreen2> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen2> {
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
// Future<void> _fetchUserData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? storedEmail = prefs.getString('email');
//   print("Stored Email: $storedEmail");
//
//   if (storedEmail != null) {
//     try {
//       final response = await http.get(
//         Uri.parse('http://13.127.81.177:8000/api/registers/'),
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         print('All user data: $data');
//
//         final userData = data.firstWhere(
//               (user) => user['email'] == storedEmail,
//           orElse: () => null,
//         );
//
//         if (userData != null) {
//           print('Matched user data: $userData');
//           setState(() {
//             _userId = userData['id'].toString();
//             // _phoneController.text=userData['phone_number'];
//             // _whatsappController.text=userData['whatsapp_number'];
//             _collegeNameController.text=userData['college_name'];
//             _collegeStateController.text=userData['college_state'];
//             _branchController.text=userData['branch_name'];
//             _degreeController.text=userData['degree_name'];
//             _passingYearController.text=userData['passing_year'];
//
//
//           });
//         } else {
//           print('No user found with the stored email');
//         }
//       } else {
//         print('Failed to load user data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   } else {
//     print('No email stored');
//   }
// }
  Future<void> _updateStoredNumber() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('stored_number', '75'); // Set the new number here
  }
  Future<void> _fetchFullName() async {
    final prefs = await SharedPreferences.getInstance();
    String? fullName = prefs.getString('full_name') ?? 'No name saved';
    setState(() {
      _fullName = fullName;
    });
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

              // Print statements to debug the data being set
              print('Setting college name: ${userData['college_name']}');
              _collegeNameController.text = userData['college_name'] ?? '';

              print('Setting college state: ${userData['college_state']}');
              _collegeStateController.text = userData['college_state'] ?? '';

              print('Setting branch name: ${userData['branch_name']}');
              _branchController.text = userData['branch_name'] ?? '';

              print('Setting degree name: ${userData['degree_name']}');
              _degreeController.text = userData['degree_name'] ?? '';

              print('Setting passing year: ${userData['passing_year']}');
              _passingYearController.text = (userData['passing_year'] ?? '').toString();
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


  Future<void> _updateUserData() async {
  if (!_isAllFieldsValid()) return;

  try {
    final response = await http.patch(
      Uri.parse('${ApiUrls.baseurl}/api/registers/$_userId/'),

      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({

        'college_name':_collegeNameController.text,
        'college_state':_collegeStateController.text,
        'branch_name':_branchController.text,
        'degree_name':_degreeController.text,
        'passing_year':_passingYearController.text


        // Include other fields similarly
      }),
    );

    if (response.statusCode == 200) {
      _updateStoredNumber();
      print('User data updated successfully');
      Navigator.push(
        context,
        SlidePageRoute(page: VerificationScreen3()),
      );
    } else {
      print("$_userId");
      print('Failed to update user data: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error in catch: $e');
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
                    percent: 0.5,
                    center: const Text(
                      '50%',
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
                          'Education Information',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      buildLabeledTextField(
                        context,
                        "College Name",
                        "Enter Your College Name",
                        controller: _collegeNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your college name';
                          }
                          final invalidSymbolPattern = r'[^a-zA-Z\s]';
                          if (RegExp(invalidSymbolPattern).hasMatch(value)) {
                            return 'Symbols and numbers are not allowed.';
                          }
                          return null;
                        },
                      ),
                      //buildStateDropdown(),
                      buildLabeledTextField(
                        context,
                        "College's State",
                        "Enter Your College's State",
                        controller: _collegeStateController,
                        dropdownItems:  DropdownData.states,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your College's State";
                          }
                          return null;
                        },
                      ),
                      buildLabeledTextField(
                        context,
                        "Branch",
                        "Enter Your Branch Name",
                        controller: _branchController,
                        dropdownItems: [
                          'Aerospace Engineering',
                          'Automotive Engineering',
                          'Chemical Engineering',
                          'Civil Engineering',
                          'Computer Science and Engineering',
                          'Electrical Engineering',
                          'Electronics and Communication Engineering',
                          'Finance',
                          'Human Resources',
                          'Industrial Engineering',
                          'Information Technology',
                          'Marine Engineering',
                          'Marketing',
                          'Materials Engineering',
                          'Mechanical Engineering',
                          'Metallurgical Engineering',
                          'Nuclear Engineering',
                          'Robotics Engineering',
                          'Sales',
                          'Other',
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your branch';
                          }
                          return null;
                        },
                      ),
                      buildLabeledTextField(
                        context,
                        "Degree",
                        "Enter Your Degree Name",
                        controller: _degreeController,
                        dropdownItems: [
                          'B.Com',
                          'B.Sc',
                          'BE',
                          'B.Tech',
                          'BBA',
                          'BCA',
                          'Diploma',
                          'M.Com',
                          'M.Sc',
                          'M.Tech',
                          'MBA',
                          'MCA',
                          'Other',
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your degree';
                          }
                          return null;
                        },
                      ),
                      buildLabeledTextField(
                        context,
                        "Passing Year",
                        "Enter Your Passing Year",
                        controller: _passingYearController,

                        dropdownItems: [ '2017', '2018', '2019', '2020', '2021', '2022', '2023', '2024',
                          '2025', '2026', '2027'],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your passing year';
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
                                    //     builder: (ctx) => const VerificationScreen3()));
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
                      SizedBox(height: 70),
                    ],
                  ),
                ),
              ),

          ],
        ),
      ),
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
        bool readOnly = false, // Added parameter
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
              if (newValue != null) {
                controller?.text = newValue;
              }
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
            readOnly: readOnly, // Added line
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
      ],
    );
  }



  Widget buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Gender',
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
          child: Row(
            children: [
              Radio(
                value: Gender.Male,
                groupValue: _selectedGender,
                onChanged: _handleGenderChange,
              ),
              const Text('Male'),
              Radio(
                value: Gender.Female,
                groupValue: _selectedGender,
                onChanged: _handleGenderChange,
              ),
              const Text('Female'),
              Radio(
                value: Gender.Other,
                groupValue: _selectedGender,
                onChanged: _handleGenderChange,
              ),
              const Text('Other'),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
      ],
    );
  }

  Widget buildStateDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.045,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ),
    );
  }
}
