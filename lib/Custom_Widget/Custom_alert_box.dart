import 'package:flutter/material.dart';
import 'package:hiremi_version_two/verification_screens/verifiaction_screen2.dart';
import 'package:hiremi_version_two/verification_screens/verification_screen1.dart';
import 'package:hiremi_version_two/verification_screens/verification_screen3.dart';
import 'package:hiremi_version_two/verify.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CustomAlertbox extends StatefulWidget {
  const CustomAlertbox({Key? key}) : super(key: key);

  @override
  State<CustomAlertbox> createState() => _CustomAlertboxState();
}

class _CustomAlertboxState extends State<CustomAlertbox> {
  String _storedNumber = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchStoredNumber();
  }
  Future<void> _fetchStoredNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedNumber = prefs.getString('stored_number');
    setState(() {
      _storedNumber = storedNumber ?? '0';
    });

    print("stored number is Custom alert box $_storedNumber");
  }
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
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
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
                  Expanded(
                    child: Container(
                      height: 0.8,
                      width: screenWidth * 0.310, // 125/400
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.error_rounded,
                    color: const Color(0xFFC1272D),
                    size: screenWidth * 0.105,
                  ),
                  Container(
                    height: 0.98,
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
                'Please, Review & Verify Profile',
                style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: screenWidth * 0.8,
                height: screenHeight * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  color: Colors.green[100],
                ),
                child:  Center(
                  child: Text(
                    'Additional Benefits will be unlocked once\n Verification Payment Completed.',
                    style: TextStyle(color: Colors.green, fontSize:MediaQuery.of(context).size.width*0.03),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
            ],
          ),
        ),
        Container(
          width: screenWidth,
          height: screenHeight * 0.04,
          color: const Color(0xFFC1272D),
          child: const Center(
            child: Text(
              '₹ 1000 / Life Time Subscription',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 11.42),
            ),
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Center(
          child: Column(
            children: [
              const Text(
                'Note: Verification is mandatory for\nspecial content access.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  color: Colors.green,
                ),
                child: TextButton(
                  onPressed: () {
                    if (_storedNumber == '0') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const VerificationScreen()));
                    } else if (_storedNumber == '25') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const VerificationScreen1()));
                    } else if (_storedNumber == '50') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const VerificationScreen2()));
                    }
                    else if (_storedNumber == '75') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const VerificationScreen3()));
                    }
                    else {
                      // Handle other cases or show an error
                      print('Unknown stored number: $_storedNumber');
                    }
                  },
                  child: const Text(
                    'Review & Verify Now >',
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
