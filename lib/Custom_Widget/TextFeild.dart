
import 'package:flutter/material.dart';

class CurvedTextField extends StatefulWidget {
  final String? hintText;
  final double? borderRadius;
  final double? semiCircleWidth;
  final double? paddingStart;
  final IconData? prefixIcon;
  final IconData? suffixIcon; // New parameter for suffix icon
  final bool obscureText;
  final bool showPositionedBox; // New parameter
  final TextEditingController? controller; // New parameter for controller
  final VoidCallback? onTap; // New parameter for onTap function
  final FormFieldValidator<String>? validator; // New parameter for validator

  const CurvedTextField({
    Key? key,
    this.hintText,
    this.borderRadius,
    this.semiCircleWidth,
    this.paddingStart,
    this.prefixIcon,
    this.suffixIcon, // Initialize the suffix icon parameter
    required this.obscureText,
    this.showPositionedBox = true, // Default to true
    this.controller, // Initialize the controller parameter
    this.onTap, // Initialize the onTap parameter
    this.validator, // Initialize the validator parameter
  }) : super(key: key);

  @override
  _CurvedTextFieldState createState() => _CurvedTextFieldState();
}

class _CurvedTextFieldState extends State<CurvedTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    double calculatedBorderRadius = widget.borderRadius ?? MediaQuery.of(context).size.width * 0.02;
    double calculatedSemiCircleWidth = widget.semiCircleWidth ?? MediaQuery.of(context).size.width * 0.08;
    double calculatedPaddingStart = widget.paddingStart ?? MediaQuery.of(context).size.width * 0.1;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(calculatedBorderRadius),
          bottomLeft: Radius.circular(calculatedBorderRadius),
          topRight: Radius.circular(calculatedBorderRadius),
          bottomRight: Radius.circular(calculatedBorderRadius),
        ),
        border: Border.all(
          color: Color(0xFF808080), // Grey border color
          width: 1.0, // Border width
        ),
      ),
      child: Stack(
        children: [
          if (widget.showPositionedBox)
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
                      color: Color(0xFF808080),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Center(
                  child: widget.prefixIcon != null
                      ? Icon(
                    widget.prefixIcon,
                    color: Colors.grey[400],
                  )
                      : null,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
              left: widget.showPositionedBox ? calculatedPaddingStart : MediaQuery.of(context).size.width * 0.05,
            ),
            child: TextFormField(
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                suffixIcon: widget.suffixIcon != null // Check if suffixIcon is provided
                    ? GestureDetector(
                  onTap: widget.onTap, // Use onTap function directly
                  child: Icon(
                    widget.suffixIcon,
                    color: Colors.grey[400],
                  ),
                )
                    : null,
              ),
              obscureText: obscureText,
              validator: widget.validator, // Pass the validator to the TextFormField
              onChanged: (value) {
                // Handle input changes if needed
              },
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// class CurvedTextField extends StatefulWidget {
//   final String? hintText;
//   final double? borderRadius;
//   final double? semiCircleWidth;
//   final double? paddingStart;
//   final IconData? prefixIcon;
//   final IconData? suffixIcon; // New parameter for suffix icon
//   final bool obscureText;
//   final bool showPositionedBox; // New parameter
//   final TextEditingController? controller; // New parameter for controller
//   final VoidCallback? onTap; // New parameter for onTap function
//
//   const CurvedTextField({
//     Key? key,
//     this.hintText,
//     this.borderRadius,
//     this.semiCircleWidth,
//     this.paddingStart,
//     this.prefixIcon,
//     this.suffixIcon, // Initialize the suffix icon parameter
//     required this.obscureText,
//     this.showPositionedBox = true, // Default to true
//     this.controller, // Initialize the controller parameter
//     this.onTap, // Initialize the onTap parameter
//   }) : super(key: key);
//
//   @override
//   _CurvedTextFieldState createState() => _CurvedTextFieldState();
// }
//
// class _CurvedTextFieldState extends State<CurvedTextField> {
//   late bool obscureText;
//
//   @override
//   void initState() {
//     super.initState();
//     obscureText = widget.obscureText;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double calculatedBorderRadius = widget.borderRadius ?? MediaQuery.of(context).size.width * 0.02;
//     double calculatedSemiCircleWidth = widget.semiCircleWidth ?? MediaQuery.of(context).size.width * 0.08;
//     double calculatedPaddingStart = widget.paddingStart ?? MediaQuery.of(context).size.width * 0.1;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(calculatedBorderRadius),
//           bottomLeft: Radius.circular(calculatedBorderRadius),
//           topRight: Radius.circular(calculatedBorderRadius),
//           bottomRight: Radius.circular(calculatedBorderRadius),
//         ),
//         border: Border.all(
//           color: Color(0xFF808080), // Grey border color
//           width: 1.0, // Border width
//         ),
//       ),
//       child: Stack(
//         children: [
//           if (widget.showPositionedBox)
//             Positioned(
//               left: 0,
//               top: 0,
//               bottom: 0,
//               child: Container(
//                 width: calculatedSemiCircleWidth,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(calculatedBorderRadius),
//                     bottomLeft: Radius.circular(calculatedBorderRadius),
//                   ),
//                   border: Border(
//                     right: BorderSide(
//                       color: Color(0xFF808080),
//                       width: 1.0,
//                     ),
//                   ),
//                 ),
//                 child: Center(
//                   child: widget.prefixIcon != null
//                       ? Icon(
//                     widget.prefixIcon,
//                     color: Colors.grey[400],
//                   )
//                       : null,
//                 ),
//               ),
//             ),
//           Padding(
//             padding: EdgeInsets.only(
//               left: widget.showPositionedBox ? calculatedPaddingStart : MediaQuery.of(context).size.width * 0.05,
//             ),
//             child: TextFormField(
//               controller: widget.controller,
//               decoration: InputDecoration(
//                 hintText: widget.hintText,
//                 border: InputBorder.none,
//                 suffixIcon: widget.suffixIcon != null // Check if suffixIcon is provided
//                     ? GestureDetector(
//                   onTap: widget.onTap, // Use onTap function directly
//                   child: Icon(
//                     widget.suffixIcon,
//                     color: Colors.grey[400],
//                   ),
//                 )
//                     : null,
//               ),
//               obscureText: obscureText,
//               onChanged: (value) {
//                 // Handle input changes if needed
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
