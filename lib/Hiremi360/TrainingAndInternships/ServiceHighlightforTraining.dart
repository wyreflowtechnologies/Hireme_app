// benefit_tile.dart (or any name you choose)
import 'package:flutter/material.dart';

class Servicehighlightfortraining extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      // Your existing widget code
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 245, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/TrainingandInternship.png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "1. Personalized Guidance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Receive tailored mentorship aligned with\nyour career goals and aspirations.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.026,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height:screenWidth*0.0499 ,),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 245, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Trainingandinternship (2).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "2. Industry Insights",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Gain practical knowledge from industry\nexperts, diving deep into the IT world.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.026,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height:screenWidth*0.0499 ,),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 245, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Trainingandinternship (5).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "3.Skill Development",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Enhance your skill set with curated\nprograms designed to make you job-\nready.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.026,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height:screenWidth*0.0499 ,),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 245, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Trainingandinternship (4).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "4.Networking Opportunities",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Expand your professional network with\nconnections that can influence\nyour career trajectory.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.026,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height:screenWidth*0.0499 ,),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 245, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Trainingandinternship (3).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "5.Confidence Building",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Receive tailored mentorship\naligned with your career\ngoals and aspirations.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.026,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height:screenWidth*0.0499 ,),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 245, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                "images/Trainingandinternship (5).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  Text(
                    "6.Guaranteed Internships",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Secure internships in your chosen field and\ngain hands-on experience to kickstart your\nprofessional journey.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.024,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
