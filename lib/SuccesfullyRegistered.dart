// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
// import 'package:hiremi_version_two/Login.dart';
// import 'package:hiremi_version_two/Utils/colors.dart';
//
// class SuccessfullyRegisteredPopup extends StatelessWidget {
//   const SuccessfullyRegisteredPopup({Key? key, required this.name}) : super(key: key);
//   final String name;
//
//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     var borderRadius = BorderRadius.circular(8);
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//           child: Container(
//             color: Colors.black.withOpacity(0.55),
//             // Adjust the opacity as needed
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//             height: MediaQuery
//                 .of(context)
//                 .size
//                 .height,
//           ),
//         ),
//         Container(
//           width: screenWidth,
//           padding: EdgeInsets.only(
//               top: screenHeight * 0.04, bottom: screenHeight * 0.05),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(16),
//               topRight: Radius.circular(16),
//             ),
//             color: AppColors.green,
//           ),
//           child: Center(
//             child: Column(
//               children: [
//                 Image.asset('images/Group 33528.png'),
//                 SizedBox(height: screenHeight * 0.02),
//                 const Text(
//                   'Registered Successfully!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//               top: screenHeight * 0.02, bottom: screenHeight * 0.04),
//           child: Column(
//             children: [
//               Text(
//                 'Congratulations, $name',
//                 style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               const Text(
//                 'You\'ve successfully created your\nprofile at Hiremi',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.02),
//               Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.primary,
//                   borderRadius: borderRadius,
//                 ),
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text(
//                     'Continue',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hiremi_version_two/Utils/colors.dart';

class SuccessfullyRegisteredPopup extends StatelessWidget {
  const SuccessfullyRegisteredPopup({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var borderRadius = BorderRadius.circular(8);

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            // Adjust the opacity as needed
            width: screenWidth *0.5,
            height: screenHeight*0.5,
          ),
        ),
        Center(
          child: Container(
            width: screenWidth * 0.9,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
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
    );
  }
}
