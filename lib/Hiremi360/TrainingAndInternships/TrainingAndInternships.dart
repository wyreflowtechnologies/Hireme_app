import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/FeatureCard.dart';
import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/ServiceHighlightforTraining.dart';
import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/YourProgram.dart';

class TrainingAndInternships extends StatefulWidget {
  const TrainingAndInternships({Key? key}) : super(key: key);

  @override
  State<TrainingAndInternships> createState() => _TrainingAndInternshipsState();
}

class _TrainingAndInternshipsState extends State<TrainingAndInternships> {
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
            "Training + Internships",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,  // Text color is needed, but will be replaced by the gradient
            ),
          ),
        ),

        centerTitle: false ,
      ),
      body:  SingleChildScrollView(
            child:Column(
              children: [
                Text("Why Choose Hiremi Training +\nInternship?",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.053,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                Padding(
                  padding:  EdgeInsets.only(left:screenWidth* 0.045),
                  child: Text("The 360° Training + Internship Program at Hiremi is\ndesigned to tackle the challenges college students face\nin securing internships due to limited practical skills and\nexperience.",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:screenWidth*0.0315,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                Padding(
                  padding:  EdgeInsets.only(left:screenWidth* 0.045),
                  child: Text("We serve as your career bridge, connecting you to\nvaluable internships with our client companies while\nproviding the necessary training to help you excel.\nEngage in real projects that offer hands-on experience\nand essential knowledge, empowering you in your\ncareer journey. Let’s take this exciting step together and\nunlock your potential!",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:screenWidth*0.0315,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: screenWidth*0.0442),
                  child: Image.asset(
                    "images/Group 33784 (2).png",
                    width: screenWidth*0.92,
                    height: screenWidth*0.47,
                  ),
                ),
                const FeatureCard (
                  title: "College Students",
                  description: "Our Training + Internship assists students in\nnavigating their academic journey, making informed\ncareer choices, and preparing for the professional\nworld.",
                  gradientColors: [
                    Color(0xFFEFC59B), // Start color
                    Color(0xFF95152F), // End color
                  ],
                     outerContainerColor: Color.fromARGB(255, 255, 245, 234)
                ),
                SizedBox(height:screenWidth*0.08 ,),
                YourProgram(),
                SizedBox(height:screenWidth*0.0383 ,),
                Text("Why Choose Hiremi Training + Internship Program?",
                   textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.054,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:screenWidth*0.0183 ,),
                Text("The Advantages of Hiremi 360's program",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.034,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height:screenWidth*0.0383 ,),
                Servicehighlightfortraining(),
                SizedBox(height:screenWidth*0.0383 ,),
              ],
            ) ,
      ),
    );
  }
}
