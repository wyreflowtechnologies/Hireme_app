import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/Curved_Container.dart';
import 'package:hiremi_version_two/Custom_Widget/Elevated_Button.dart';
import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
import 'package:hiremi_version_two/HiremiScreen.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:hiremi_version_two/Forget_Your_Password.dart';
import 'package:hiremi_version_two/Register.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Apis/api.dart';
import 'Sharedpreferences_data/shared_preferences_helper.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String? _savedEmail;
  bool _isLoading = false;

  bool isV = false;
  late int id;
  late int ID;

  Future<String?> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedEmail = prefs.getString('email') ?? 'No email saved';
    });

    print("Saved email is $_savedEmail");
    await _isEmailVerified();
  }

  Future<bool> _isEmailVerified() async {
    final String apiUrl = "${ApiUrls.baseurl}/api/registers/";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);
      for (var user in users) {
        if (user['email'] == _savedEmail) {
          id = user['id'];

          final pref = await SharedPreferences.getInstance();
          await pref.setInt('userId', id);
          print("Id is $id");
          await _checkAndCreateProfile(id);
          await _retrieveId();
          print("Verified is ${user['verified']}");
          var sharedpref = await SharedPreferences.getInstance();
          sharedpref.setBool(HiremiScreenState.KEYLOGIN, true);
          Navigator.push(
            context,
            SlidePageRoute(
              page: NewNavbar(isV: user['verified']),
            ),
          );
          return true;
        }
      }
    }
    return false;
  }


  Future<void> _checkAndCreateProfile(int userId) async {
    final String apiUrl = "${ApiUrls.baseurl}/api/profiles/";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> profiles = jsonDecode(response.body);
      bool profileExists = false;
      int? profileId;

      for (var profile in profiles) {
        if (profile['register'] == userId) {
          profileExists = true;
          profileId = profile['id'];
          break;
        }
      }

      if (profileExists) {
        // Profile exists
        await SharedPreferencesHelper.setProfileId(profileId!);
        print("Existing profile ID: $profileId");
      } else {
        // Profile does not exist, create a new one
        await _createProfile(userId);
      }
    } else {
      print("Failed to check profile: ${response.statusCode}");
    }
  }

  Future<void> _createProfile(int userId) async {
    final String apiUrl = "${ApiUrls.baseurl}/api/profiles/";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "register": userId,
      }),
    );

    if (response.statusCode == 201) {
      final profile = jsonDecode(response.body);
      var profileId = profile['id'];

      await SharedPreferencesHelper.setProfileId(profileId);
      print("Profile created with ID: $profileId");
    } else {
      print(response.statusCode);
      print(response.body);
      print("Failed to create profile");
    }
  }



  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      print("Retrieved id is $savedId");
    } else {
      print("No id found in SharedPreferences");
    }
  }

  Future<void> _login() async {

    if (!_formKey.currentState!.validate()) {
      // Invalid inputs
      return;
    }
    setState(() {
      _isLoading = true; // Start loading
    });


    final String apiUrl = "${ApiUrls.baseurl}/login/";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": _emailController.text,
        "password": _passwordController.text,
      }),
    );
    setState(() {
      _isLoading = false; // Stop loading
    });

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _emailController.text); // Save email to SharedPreferences

      print("Login successful");
      print(response.body);
      _printSavedEmail();
    }

    else {
      // Login failed
      print(response.body);
      print("Login failed");

      final Map<String, dynamic> errorResponse = jsonDecode(response.body);

      // Access the error message and display it in the SnackBar
      String errorMessage = errorResponse['error'] ?? 'An unknown error occurred';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    print("Build");
    double calculatedSemiCircleWidth = MediaQuery.of(context).size.width * 0.08;
    double imageSize = MediaQuery.of(context).size.width * 0.6;
    double imageHeight = MediaQuery.of(context).size.height * 0.157;

    // List of image paths
    final List<String> imagePaths = [
      'images/Hiremi_new_Icon.png',
      'images/LogInImage.png',
    ];

    // Generate list of image widgets
    List<Widget> imageWidgets = List.generate(imagePaths.length, (index) {
      return Center(
        child: Image.asset(
          imagePaths[index],
          width: imageSize,
          height: imageHeight,
        ),
      );
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // List of images generated using List.generate
                ...imageWidgets,

                SizedBox(height: MediaQuery.of(context).size.height * 0.036),

                // RichText above the reusable CurvedContainer
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Let's Sign Into Hiremi",
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

                SizedBox(height: MediaQuery.of(context).size.height * 0.036),

                // Reusable CurvedContainer
                CurvedContainer(
                  backgroundColor: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0185),

                      buildLabeledTextField(
                        context,
                        "Email Address",
                        "yourEmail@gmail.com",
                        controller: _emailController,
                        prefixIcon: Icons.account_circle_outlined,
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
                        "Password",
                        "Enter Your Password",
                        obscureText: _isObscure,
                        prefixIcon: Icons.lock_outline,
                        controller: _passwordController,
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
                            setState(() {
                              _isObscure = !_isObscure; // Toggle password visibility
                            });
                          },
                          child: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                        ),
                        // Set to true to show the box with the prefix icon
                      ),

                     //SizedBox(height: MediaQuery.of(context).size.height * 0.00005),
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.56,),
                        child: Transform.translate(
                          offset: const Offset(0, -17), // Adjust the value to move the text upward
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue, // Change this to the color you want
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                SlidePageRoute(page: Forget_Your_Password()),
                              );
                            },
                            child: Text(
                              'Forget Password?',
                              style: TextStyle(color: Colors.blueAccent), // Adjust text color as needed
                            ),
                          ),
                        ),
                      ),

                      //SizedBox(height: MediaQuery.of(context).size.height * 0.0027),

                      Center(
                        child: CustomElevatedButton(
                          width: MediaQuery.of(context).size.width * 0.775,
                          height: MediaQuery.of(context).size.height * 0.0625,
                          text: 'Login',
                          onPressed: _login,
                          color: Color(0xFFC1272D),
                          enabled: !_isLoading, // Disable button if _isLoading is true
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      // Center(
                      //   child: Text(
                      //     "By clicking Login, you agree to Hiremi’s Terms & Conditions.",
                      //     style: TextStyle(
                      //       fontSize: 12,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      // ),
                      Center(
                          child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black, // Default text color
                                ),
                                children: [
                                  const TextSpan(
                                    text: "By logging in, you agree to Hiremi’s ",
                                  ),
                                  TextSpan(
                                    text: "Terms & Conditions",
                                    style: const TextStyle(
                                      color: Colors.blue, // Link color
                                      decoration: TextDecoration
                                          .underline, // Optional: underline
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async{
                                        final Uri url =
                                        Uri.parse('http://www.hiremi.in/terms&condition.html');
                                        if (!await launchUrl(url)) {
                                          throw Exception('Could not launch $url');
                                        }

                                      },
                                  ),
                                  const TextSpan(
                                    text: ".",
                                  ),
                                ],
                              ))),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.0205),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                              child: Text(
                                "or",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                      Center(
                        child: CustomElevatedButton(
                          color: Color(0xFFF5F4F4),
                          width: MediaQuery.of(context).size.width * 0.775,
                          height: MediaQuery.of(context).size.height * 0.0625,
                          text: 'Register Now',
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlidePageRoute(page: Registers()),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.018),

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


}
