import 'package:flutter/material.dart';

// Reusable Text Widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double paddingRight;

  const ResponsiveText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.paddingRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

// Reusable Image Widget
class ResponsiveImage extends StatelessWidget {
  final String imagePath;
  final double size;

  const ResponsiveImage({
    Key? key,
    required this.imagePath,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
    );
  }
}
