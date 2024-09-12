
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/Elevated_Button.dart';

class ContainerWithCurvedEdges extends StatelessWidget {

  final double heightFactor; // Use a factor to make the height responsive
  final double percentage; // Add percentage parameter


  const ContainerWithCurvedEdges({
    Key? key,
    required this.heightFactor,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Calculate the height based on the height factor and screen height
    double height = screenSize.height * heightFactor;
    double width = screenSize.width;

    // Set responsive border radius and padding
    double borderRadius = screenSize.width * 0.05; // 5% of screen width
    double borderWidth = screenSize.width * 0.01; // 1% of screen width
    double paddingValue = screenSize.width * 0.01; // 1% of screen width

    // Size of the circular indicator
    double indicatorSize = screenSize.width * 0.2; // 20% of screen width

    return Container(
      height: height * 0.59,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.grey.shade200, // Light border color
          width: borderWidth,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 12,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1659DC),
                    Color(0xFF6EA6FA),

                  ],

                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius - borderWidth),
                  topRight: Radius.circular(borderRadius - borderWidth),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: paddingValue * 5), // Adjust the left padding as needed
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.1, // 10% of screen height
                          left: MediaQuery.of(context).size.width * 0.20, // 10% of screen width
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Complete & Verify Your Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.94,
                              ),
                            ),
                         
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.65),
                        child: Container(
                          width: indicatorSize,
                          height: indicatorSize,
                          decoration: BoxDecoration(
                            color: Colors.white, // Make the background white
                            shape: BoxShape.circle,
                          ),
                          child: CircularProgressIndicator(
                            value: percentage / 100,
                            strokeWidth: 8.0,
                            backgroundColor: Colors.white, // Set the background color to white
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF34AD78)), // Set the progress bar color to #34AD78
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.65),
                        child: Text(
                          "${percentage.toInt()}%",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.05, // Responsive font size
                            color: Color(0xFF34AD78),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ..._buildProgressIndicator(context,4 as int, percentage as double),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.024,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFF9F9), // Replace white with #FFF9F9
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius - borderWidth),
                  bottomRight: Radius.circular(borderRadius - borderWidth),
                ),
                border: Border.all(
                  color: Colors.grey.shade100, // Dark border color
                  width: borderWidth,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(paddingValue), // Set padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenSize.height * 0.01), // 1% of screen height
                    Text(
                      "Harsh Pawar",
                      style: TextStyle(
                        fontSize: screenSize.width * 0.05, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.01), // 1% of screen height
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "App ID: -----",
                          style: TextStyle(
                            fontSize: screenSize.width * 0.04, // Responsive font size
                          ),
                        ),
                        CustomElevatedButton(
                          text: "Verify Now >",
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          color: Color(0xFF34AD78), // Optional
                          width:  screenSize.height * 0.13, // Optional
                          height: screenSize.height * 0.04, // Optional
                          borderRadius: 10.0, // Optional
                          textStyle: TextStyle(color: Colors.white, fontSize: 10.7), // Optional
                        ),

                      ],
                    ),
                    SizedBox(height: screenSize.height * 0.02), // Spacer before progression bar
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build the custom progress indicator with circles and lines
  List<Widget> _buildProgressIndicator(BuildContext context,int numberOfSteps, double percentage) {
    final double heighetwo;
    heighetwo=MediaQuery.of(context).size.height;
    List<Widget> steps = [];

    // Calculate the number of circles to be filled based on percentage
    int filledSteps = (percentage * numberOfSteps / 100).ceil();

    // Build the progress indicator with icons
    for (int i = 0; i < numberOfSteps; i++) {
      steps.add(
        Container(
          width: MediaQuery.of(context).size.width*0.056, // Adjust based on your design
          height:MediaQuery.of(context).size.height*0.35, // Adjust based on your design
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i < filledSteps ? Color(0xFF34AD78) : Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: i == 0
                ? Icon(Icons.check, color: i < filledSteps ?Colors.white :  Color(0xFFC1272D) , size: 15.0) // Tick icon
                : i == 1
                ? Icon(Icons.phone, color: i < filledSteps ? Colors.white:  Color(0xFFC1272D), size: 15.0) // Phone icon
                : i == 2
                ? Icon(Icons.school, color: i < filledSteps ? Colors.white :  Color(0xFFC1272D), size: 15.0) // Graduation cap icon
                : i == 3
                ? Icon(Icons.account_balance, color: i < filledSteps ? Colors.white:  Color(0xFFC1272D), size: 15.0) // Institution icon
                : null,
          ),
        ),
      );
      if (i != numberOfSteps - 1) {
        steps.add(
          Expanded(
            child: Container(
              height:MediaQuery.of(context).size.height*0.002, // Adjust based on your design
              color: i < filledSteps - 1 ? Color(0xFF34AD78) : Colors.grey,
            ),
          ),
        );
      }
    }

    return steps;
  }
}
