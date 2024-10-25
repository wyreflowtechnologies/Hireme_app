

import 'package:flutter/material.dart';

import 'package:hiremi_version_two/Controller/VerifyController.dart';

import 'package:hiremi_version_two/Models/VerifyModel.dart';

import 'package:hiremi_version_two/verification_screens/verification_screen1.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'bottomnavigationbar.dart';
enum Gender { Male, Female, Other }

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
final _formKey = GlobalKey<FormState>();
  Gender? _selectedGender = Gender.Male;
  String? _selectedState;
  DateTime? _selectedDate;
   String _userId="";
   String _fullName ="";
   String stored_number="50";
late VerifyController _verifyController;

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
  final TextEditingController _confirmPasswordController = TextEditingController();

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

  bool _isAllFieldsValid() {
    return _formKey.currentState?.validate() ?? false;
  }
String profileId = '';
@override
void initState() {
  super.initState();
  _retrieveId();
  _verifyController = VerifyController();


  _fetchFullName();


}
Future<void> _initializeNumber() async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('stored_number')) {
    await prefs.setString('stored_number', '25');
  }
  _fetchStoredNumber();
}
Future<void> _fetchStoredNumber() async {
  final prefs = await SharedPreferences.getInstance();
  String? storedNumber = prefs.getString('stored_number');
  setState(() {
    stored_number = storedNumber ?? '50';
  });
  print("Stored number: $stored_number");
}




  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      print("Retrieved id is $savedId");
      profileId = savedId.toString();
      print(profileId);
      _fetchUserProfile();
    } else {
      print("No id found in SharedPreferences");
    }

  }
  Future<void> _fetchUserProfile() async {
    String? storedEmail = await _verifyController.getStoredEmail();

    // Fetch the user profile without checking if storedEmail is null
    // Verifymodel? userProfile = await _verifyController.fetchUserProfile(storedEmail!);
    Verifymodel? userProfile = await _verifyController.fetchUserProfile(profileId);

    if (userProfile != null) {
      setState(() {
        _userId = userProfile.id;
        _fullNameController.text = userProfile.fullName;
        _fatherNameController.text = userProfile.fatherName;
        _emailController.text = userProfile.email;
        _dobController.text = userProfile.dateOfBirth;
        _birthPlaceController.text = userProfile.birthPlace;
        _selectedGender = userProfile.gender != null
            ? Gender.values.firstWhere(
              (e) => e.toString() == 'Gender.' + userProfile.gender!,
          orElse: () => Gender.Male,
        )
            : Gender.Male;
        // Handle other fields similarly
      });
      print(_fullNameController);
    }
  }



Future<void> _fetchFullName() async {
  final prefs = await SharedPreferences.getInstance();
  String? fullName = prefs.getString('full_name') ?? 'No name saved';
  setState(() {
    _fullName = fullName;
  });
}
Future<void> _updateUserProfile() async {

    if (!_isAllFieldsValid()) return;

    Verifymodel userProfile = Verifymodel(
      id: _userId.toString(),
      fullName: _fullNameController.text,
      fatherName: _fatherNameController.text,
      email: _emailController.text.toLowerCase(),
      dateOfBirth: _dobController.text,
      birthPlace: _birthPlaceController.text,
      gender: _selectedGender.toString().split('.').last, // Add gender property if necessary
    );
    print("UserProfile is ${userProfile.id}");
    print("User ID: $_userId"); // To check if _userId has a value

    bool isSuccess = await _verifyController.updateUserProfile(userProfile);

    if (isSuccess) {
      // Navigate to next screen on success
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', userProfile.email); // Save updated email
      _initializeNumber();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerificationScreen1()),
      );
    }

    else {
      print("Updation Fails");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


    double imageSize = MediaQuery.of(context).size.width * 0.6;
    double imageHeight = MediaQuery.of(context).size.height * 0.157;
   return WillPopScope(
     onWillPop: ()async {
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const NewNavbar(isV: false,)));
         return false;
     },
     child:Scaffold(
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
                    percent: 0.0,
                    center: const Text(
                      '0%',
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

            // backgroundColor: Colors.white,
            // borderColor: Colors.black,
            // borderWidth: 0.53,
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
                          'Personal Information',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      buildLabeledTextField(
                        context,
                        "Full Name",
                        "John Doe",
                        controller: _fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          if(value.length<4){
                            return "Length should be atleast 4";
                          }
                          final invalidSymbolPattern = r'[^a-zA-Z\s]';

                          // Check if the value contains special characters
                          if (RegExp(invalidSymbolPattern).hasMatch(value)) {
                            return 'Symbols and numbers are not allowed.';
                          }
                          return null;
                        },
                      ),
                      buildLabeledTextField(
                        context,
                        "Father's Full Name",
                        "Robert Dave",
                        controller: _fatherNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your father\'s full name';
                          }
                          if(value.length<4){
                            return "Length should be atleast 4";
                          }
                          final invalidSymbolPattern = r'[^a-zA-Z\s]';

                          // Check if the value contains special characters
                          if (RegExp(invalidSymbolPattern).hasMatch(value)) {
                            return 'Symbols and numbers are not allowed.';
                          }
                          return null;
                        },
                      ),
                      buildGenderField(),
                      buildLabeledTextField(
                        context,
                        "Email Address",
                        "yourEmail@gmail.com",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          // if (!value.toLowerCase().endsWith('@gmail.com')) {
                          //   return 'Only Gmail addresses are allowed';
                          // }
                          return null;
                        },
                      ),
                      buildLabeledTextField(
                        context,
                        "Date Of Birth",
                        "DD/MM/YYYY",
                        showPositionedBox: true,
                        prefixIcon: Icons.calendar_today,
                        controller: _dobController,

                        onTap: () async {
                          final screenSize = MediaQuery.of(context).size;
                          // final DateTime? pickedDate = await showDatePicker(
                          //   context: context,
                          //   initialDate: DateTime.now(),
                          //   firstDate: DateTime(1900),
                          //   lastDate: DateTime.now(),
                          // );
                          // if (pickedDate != null) {
                          //   setState(() {
                          //     _selectedDate = pickedDate;
                          //     _dobController.text =
                          //         DateFormat('yyyy-MM-dd').format(pickedDate);
                          //   });
                          // }
                          final DateTime? pickedDate=await showDatePicker(
                            context: context,
                            initialDate: DateTime(2017, 12, 31), // Set a valid initial date within the range
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2017, 12, 31), // Set lastDate to December 31, 2017
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  // Adjust text scale for larger/smaller screens
                                  textScaleFactor: screenSize.width * 0.00225,
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                              _dobController.text =DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                       readOnly: true
                      ),
                      buildLabeledTextField(
                        context,
                        "Birth Place",
                        "Select State",
                        controller: _birthPlaceController,
                        dropdownItems: _states,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birth place';
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
                                    _updateUserProfile();
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
    ),);
   
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


