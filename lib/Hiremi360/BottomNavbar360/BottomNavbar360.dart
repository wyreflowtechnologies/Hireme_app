
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Hiremi360/HomePage360/HomePage360.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';

class BottomNavbar360 extends StatefulWidget {
  const BottomNavbar360({Key? key}) : super(key: key);

  @override
  State<BottomNavbar360> createState() => _BottomNavbar360State();
}

class _BottomNavbar360State extends State<BottomNavbar360> {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  late PageController _pageController;

  final List<String> _titles360 = [
    "Hiremi 360",
    'Applied',
    'Queries',
    'Profile'
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pages = [
      //Center(child: Text("Home Page")),
      Homepage360(),
      Center(child: Text("Applied Page")),
      Center(child: Text("Queries Page")),
      Center(child: Text("Profile Page")),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
          child: Text(
            _titles360[_selectedIndex],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,  // Text color is needed, but will be replaced by the gradient
            ),
          ),
        ),

        centerTitle: false,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 10, offset: Offset(4, 4))
          ],
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0),
            ),
            child: BottomAppBar(
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              elevation: 4,
              notchMargin: 15,
              child: Padding(
                padding: EdgeInsets.all(Sizes.responsiveXxs(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNavItem(Icons.home_filled, 'HOME', 0),
                    _buildNavItem(Icons.list_alt_rounded, 'APPLIED', 1),
                    SizedBox(width: Sizes.responsiveXxl(context)),
                    _buildNavItem(Icons.local_activity_outlined, 'QUERIES', 2),
                    _buildNavItem(Icons.person_outline, 'PROFILE', 3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Transform.scale(
        scale: pi * 0.4,
        child: Container(
          width: 60,  // Adjust the size for the gradient border
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Colors.redAccent, Colors.blueAccent], // Border gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.5), // Add padding to create the border effect
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Inner container background color
              ),
              child: FloatingActionButton(
                onPressed: () {
                  // Add functionality here
                },
                elevation: 2,
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Color(0xFFC1272D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.all_inclusive,
                        color: Colors.white, // The color is now provided by the gradient
                        size: 20,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Color(0xFFC1272D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'HIREMI',
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color will be replaced by the gradient
                        ),
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Color(0xFFC1272D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        '360',
                        style: TextStyle(
                          fontSize: 6,
                          color: Colors.white, // Text color will be replaced by the gradient
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        _pageController.jumpToPage(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: _selectedIndex == index
                ? const Color(0xFFC1272D)
                : Colors.black,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
