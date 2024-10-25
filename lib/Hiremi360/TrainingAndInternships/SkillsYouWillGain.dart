// import 'package:flutter/material.dart';
//
// class GradientContainer extends StatelessWidget {
//   final String text;
//   final double height;
//   final double width;
//
//   const GradientContainer({
//     Key? key,
//     required this.text,
//     required this.height,
//     required this.width,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Outer margin for spacing
//       padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005), // This controls the thickness of the border
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04), // Rounded corners for the border
//         gradient: const LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Colors.blueAccent,
//             Colors.redAccent,
//           ],
//         ),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01), // Inner padding for content inside the border
//         decoration: BoxDecoration(
//           color: Colors.white, // Card content background
//           borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.035), // Rounded corners slightly smaller to match border
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               fontSize: MediaQuery.of(context).size.width * 0.04, // Adjust the font size according to screen width
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final String text;
  final double height;
  final double width;

  const GradientContainer({
    Key? key,
    required this.text,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Outer margin for spacing
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005), // This controls the thickness of the border
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04), // Rounded corners for the border
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blueAccent,
            Colors.redAccent,
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01), // Inner padding for content inside the border
        decoration: BoxDecoration(
          color: Colors.white, // Card content background
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.035), // Rounded corners slightly smaller to match border
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04, // Adjust the font size according to screen width
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}