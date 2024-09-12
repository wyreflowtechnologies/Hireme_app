
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/FirstLandingPage.dart';

import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Apis/api.dart';

class HiremiScreen extends StatefulWidget {
  @override
  State<HiremiScreen> createState() => HiremiScreenState();
}

class HiremiScreenState extends State<HiremiScreen> {
  static const String KEYLOGIN = "login";
  String? _savedEmail;
  String profileId = '';

  @override
  void initState() {
    super.initState();

    _printSavedEmail();
  }

  Future<String?> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedEmail = prefs.getString('email') ?? 'No email saved';
    });
    print("Saved email is $_savedEmail");
    _retrieveId();
  }

  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      print("Retrieved id is $savedId");
      profileId = savedId.toString();
      print(profileId);
    } else {
      print("No id found in SharedPreferences");
    }
    whereToGo();
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    bool isVerified = false;

    if (isLoggedIn != null && isLoggedIn) {
      // Call the API to check the verification status
      final response = await http.get(Uri.parse('${ApiUrls.baseurl}/api/registers/$profileId'));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        isVerified = responseBody['verified'] ?? false;
        print("Verifies is $isVerified");
      } else {
        print("Failed to fetch verification status: ${response.statusCode}");
        print("Verifies is $isVerified");
        print("Server error is by backend ${response.body}");
        print(profileId);
      }

      // Navigate based on the verification status
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => NewNavbar(isV: isVerified),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => FirstLandingPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/Hiremi_new_Icon.png',
          width: imageSize,
          height: imageSize,
        ),
      ),
    );
  }
}
