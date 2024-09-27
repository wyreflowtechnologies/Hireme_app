import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/FeatureCard.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/ServiceHighlight.dart';


class Mentorship extends StatefulWidget {
  const Mentorship({Key? key}) : super(key: key);

  @override
  State<Mentorship> createState() => _MentorshipState();
}

class _MentorshipState extends State<Mentorship> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.redAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
          "Mentorship",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,  // Text color is needed, but will be replaced by the gradient
            ),
          ),
        ),

        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("  Why Choose Hiremi Mentorship\n  Program?",
               // textAlign: TextAlign.center,
                style: TextStyle(
                fontSize:screenWidth*0.058,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                Text("At Hiremi, our mentorship program connects students\nwith experienced mentors to help them grow\nacademically and professionally.",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.0315,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                Text("Through this supportive partnership, students get\nguidance for their career or studies, along with the\nopportunity for an assured internship to kickstart their\ncareer.",
                  style: TextStyle(
                    fontSize:screenWidth*0.0315,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: screenWidth*0.012),
                  child: Image.asset(
                    "images/Group 33784 (1).png",
                    width: screenWidth*0.92,
                    height: screenWidth*0.47,
                  ),
                ),

                const FeatureCard (
                  title: "College Students",
                  description: "Our mentorship program assists students in\nnavigating their academic journey, making informed\ncareer choices, and preparing for the professional\nworld.",
                  gradientColors: [
                    Color(0xFFF249DC), // #F249DC // You can pass custom gradient colors
                    Color(0xFF1B1D9C),
                  ],
                ),

                SizedBox(height:screenWidth*0.08 ,),
                Container(
                  color:const Color.fromARGB(255, 245, 235, 255),
                  width: MediaQuery.of(context).size.width,
                  // height:MediaQuery.of(context).size.width ,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.017),

                      Text(
                        "One Time Program Pricing",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.065,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Mentorship",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.037,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width:MediaQuery.of(context).size.width*0.97 ,
                        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Outer margin for spacing
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005), // This controls the thickness of the border
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04), // Rounded corners for the border
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFF249DC), // #F249DC
                              Color(0xFF1B1D9C), // #1B1D9C
                            ],
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Inner padding for content inside the border
                          decoration: BoxDecoration(
                            color: Colors.white,  // Card content background
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.035), // Rounded corners slightly smaller to match border
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Heading
                              SizedBox(height:screenWidth*0.02 ,),
                              Text(
                                'Standard Package',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size for heading
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Responsive space between heading and content

                              // Content
                              Text(
                                'One year Program',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.030, // Responsive font size for content
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                              Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the elements evenly
                                children: [
                                  // Price Label
                                  Text(
                                    '₹ 10,000',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.048, // Responsive font size for content
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Cut Price
                                  SizedBox(width: screenWidth*0.01,),
                                  Text(
                                    '₹ 25,000',
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.036, // Responsive font size for cut price
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey, // Optional: Make it red to indicate it's cut
                                      decoration: TextDecoration.lineThrough, // Add line-through decoration
                                      decorationColor: Colors.grey,
                                    ),
                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10), // Circular edges
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFFF249DC), // Start color
                                          Color(0xFF1B1D9C), // End color
                                        ],
                                      ),
                                      border: Border.all(
                                        width: 1, // Border thickness
                                        color: Colors.transparent, // Use transparent color to allow gradient
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Padding for the container
                                    child: const Text(
                                      '40% Off',
                                      style: TextStyle(
                                        color: Colors.white, // Text color inside the container
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.023),



                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Note:Entire academic year + one extra year.Dive deep into essential skills and knowledge for success with our mentorship program.',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.028, // Responsive font size for content
                                color: Colors.grey[700],
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:screenWidth*0.06 ,),

                Text("Why Choose Hiremi Mentorship?",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.054,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:screenWidth*0.0083 ,),

                Text("The Advantages of Hiremi 360's program",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.034,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height:screenWidth*0.0383 ,),


                Servicehighlight(),
                Padding(
              padding:  EdgeInsets.only(left: screenWidth*0.058),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Unlock Your Potential with ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.black, // Default color
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: 'Hiremi',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.red, // Red color for 'Hiremi'
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.black, // Default color for '&'
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    WidgetSpan(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: <Color>[Colors.redAccent, Colors.blueAccent],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Hiremi 360',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            color: Colors.white, // This will be masked by the gradient
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
                SizedBox(height:screenWidth*0.0383 ,),
                Padding(
                  padding:  EdgeInsets.only(left: screenWidth*0.045),
                  child: Text("Experience the perfect blend of Mentorship and\npersonalized guidance to help you succeed in your\ncareer journey.",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                SizedBox(height:screenWidth*0.0383 ,),
                Image.asset("images/Group 33822.png"),
                SizedBox(height:screenWidth*0.0999 ,),


                SizedBox(height:screenWidth*0.0383 ,),


              ],
            ),

          ),
          Positioned(
            bottom: 16, // Distance from the bottom of the screen
            left: MediaQuery.of(context).size.width * 0.075, // Adjust as needed
            right: MediaQuery.of(context).size.width * 0.075, // Adjust as needed
            child: SizedBox(
              width:screenWidth*0.95 ,
              height:screenWidth*0.099 ,
              child: ElevatedButton(

                onPressed: () {
                  // Your onPressed action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Use transparent for gradient
                  //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Adjust padding
                  shadowColor: Colors.transparent, // Remove default shadow if needed
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF249DC), // Start color
                        Color(0xFF1B1D9C), // End color
                      ],
                      stops: [0.1047, 0.9086], // Stops for the gradient
                    ),
                    borderRadius: BorderRadius.circular(4), // Optional: rounded corners
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Enroll Now",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Text size
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
