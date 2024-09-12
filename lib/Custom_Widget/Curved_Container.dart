
import 'package:flutter/material.dart';

class CurvedContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;

  const CurvedContainer({
    Key? key,
    this.child,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures the container takes full width
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Changes position of shadow
          ),
        ],
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth ?? 1.0,
        ),
      ),
      // height: height ?? 70.0,
      child: child,
    );
  }
}
