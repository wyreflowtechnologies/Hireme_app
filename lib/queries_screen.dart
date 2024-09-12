
import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:hiremi_version_two/Query_Starting_Screen.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';

import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'Apis/api.dart';

class QueriesScreen extends StatefulWidget {
  final bool isVerified;
  const QueriesScreen({Key? key, required this.isVerified}) : super(key: key);

  @override
  State<QueriesScreen> createState() => _QueriesScreenState();
}

class _QueriesScreenState extends State<QueriesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _queryTypeController = TextEditingController();
  final _problemDescriptionController = TextEditingController();
 // final _dobController = TextEditingController();
  bool? isFirstComplete = true;
  late int ID;
  String? _validationMessage;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _queryTypeController.dispose();
    _problemDescriptionController.dispose();
  //  _dobController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _retrieveFirstscreen();
    _retrieveId();
  }
    Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      ID = savedId;
      print(ID);
      print("Retrieved id is $savedId");
    } else {
      print("No id found in SharedPreferences");
    }
  }

  Future<void> _retrieveFirstscreen() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFirstComplete = prefs.getBool('isFirstComplete')!;
    });
  }

  Future<void> _submitQuery() async {
    if (_formKey.currentState?.validate() ?? false) {
      final fullName = _fullNameController.text;
      final emailAddress = _emailController.text;
      final queryType = _queryTypeController.text;
      final problemDescription = _problemDescriptionController.text;
     // final dateOfBirth = _dobController.text;

   //   print(userRepository.currentUser!.userId);
      final Map<String, dynamic> requestData = {
        'name': fullName,
        'email': emailAddress,
        'issue': queryType,
        'description': problemDescription,
       // 'date_of_birth': dateOfBirth,
        'register': ID,
      };

      try {
        final response = await http.post(
          Uri.parse('${ApiUrls.baseurl}/api/queries/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestData),
        );
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Query Submitted Successfully'),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(20),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // print(response.statusCode);
         //  print(response.body);
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Failed to submit query.')),
          // );
          final errorMessage = jsonDecode(response.body)['error'] ?? 'Failed to submit query.';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$errorMessage'),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
  Future<void> _validateFullName() async {
    final value = _fullNameController.text;
    final storedFullName = await SharedPreferencesHelper.getFullName();

    if (value.isEmpty) {
      setState(() {
        _validationMessage = 'Please enter your full name';
      });
    } else if (value != storedFullName) {
      setState(() {
        _validationMessage = 'Please Entered you registered Email';
      });
    } else {
      setState(() {
        _validationMessage = null; // No error
      });
    }
  }


  Future<void> _selectDateOfBirth() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFFC1272D),
            hintColor: const Color(0xFFC1272D),
            buttonTheme:
            const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        //_dobController.text =
        "${pickedDate.toLocal()}".split(' ')[0]; // F/ Format as yyyy-mm-dd
      });
    }
  }

  List<String> queryType = [
    'general',
    'technical',
    'billing',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight*0.085,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight * 0.00),
                    child: Image.asset(
                      'images/At the office-pana.png',
                    ),
                  ),
                ),
                !isFirstComplete!
                    ? QueryStartingScreen(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isFirstComplete', true);
                    setState(() {
                      isFirstComplete = true;
                    });
                  },
                )
                    :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Sizes.responsiveMdSm(context)),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.responsiveSm(context)),
                      child: TextFieldWithTitleForQuery(
                        controller: _fullNameController,
                        title: 'Full Name',
                        hintText: 'Full Name',

                      ),

                    ),
                    if (_validationMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _validationMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(
                      height: Sizes.responsiveSm(context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.responsiveSm(context)),
                      child: TextFieldWithTitleForQuery(
                        controller: _emailController,
                        title: 'Email Address',
                        hintText: 'Email Address',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          // Simple email validation
                          final emailRegex =
                          RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Sizes.responsiveSm(context),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //       horizontal: Sizes.responsiveSm(context)),
                    //   child: TextFieldWithTitleForQuery(
                    //     controller: _dobController,
                    //     title: 'Date of Birth',
                    //     onTap: _selectDateOfBirth,
                    //     readOnly: true,
                    //     hintText: 'Date of Birth',
                    //     suffix: const Icon(
                    //       Icons.calendar_today_outlined,
                    //       size: 20,
                    //     ),
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please select your date of birth';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: Sizes.responsiveSm(context),
                    // ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.responsiveSm(context)),
                        child: buildLabeledTextField(
                          context,
                          'Query Type',
                          'Query Type',
                          controller: _queryTypeController,
                          dropdownItems: queryType,
                          onChanged: (value) {
                            setState(() {
                              _queryTypeController.text = value!;
                            });
                          },
                        )),
                    SizedBox(
                      height: Sizes.responsiveSm(context),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Sizes.responsiveSm(context)),
                      child: TextFieldWithTitleForQuery(
                        controller: _problemDescriptionController,
                        title: 'Problem Description',
                        hintText: 'Problem Description',
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please describe the problem';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: Sizes.responsiveMd(context)),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () async{
                          await _validateFullName();
                          _submitQuery();
                        },
                        child: const Text(
                          'Generate Query',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.1,
                    )
                  ],
                ),
              ],
            ),
          ),
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
        void Function(String?)? onChanged,
        TextInputType? keyboardType,
      }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
            ),
            TextSpan(
              text: " *",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary),
            ),
          ],
        ),
      ),
      SizedBox(height: Sizes.responsiveSm(context)),
      DropdownButtonFormField<String>(
        dropdownColor: Colors.white,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.black.withOpacity(0.8)),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          contentPadding: EdgeInsets.symmetric(
              horizontal: Sizes.responsiveMdSm(context),
              vertical: Sizes.responsiveXs(context)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.green,
              width: 0.37,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.green,
              width: 0.37,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.green,
              width: 0.37,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: AppColors.green,
              width: 0.37,
            ),
          ),
        ),
        value: controller?.text.isNotEmpty == true ? controller?.text : null,
        hint: Text(hintText),
        onChanged: onChanged,
        items: dropdownItems!.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        validator: validator,
      ),
    ]);
  }
}



class TextFieldWithTitleForQuery extends StatelessWidget {
  const TextFieldWithTitleForQuery({

    required this.controller,
    required this.title,
    required this.hintText,
    this.starNeeded = true,
    this.prefix,
    this.suffix,
    this.spaceBtwTextField,
    this.maxLines,
    this.validator,
    this.textInputType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController controller;
  final String title, hintText;
  final bool starNeeded;
  final Widget? prefix, suffix;
  final double? spaceBtwTextField;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            if (starNeeded)
              Text(
                '*',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
          ],
        ),
        SizedBox(
          height: spaceBtwTextField ?? Sizes.responsiveSm(context),
        ),
        CustomTextFieldQuery(
            controller: controller,
            hintText: hintText,
            prefix: prefix,
            suffix: suffix,
            validator: validator,
            textInputType: textInputType,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines),
      ],
    );
  }
}

class CustomTextFieldQuery extends StatelessWidget {
  const CustomTextFieldQuery({

    required this.controller,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.suffix,
    this.prefix,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final int? maxLines;
  final Widget? suffix;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onTap: onTap,
      cursorColor: AppColors.black,
      textAlign: TextAlign.start,
      maxLines: maxLines,
      readOnly: readOnly,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      expands: false,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffix,
        prefixIcon: prefix,
        suffixIconColor: AppColors.secondaryText,
        contentPadding: EdgeInsets.symmetric(
            vertical: Sizes.responsiveSm(context),
            horizontal: Sizes.responsiveMd(context)),
        alignLabelWithHint: true,
        hintStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.black.withOpacity(0.8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            color: AppColors.secondaryText,
            width: 0.37,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            color: AppColors.green,
            width: 0.37,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            color: AppColors.green,
            width: 0.37,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            color: AppColors.green,
            width: 0.37,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3),
          borderSide: BorderSide(
            color: AppColors.green,
            width: 0.37,
          ),
        ),
      ),
    );
  }
}