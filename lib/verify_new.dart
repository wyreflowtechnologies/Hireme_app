import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Controller/Register_controller.dart';
import 'package:hiremi_version_two/Models/register_model.dart';
import 'package:hiremi_version_two/verification_screens/verification_screen1.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class VerifyNew extends StatefulWidget {
  const VerifyNew({Key? key}) : super(key: key);

  @override
  State<VerifyNew> createState() => _VerifyNewState();
}

class _VerifyNewState extends State<VerifyNew> {
  final _formKey = GlobalKey<FormState>();
  Gender? _selectedGender = Gender.Male;
  String? _selectedState;
  DateTime? _selectedDate;

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

  RegistrationController _registrationController = RegistrationController();

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
                    percent: 0.25,
                    center: const Text(
                      '25%',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    progressColor: Colors.green,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(height: screenHeight * 0.0075),
                  const Text(
                    'Harsh Pawar',
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
                        validator: (value) {
                          if (_selectedDate == null) {
                            return 'Please select your date of birth';
                          }
                          return null;
                        },
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                              _dobController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
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
                      // buildSectionHeader("Contact Information"),
                      // buildLabeledTextField(
                      //   context,
                      //   "Phone Number",
                      //   "+91",
                      //   keyboardType: TextInputType.phone,
                      //   controller: _phoneController,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your phone number';
                      //     }
                      //     if (value.length < 10) {
                      //       return 'Please enter a valid phone number';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // buildLabeledTextField(
                      //   context,
                      //   "WhatsApp Number",
                      //   "+91",
                      //   keyboardType: TextInputType.phone,
                      //   controller: _whatsappController,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your WhatsApp number';
                      //     }
                      //     if (value.length < 10) {
                      //       return 'Please enter a valid WhatsApp number';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // buildSectionHeader("Educational Information"),
                      // buildLabeledTextField(
                      //   context,
                      //   "College Name",
                      //   "Enter Your College Name",
                      //   controller: _collegeNameController,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your college name';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // //buildStateDropdown(),
                      // buildLabeledTextField(
                      //   context,
                      //   "College's State",
                      //   "Enter Your College's State",
                      //   controller: _collegeStateController,
                      //   dropdownItems: _states,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please enter your College's State";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // buildLabeledTextField(
                      //   context,
                      //   "Branch",
                      //   "Enter Your Branch Name",
                      //   controller: _branchController,
                      //   dropdownItems: ['Degree 1', 'Degree 2', 'Degree 3'],
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your branch';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // buildLabeledTextField(
                      //   context,
                      //   "Degree",
                      //   "Enter Your Degree Name",
                      //   controller: _degreeController,
                      //   dropdownItems: ['Degree 1', 'Degree 2', 'Degree 3'],
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your degree';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // buildLabeledTextField(
                      //   context,
                      //   "Passing Year",
                      //   "Enter Your Passing Year",
                      //   controller: _passingYearController,
                  
                      //   dropdownItems: ['2012', '2024', '2025'],
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your passing year';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // buildSectionHeader("Let's Create Password"),
                  
                      // buildLabeledTextField(
                      //   context,
                      //   "Password",
                      //   "Enter Your Password",
                      //   obscureText: true,
                      //   controller: _passwordController,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your password';
                      //     }
                      //     if (value.length < 8) {
                      //       return 'Password must be at least 8 characters long';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // buildLabeledTextField(
                      //   context,
                      //   "Confirm Password",
                      //   "Enter Your Password",
                      //   obscureText: true,
                      //   controller: _confirmPasswordController,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your password';
                      //     }
                      //     if (value != _passwordController.text) {
                      //       return 'Passwords do not match';
                      //     }
                      //     return null;
                      //   },
                      // ),
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
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (ctx) => const VerificationScreen1()));
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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

