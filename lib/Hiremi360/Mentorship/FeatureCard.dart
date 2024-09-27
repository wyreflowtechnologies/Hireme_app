import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final List<Color> gradientColors;

  // Constructor to accept custom title, description, and gradient colors
  const FeatureCard({
    Key? key,
    required this.title,
    required this.description,
    this.gradientColors = const [
      Color(0xFFF249DC), // Default gradient color
      Color(0xFF1B1D9C),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color.fromARGB(255, 245, 235, 255),
      width: screenWidth,
      child: Column(
        children: [
          SizedBox(height: screenWidth * 0.05),
          Text(
            "Whom Does it help?",
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Add on for College Students",
            style: TextStyle(
              fontSize: screenWidth * 0.029,
            ),
          ),
          Container(
            width: screenWidth * 0.97,
            margin: EdgeInsets.all(screenWidth * 0.04),
            padding: EdgeInsets.all(screenWidth * 0.005), // Thickness of the border
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.04), // Rounded corners
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: gradientColors,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.white, // Content background
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Heading
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  // Content
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.023,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
