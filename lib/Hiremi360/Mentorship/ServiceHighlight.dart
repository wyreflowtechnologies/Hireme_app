// benefit_tile.dart (or any name you choose)
import 'package:flutter/material.dart';

class Servicehighlight extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      // Your existing widget code
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816.png",
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (1).png",
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (2).png",
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (4).png",
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.87,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (5).png",
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (6).png",
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
        SizedBox(height:screenWidth*0.0499 ,),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (7).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "7.Referral Program",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.037,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Receive tailored mentorship aligned with\nyour career goals and aspirations.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.024,
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (8).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "8.Personal Branding",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Social media and LinkedIn profile\noptimization to enhance visibility to\nrecruiters.",
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.23,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (9).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "9.Internship Certification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Verified internship completion\ncertificatesfrom partner companies.",
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.29,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (10).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "10.Career Growth Analytics",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Our mentorship program provides\npersonalized growth tracking with detailed\nprogress reports and regular skill feedback.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.024,
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
            color: const Color.fromARGB(255, 245, 235, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * 0.83,
          height: MediaQuery.of(context).size.width * 0.28,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Adjust the image size to fit properly
              Image.asset(
                "images/Group 33816 (11).png",
                width: MediaQuery.of(context).size.width * 0.212, // Adjust this as needed
                height: MediaQuery.of(context).size.width * 0.22,
              ),
              const SizedBox(width: 10), // Add spacing between the image and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    "11.College to Corporate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      //fontSize: 16
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                  SizedBox(height: 5), // Add some space between the title and description
                  Text(
                    "Our program prepares students for\ncorporate life with training in culture,\noffice environment, job readiness\n, and work-lifebalance.",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.0255,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height:screenWidth*0.0499 ,),
      ],
    );
  }
}
