import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hiremi_version_two/Utils/colors.dart';

class SuccesfullPaymentCompletion extends StatelessWidget {
  const SuccesfullPaymentCompletion({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var borderRadius = BorderRadius.circular(8);

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
                              'Congratulations!',
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
                            'Your App ID is ',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          const Text(
                            'Additional Benefits are unlocked,\nIndependently Explore Hiremi',
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
                                'Explore Hiremi',
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
  }
}
