
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Hiremi360/CorporateTraining/CorporateTraining.dart';
import 'package:hiremi_version_two/Hiremi360/HomePage360/CustomCarouselSlider.dart';
import 'package:hiremi_version_two/Hiremi360/HomePage360/InfoCard.dart';
import 'package:hiremi_version_two/Hiremi360/HomePage360/responsive_widget.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/Mentorship.dart';
import 'package:hiremi_version_two/Hiremi360/NavigationANimation/NavigationAnimation.dart';
import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/TrainingAndInternships.dart';

class Homepage360 extends StatefulWidget {
  const Homepage360({Key? key}) : super(key: key);

  @override
  State<Homepage360> createState() => _Homepage360State();
}

class _Homepage360State extends State<Homepage360> {
  final List<String> imgList = List.filled(3, 'images/Banner.png'); // Use List.filled for repeated images

  final List<Map<String, String>> infoCards = [
    {
      'title': 'Mentorship Program',
      'description': 'Personalized guidance from industry experts to help\nindividuals achieve their career goals.',
      'image': 'images/Group 33783.png',
    },
    {
      'title': 'Corporate Training',
      'description': "Customized training solution designed to enhance the skills\n and productivity of a company's workforce.",
      'image': 'images/Group 33783.png',
    },
    {
      'title': 'Training Program',
      'description': "Comprehensive training modules to boost\nskills and career development.",
     'image': 'images/Group 33783.png',
    },
  ];
  final List<Gradient> gradients = [
    LinearGradient(
      colors: [
        Color.fromRGBO(135, 229, 251, 0.2), // Light effect
        Color.fromRGBO(42, 9, 139, 0.2), // Glow effect
      ],
      begin: Alignment(0.4, 0.5),
      end: Alignment(-0.9, 0.5),
      stops: [0.0, 1.0], // Full
    ),
    LinearGradient(
      colors: [
        Color.fromRGBO(135, 229, 251, 0.16), // First color with RGBA values
        Color.fromRGBO(42, 9, 139, 0.16),    // Second color with RGBA values
      ],
      begin: Alignment(0.1, 0.5),  // Starting point of the gradient
      end: Alignment(-0.6, 0.5),   // Ending point of the gradient
      stops: [0.1047, 0.9086],     // Color stops as per your request (10.47% and 90.86%)
    ),

    LinearGradient(
      colors: [
        Color.fromRGBO(255, 100, 0, 0.4),
        Color.fromRGBO(0, 200, 100, 0.2),
      ],
      begin: Alignment(0.4, 0.5),
      end: Alignment(-0.6, 0.5),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenWidth * 0.07),
            _buildCarousel(screenWidth),
            _buildSectionTitle("Hiremi 360's Featured", screenWidth*1.13),
            _buildImageRow(screenWidth),
            _buildInfoSection(screenWidth),
          //  _buildFooterImage(screenWidth),
            SizedBox(height: screenWidth*0.08,),
            Image.asset(
              "images/Banner.png",

            ),
            SizedBox(height: screenWidth*0.08,),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(double screenWidth) {
    return CustomCarouselSlider(
      imgList: imgList,
      height: screenWidth * 0.42,
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
      child: ResponsiveText(
        text: title,
        fontSize: screenWidth * 0.04,
        paddingRight: screenWidth * 0.185 * 1.69,
      ),
    );
  }

  Widget _buildImageRow(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // For Mentorship image, add GestureDetector to navigate to MentorshipPage
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(createBottomToTopRoute(Mentorship())); // Use custom route
          },
          child: _buildResponsiveImage('images/Mentorship.png', screenWidth),
        ),
        GestureDetector(
            onTap: (){
              Navigator.of(context).push(createBottomToTopRoute(CorporateTraining()));

            },
            child: _buildResponsiveImage('images/Corporate Training.png', screenWidth)),
        GestureDetector(
            onTap: (){
              Navigator.of(context).push(createBottomToTopRoute(TrainingAndInternships()));
            },
            child: _buildResponsiveImage('images/Training.png', screenWidth)),
      ],
    );
  }


  Widget _buildResponsiveImage(String imagePath, double screenWidth) {
    return ResponsiveImage(
      imagePath: imagePath,
      size: screenWidth * 0.299,
    );
  }

  Widget _buildInfoSection(double screenWidth) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF1F5FF)),
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Column(
        children: [
          _buildSectionTitle("Learn More About Programs", screenWidth),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.098),
            child: Text(
              "If You Don’t Know How to Use the Featured Programs of Hiremi360, Follow This\nGuide.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.02, // Adjusted font size for readability
              ),
            ),
          ),
          // Map through the cards and pass different gradients
          ...List.generate(infoCards.length, (index) {
            return _buildInfoCard(infoCards[index], screenWidth, gradients[index]);
          }).toList(),
        ],
      ),
    );
  }


  Widget _buildInfoCard(Map<String, String> card, double screenWidth,Gradient gradient) {
    return Center(
      child: InfoCard(
        title: card['title']!,
        description: card['description']!,
        imagePath: card['image']!,  // Pass the image path
        width: screenWidth * 0.97,
        height: screenWidth * 0.4,
        gradient: gradient, // Pass the gradient here
      ),
    );
  }

  Widget _buildFooterImage(double screenWidth) {
    return ResponsiveImage(
      imagePath: "images/Banner.png",
      size: screenWidth,
    );
  }
}
