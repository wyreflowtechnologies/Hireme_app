import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hiremi_version_two/Controller/Register_controller.dart';
import 'package:hiremi_version_two/Custom_Widget/Curved_Container.dart';
import 'package:hiremi_version_two/Custom_Widget/Elevated_Button.dart';
// import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
// import 'package:hiremi_version_two/Login.dart';
import 'package:hiremi_version_two/Models/register_model.dart';

import 'package:hiremi_version_two/Utils/colors.dart';

import 'package:intl/intl.dart';

class Registers extends StatefulWidget {
  const Registers({Key? key}) : super(key: key);

  @override
  _RegistersState createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, GlobalKey<FormFieldState<String>>> _dropdownKeys = {
    'birthPlace': GlobalKey<FormFieldState<String>>(),
    // Add other dropdown keys if needed
  };

  final ScrollController _scrollController = ScrollController();
  final Map<String, FocusNode> _focusNodes = {
    'fullName': FocusNode(),
    'fatherName': FocusNode(),
    'email': FocusNode(),
    'dob': FocusNode(),
    'birthPlace': FocusNode(),
    'phone': FocusNode(),
    'whatsapp': FocusNode(),
    'collegeName': FocusNode(),
    'collegeState': FocusNode(),
    'branch': FocusNode(),
    'degree': FocusNode(),
    'passingYear': FocusNode(),
    'password': FocusNode(),
    'confirmPassword': FocusNode(),
  };
  Gender? _selectedGender=Gender.Male;
  String? _selectedState;
  DateTime? _selectedDate;
  bool _isObscure = true;
  bool _isConfirmPasswordObscure = true;

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
  'Chandigarh',
  'Delhi',
  'Jammu and Kashmir',
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

  RegistrationController _registrationController = RegistrationController();

  void _handleGenderChange(Gender? value) {
    setState(() {
      _selectedGender = value;
    });
  }
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;


  @override
  void dispose() {
    // Dispose controllers to free up resources
    _scrollController.dispose();
    _focusNodes.values.forEach((focusNode) => focusNode.dispose());
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

  // void _scrollToFirstError(String key) {
  //   print("IN scro;;");
  //   _focusNodes[key]?.requestFocus();
  //   _scrollController.animateTo(
  //     _focusNodes[key]?.offset.dy ?? 0,
  //     duration: Duration(seconds: 1),
  //     curve: Curves.easeInOut,
  //   );
  // }
  // void _scrollToFirstError() {
  //   final form = _formKey.currentState;
  //   if (form == null) return;
  //
  //   // Focus on the first invalid field
  //   for (var entry in _focusNodes.entries) {
  //     final fieldName = entry.key;
  //     final focusNode = entry.value;
  //
  //     // Validate the form field corresponding to the focus node
  //     final fieldState = focusNode.context?.findAncestorStateOfType<FormFieldState>();
  //     if (fieldState != null && fieldState.hasError) {
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //         final renderObject = focusNode.context?.findRenderObject();
  //         if (renderObject != null) {
  //           final offset = (renderObject as RenderBox).localToGlobal(Offset.zero).dy;
  //           _scrollController.animateTo(
  //             offset,
  //             duration: const Duration(seconds: 1),
  //             curve: Curves.easeInOut,
  //           );
  //           focusNode.requestFocus();
  //         }
  //       });
  //       break; // Exit loop after focusing on the first invalid field
  //     }
  //   }
  // }
  void _scrollToFirstError() {
    final form = _formKey.currentState;
    if (form == null) return;

    // Get all fields with errors
    List<FocusNode> fieldsWithErrors = [];

    // Collect fields with errors from FocusNodes
    _focusNodes.forEach((key, focusNode) {
      final fieldState = focusNode.context?.findAncestorStateOfType<FormFieldState>();
      if (fieldState != null && fieldState.hasError) {
        fieldsWithErrors.add(focusNode);
      }
    });

    // Collect fields with errors from dropdowns
    _dropdownKeys.forEach((key, globalKey) {
      final fieldState = globalKey.currentContext?.findAncestorStateOfType<FormFieldState>();
      if (fieldState != null && fieldState.hasError) {
        // Find corresponding focus node if needed or directly add to the list
        final focusNode = _focusNodes[key];
        if (focusNode != null) {
          fieldsWithErrors.add(focusNode);
        }
      }
    });

    if (fieldsWithErrors.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final firstField = fieldsWithErrors.first;
        final context = firstField.context;
        if (context != null) {
          final renderObject = context.findRenderObject() as RenderBox?;
          if (renderObject != null) {
            final offset = renderObject.localToGlobal(Offset.zero).dy;
            final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
            _scrollController.animateTo(
              offset - keyboardHeight,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            firstField.requestFocus();
          }
        }
      });
    }
  }





  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }




  void showCustomSuccessDialog(BuildContext context, String name) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var borderRadius = BorderRadius.circular(8);
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Make the dialog background transparent
          child: Stack(
            children: [
              // Background blur effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                  width: screenWidth,
                  height: screenHeight,
                ),
              ),
              // Dialog content
              Center(
                child: Container(
                  width: screenWidth * 0.9,
                  // padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
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
                                  'Registered Successfully!',
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
                                'Congratulations, $name',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              const Text(
                                'You\'ve successfully created your\nprofile at Hiremi',
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
                                    'Continue',
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


  @override
  Widget build(BuildContext context) {

    double imageSize = MediaQuery.of(context).size.width * 0.6;
    double imageHeight = MediaQuery.of(context).size.height * 0.157;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'images/Hiremi_new_Icon.png',
                  width: imageSize,
                  height: imageHeight,
                ),
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Register to get started\n",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
        
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.0425),
              CurvedContainer(
                backgroundColor: Colors.white,
                borderColor: Colors.black,
                borderWidth: 0.53,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0425),
                      buildSectionHeader("Personal Information"),
                      buildLabeledTextField(
                        context,
                        "Full Name",
                        "John Doe",
                        controller: _fullNameController,
                        focusNode: _focusNodes['fullName'],
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
                        focusNode: _focusNodes['fatherName'],
        
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
                        focusNode: _focusNodes['email'],
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
                        keyboardType: TextInputType.none,
                        controller: _dobController,
                        focusNode: _focusNodes['dob'],
        
                        validator: (value) {
                          if (_selectedDate == null) {
                            return 'Please select your date of birth';
                          }
                          return null;
                        },
                        onTap: () async {
                          final screenSize = MediaQuery.of(context).size;
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context).copyWith(
                                  // Adjust text scale for larger/smaller screens
                                  textScaleFactor: screenSize.width*0.00225,
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
                      ),
                      // buildLabeledTextField(
                      //   context,
                      //   "Birth Place",
                      //   "Select State",
                      //   controller: _birthPlaceController,
                      //   focusNode: _focusNodes['birthPlace'],
                      //   key: _dropdownKeys['birthPlace'], // Add this line
                      //   dropdownItems: _states,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your birth place';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      buildLabeledTextField(
                        context,
                        "Birth Place",
                        "Select State",
                        controller: _birthPlaceController,
                        focusNode: _focusNodes['birthPlace'],
                        dropdownItems: _states,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birth place';
                          }
                          return null;
                        },
                      ),
        
        
        
                      buildSectionHeader("Contact Information"),
        
                      buildLabeledTextField(
                        context,
                        "Phone Number",
                        "",
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        focusNode: _focusNodes['phone'],
        
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          if (value.length > 10) {
                            return 'Please enter a valid Phone number';
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
                        "",
                        keyboardType: TextInputType.phone,
                        controller: _whatsappController,
                        focusNode: _focusNodes['whatsapp'],
        
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
                      buildSectionHeader("Educational Information"),
                      buildLabeledTextField(
                        context,
                        "College Name",
                        "Enter Your College Name",
                        controller: _collegeNameController,
                        focusNode: _focusNodes['collegeName'],
        
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your college name';
                          }
                          return null;
                        },
                      ),
                      //buildStateDropdown(),
                      buildLabeledTextField(
                        context,
                        "College's State",
                        "Enter Your College's State",
                        controller:_collegeStateController,
                        focusNode: _focusNodes['collegeState'],
        
                        // dropdownItems: _states,
                        dropdownItems: [
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
                          'Chandigarh',
                          'Delhi',
                          'Jammu and Kashmir',
                          'Lakshadweep',
                          'Puducherry',
                        ],
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
                        controller:_branchController,
                        focusNode: _focusNodes['branch'],
        
                        dropdownItems: ['Aerospace Engineering',
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
                          'Other',],
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
                        controller:_degreeController,
                        focusNode: _focusNodes['degree'],
        
                        dropdownItems: [ 'B.Com',
                          'B.Sc',
                          'B.Tech',
                          'BBA',
                          'BCA',
                          'Diploma',
                          'M.Com',
                          'M.Sc',
                          'M.Tech',
                          'MBA',
                          'MCA',
                          'Other',],
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
                        controller:_passingYearController,
                        focusNode: _focusNodes['passingYear'],
        
                        dropdownItems: [ '2017', '2018', '2019', '2020', '2021', '2022', '2023', '2024',
                          '2025', '2026', '2027'],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your passing year';
                          }
                          return null;
                        },
                      ),
                      buildSectionHeader("Let's Create Password"),
        
                      buildLabeledTextField(
                        context,
                        "Password",
                        "Enter your password",
                        controller: _passwordController,
                        focusNode: _focusNodes['password'],
        
                        prefixIcon: Icons.lock_outline,
                        obscureText:_isConfirmPasswordObscure,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
        
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            print("Clicked");
                            setState(() {
                              _isConfirmPasswordObscure = !_isConfirmPasswordObscure; // Toggle password visibility
                            });
                          },
                          child: Icon(_isConfirmPasswordObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                      buildLabeledTextField(
                        context,
                        "Confirm Password",
                        "Enter Your Confirm Password",
                        obscureText: _isObscure,
                        prefixIcon: Icons.lock_outline,
                        controller:_confirmPasswordController,
                        focusNode: _focusNodes['confirmPassword'],
        
                        validator: (value) {
                          if (value == null || value.isEmpty) {
        
                            return 'Please enter your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            print("Clicked");
                            setState(() {
                              _isObscure = !_isObscure; // Toggle password visibility
                            });
                          },
                          child: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        
                  CustomElevatedButton(
                    width: MediaQuery.of(context).size.width * 0.775,
                    height: MediaQuery.of(context).size.height * 0.0625,
                    text: 'Register Now',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User newUser = User(
                          fullName: _fullNameController.text,
                          fatherName: _fatherNameController.text,
                          gender: _selectedGender ?? Gender.Other,
                          email: _emailController.text,
                          dob: _dobController.text,
                          birthPlace: _birthPlaceController.text,
                          phone: _phoneController.text,
                          whatsapp: _whatsappController.text,
                          collegeName: _collegeNameController.text,
                          //collegeState: _selectedState ?? _states.first,
                          collegeState:_collegeStateController.text,
                          branch: _branchController.text,
                          degree: _degreeController.text,
                          passingYear: _passingYearController.text,
                          password: _passwordController.text,
                        );
        
                        bool registrationSuccess = await _registrationController.registerUser(newUser,context);
        
                        if (registrationSuccess) {
                          // Navigator.pushReplacement(
                          //   context,
                          //   SlidePageRoute(page: const LogIn()),
                          // );
                          showCustomSuccessDialog(context, _fullNameController.text);
                        } else {
        
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text('Registration failed. Please try again.'),
                          //     duration: Duration(seconds: 3),
                          //   ),
                          // );
                        }
                      }
        
                      else {
        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please filled your details correctly'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                     //  _scrollToFirstError();
                       }
                    },
                  ),
        
        
        
        
        
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
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

  Widget buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
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
        FocusNode? focusNode,
        IconData? prefixIcon,
        Widget? suffixIcon,
        bool obscureText = false,
        List<String>? dropdownItems,
        TextEditingController? controller,
        String? Function(String?)? validator,
        VoidCallback? onTap,
        TextInputType? keyboardType, GlobalKey<FormFieldState<String>>? key,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
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
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: dropdownItems != null
              ? DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            value: controller?.text.isNotEmpty == true ? controller?.text : null,
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
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              suffixIcon: suffixIcon, // Ensure suffixIcon is added here
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
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.12),
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
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.085),
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

