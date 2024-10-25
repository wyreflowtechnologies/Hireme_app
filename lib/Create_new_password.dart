
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/api_services/base_services.dart';
import 'package:hiremi_version_two/api_services/user_services.dart';
import 'package:http/http.dart' as http;

import 'package:hiremi_version_two/Custom_Widget/Curved_Container.dart';
import 'package:hiremi_version_two/Custom_Widget/Elevated_Button.dart';
import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';

import 'package:hiremi_version_two/Login.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  void showCustomSuccessDialog(BuildContext context) {
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
                                  'Password Changed!',
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
                                'Password Changed Successfully',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              const Text(
                                'You\'ve successfully changed your\nprofile password',
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();
  bool _isObscure = true;
  bool _isObscureforConformPassword=true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'images/Hiremi_new_Icon.png',
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Create new Password.\n",
                          style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black, // Default text color
                          ),
                        ),
                        // TextSpan(
                        //   text: " Make it stronger",
                        //   style: TextStyle(
                        //     fontSize: 21.0,
                        //     fontWeight: FontWeight.w400,
                        //     color: Colors.black, // Default text color
                        //   ),
                        // ),
                      ],
                    ),
                    textAlign: TextAlign.center, // Center align the text
                  ),
                ),
                Center(
                  child: Image.asset(
                    'images/ResetPassword.png',
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),
                CurvedContainer(
                  backgroundColor: Colors.white,
                  borderColor: Colors.black,
                  borderWidth: 0.53,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0215),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0115),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.0205),

                      buildLabeledTextField(
                        context,
                        "Password",
                        "Enter Your Password",
                        obscureText: _isObscure,
                        prefixIcon: Icons.lock_outline,
                        controller: _passwordController,
                        validator: (value) {
                          final specialCharacterPattern = r'[^a-zA-Z0-9]';
                          final numberPattern = r'\d';
                          final letterPattern = r'[a-zA-Z]';
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(specialCharacterPattern).hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          if (!RegExp(numberPattern).hasMatch(value)) {
                            return 'Password must contain at least one number';
                          }
                          if (!RegExp(letterPattern).hasMatch(value)) {
                            return 'Password must contain at least one letter';
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscure = !_isObscure; // Toggle password visibility
                            });
                          },
                          child: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                        // Set to true to show the box with the prefix icon
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0115),

                      buildLabeledTextField(
                        context,
                        "Confirm Password",
                        "Enter Confirm Your Password",
                        obscureText: _isObscureforConformPassword,
                        prefixIcon: Icons.lock_outline,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          final specialCharacterPattern = r'[^a-zA-Z0-9]';
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!RegExp(specialCharacterPattern).hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isObscureforConformPassword = !_isObscureforConformPassword; // Toggle password visibility
                            });
                          },
                          child: Icon(_isObscureforConformPassword ? Icons.visibility_off : Icons.visibility),
                        ),
                        // Set to true to show the box with the prefix icon
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0247),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Password must be ",
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: "8 digit",
                              style: TextStyle(color: Colors.blue), // Change text color to blue
                            ),
                            TextSpan(
                              text: " long",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0285),
                      Center(
                        child: CustomElevatedButton(
                          width: MediaQuery.of(context).size.width * 0.775,
                          height: MediaQuery.of(context).size.height * 0.0625,
                          text: 'Reset Password',
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              // resetPassword(
                              //   _passwordController.text,
                              //   _confirmPasswordController.text,
                              // );
                              // bool isPasswordValid = await _checkPassword();
                              if (_passwordController.text != _confirmPasswordController.text) {
                                // Show Snackbar if passwords do not match
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Passwords do not match'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return; // Exit early to prevent further processing
                              }
                              bool isPasswordValid =true;

                              if(isPasswordValid) {
                                Map<String, dynamic> body = {
                                  "pass1": _passwordController.text.toString(),
                                  "pass2": _confirmPasswordController.text.toString()
                                };
                                var response = await _userService.createPostApi(
                                    body, ApiUrls.passwordReset);
                                if (response.statusCode == 200) {
                                  // ignore: use_build_context_synchronously


                                  Navigator.pushReplacement(
                                    context,
                                    SlidePageRoute(page: LogIn()),
                                  );
                                  showCustomSuccessDialog(context);
                                }
                                else {
                                  String errorMessage = response.body;
                                  // ignore: use_build_context_synchronously
                                  print(response.body);
                                  print("---------");
                                  print(response.statusCode);

                                }
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0447),
                    ],
                  ),
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
        IconData? positionedIcon,
        IconData? prefixIcon,
        bool obscureText = false,
        List<String>? dropdownItems,
        TextEditingController? controller,
        String? Function(String?)? validator,
        VoidCallback? onTap,
        TextInputType? keyboardType,
        Widget? suffixIcon,
        bool showContainer = false,
      }) {
    double calculatedBorderRadius = MediaQuery.of(context).size.width * 0.02;
    double calculatedSemiCircleWidth = MediaQuery.of(context).size.width * 0.08;
    double calculatedPaddingStart = MediaQuery.of(context).size.width * 0.1;

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
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: showContainer
              ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.redAccent),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                if (showPositionedBox)
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: calculatedSemiCircleWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(calculatedBorderRadius),
                          bottomLeft: Radius.circular(calculatedBorderRadius),
                        ),
                        border: Border(
                          right: BorderSide(
                            color: const Color(0xFF808080),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: positionedIcon != null
                            ? Icon(
                          positionedIcon,
                          color: Colors.grey[400],
                        )
                            : null,
                      ),
                    ),
                  ),
                Expanded(
                  child: dropdownItems != null
                      ? DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
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
                  )
                      : TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                      suffixIcon: suffixIcon,
                    ),
                    obscureText: obscureText,
                    validator: validator,
                    onTap: onTap,
                    keyboardType: keyboardType,
                  ),
                ),
                if (suffixIcon != null) suffixIcon,
              ],
            ),
          )
              : dropdownItems != null
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
          )
              : TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: suffixIcon,
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

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
