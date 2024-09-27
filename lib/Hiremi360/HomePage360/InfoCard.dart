
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String description;
  final double width;
  final String imagePath;  // New parameter for the image path
  final double height;
  final Gradient gradient; // New gradient parameter

  const InfoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.width,
    required this.imagePath,  // Image path is required
    required this.height,
    required this.gradient, // Receive the gradient from parent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageSize = screenWidth * 0.2; // Image size based on screen width
    double gradientWidth = screenWidth * 0.25; // Adjust the percentage as needed
    double gradientHeight = screenHeight * 0.12;
    double cardPadding = screenWidth * 0.04;
    double titleFontSize = screenWidth * 0.05;
    double descriptionFontSize = screenWidth * 0.023;

    return Stack(
      children: [
        // Main card
        Container(
          width: width,
          height: height,
          child: Card(
            color: Colors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize * 0.8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.013),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: descriptionFontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.015),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Learn More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.025,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //Circular gradient overlay
        Positioned(
          bottom: screenHeight * 0.012,  // Adjusted based on screen height
          right: screenWidth * 0.03,
          child: Stack(
            children: [
              Container(
                width: gradientWidth,
                height: gradientHeight,
                decoration: BoxDecoration(
                  gradient: gradient, // Use the passed gradient here
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(104.66),
                  ),
                ),
                // child: Opacity(
                //   opacity: 1,
                //   child: Container(),
                // ),
              ),
              Positioned(
                top: gradientHeight * 0.4,  // Responsive top position
                right: screenWidth * 0.02,  // Adjusted image position
                child: Image.asset(
                  imagePath,  // Use the dynamic image path here
                  width: imageSize,  // Responsive image size
                  height: imageSize,  // Responsive image size
                ),
              ),
            ],
          ),

        ),
        // Positioned(
        //   top: screenHeight * 0.101, // Adjust based on screen height
        //   left: screenWidth * 0.71, // Adjust based on screen width
        //   child: Stack(
        //     children: [
        //       Container(
        //         width: gradientWidth, // Adjust the size based on screen width
        //         height: gradientHeight, // Adjust the size based on screen height
        //         decoration: BoxDecoration(
        //           gradient: LinearGradient(
        //             colors: [
        //               Color.fromRGBO(135, 229, 251, 0.16),
        //               Color.fromRGBO(42, 9, 139, 0.16),
        //             ],
        //             begin: Alignment.topLeft,
        //             end: Alignment.bottomRight,
        //           ),
        //           shape: BoxShape.circle, // Makes the base shape a circle
        //         ),
        //         // Clip the circle to get the cut-off effect
        //         clipBehavior: Clip.hardEdge,
        //         child: Align(
        //           alignment: Alignment.bottomRight,
        //           child: Container(
        //             width: gradientWidth * 0.75, // Adjust to clip part of the circle
        //             height: gradientHeight * 0.75, // Adjust to clip part of the circle
        //             color: Colors.transparent, // Ensure transparency where clipped
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         top: gradientHeight * 0.4, // Adjust position based on gradient height
        //         right: screenWidth * 0.02, // Adjust based on screen width
        //         child: Image.asset(
        //           imagePath, // Use the dynamic image path here
        //           width: imageSize, // Responsive image size
        //           height: imageSize, // Responsive image size
        //         ),
        //       ),
        //     ],
        //   ),
        // ),





      ],
    );
  }
}
