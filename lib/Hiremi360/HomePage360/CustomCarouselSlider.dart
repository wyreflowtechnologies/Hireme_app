
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatefulWidget {
  final List<String> imgList;
  final double height;

  const CustomCarouselSlider({
    Key? key,
    required this.imgList,
    required this.height,
  }) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0; // To track the current index

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Update the current index
              });
            },
          ),
          items: widget.imgList.map((item) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(item),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 8), // Space between carousel and dots
        _buildDotIndicator(),
      ],
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.imgList.length,
            (index) {
          // Create a gradient color for active and inactive dots
          final color = _currentIndex == index
              ? LinearGradient(
            colors: [Colors.redAccent, Colors.blueAccent],
          )
              : null;

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: color != null
                  ? color
                  : LinearGradient(
                colors: [Colors.grey, Colors.grey], // Inactive color
              ),
            ),
          );
        },
      ),
    );
  }

}
