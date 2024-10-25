
import 'dart:ui';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final List<Color> gradientColors;
  final Color outerContainerColor; // Parameter for outer container color

  // Constructor to accept custom title, description, gradient colors, and outer container color
  const FeatureCard({
    Key? key,
    required this.title,
    required this.description,
    this.gradientColors = const [
      Color(0xFFF249DC), // Default gradient color
      Color(0xFF1B1D9C),
    ],
    required this.outerContainerColor,
   // this.outerContainerColor = const Color.fromARGB(255, 245, 235, 255), // Default outer container color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    return Container(
      color: outerContainerColor, // Use the provided outer container color
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
                color: Colors.white, // Keep the inner container color as white
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
              child: Stack(
                children: [
                  // Content container
                  Column(
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

                  // Align the image to the bottom left
                  Positioned(
                    // top: screenWidth*0.069,
                     left: screenWidth*0.64,
                    child: Image.asset(
                      'images/Group 33817.png', // Replace with your image asset path
                      width: screenWidth * 0.2, // Adjust the image size
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
