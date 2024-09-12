import 'package:flutter/material.dart';
import 'package:hiremi_version_two/HiremiScreen.dart';
import 'package:hiremi_version_two/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Conformationbox extends StatefulWidget {
  const Conformationbox({Key? key}) : super(key: key);

  @override
  State<Conformationbox> createState() => _ConformationboxState();
}

class _ConformationboxState extends State<Conformationbox> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Container(
                    width: screenWidth * 0.08,
                    height: screenWidth * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        size: screenWidth * 0.032,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 1,
                    width: screenWidth * 0.310, // 125/400
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  Icon(
                    Icons.error_rounded,
                    color: const Color(0xFFC1272D),
                    size: screenWidth * 0.105,
                  ),
                  Container(
                    height: 1,
                    width: screenWidth * 0.310, // 125/400
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                'Are you Sure you want to log out',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),

            ],
          ),
        ),

        Center(
          child: Column(
            children: [

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  color: Colors.green,
                ),
                child: TextButton(
                  onPressed: () async {
                    final sharedPref = await SharedPreferences.getInstance();
                    sharedPref.setBool(HiremiScreenState.KEYLOGIN, false);
                    //  await sharedPref.clear(); // This will clear all the saved preferences
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (ctx) => const LogIn()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
