import 'package:flutter/material.dart';
import 'package:hiremi_version_two/verify.dart';

class AdBanner extends StatelessWidget {
  AdBanner({Key? key, required this.isVerified}) : super(key: key);
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.02),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFEFE0),
            Color(0xFFFFF3F5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      width: screenWidth * 0.95,
      height: screenHeight * 0.181,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Get ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: const Color(0xFF022A72),
                      ),
                    ),
                    Text(
                      'Hiremi ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: const Color(0xFFC1272D),
                      ),
                    ),
                    Text(
                      'Verified ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '& ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: const Color(0xFF022A72),
                      ),
                    ),
                    Text(
                      'Apply ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: const Color(0xFFEB8D2E),
                      ),
                    ),
                  ],
                ),
                Text(
                  'for Jobs to Be Hired by ',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: const Color(0xFF022A72),
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  'Experts Easily. ',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: const Color(0xFF022A72),
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  height: screenHeight * 0.035,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(screenWidth * 0.05),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if(!isVerified) {
                        Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const VerificationScreen(),
                        ),
                      );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/new_releases (1).png',
                          height: screenWidth * 0.025,
                          width: screenWidth * 0.025,
                        ),
                        SizedBox(
                          width: screenWidth * 0.0125,
                        ),
                        Text(
                          isVerified ? 'Verified' : 'Verify Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.0225,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015,
                ),
                Text(
                  'T&C Apply',
                  style: TextStyle(
                    fontSize: screenWidth * 0.02,
                    color: const Color(0xFF022A72),
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const Spacer(),
            Image.asset('images/freepik--Characters--inject-2.png')
          ],
        ),
      ),
    );
  }
}
