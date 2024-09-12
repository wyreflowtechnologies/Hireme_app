import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool enabled; // New parameter

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.width,
    this.height,
    this.borderRadius = 3.0,
    this.textStyle,
    this.enabled = true, // Default is enabled
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.84, // Default width
      height: height ?? MediaQuery.of(context).size.height * 0.065, // Default height
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(

          backgroundColor: color ?? Color(0xFFC1272D), // Default color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledForegroundColor: color ?? Color(0xFFC1272D).withOpacity(0.38), disabledBackgroundColor: color ?? Color(0xFFC1272D).withOpacity(0.12),
        ),
        onPressed: enabled ? onPressed : null, // Disable button if not enabled
        child: Text(
          text,
          style: textStyle ?? TextStyle(color: Colors.white), // Default text style
        ),
      ),
    );
  }
}
