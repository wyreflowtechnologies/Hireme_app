import 'package:flutter/material.dart';


class CustomAlert2 extends StatefulWidget {
  const CustomAlert2({Key? key, }) : super(key: key);

  @override
  State<CustomAlert2> createState() => _CustomAlert2State();
}

class _CustomAlert2State extends State<CustomAlert2> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        width: screenWidth * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.5],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(screenHeight * 0.02),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('images/Group 33528.png')
            ),
            SizedBox(height: screenHeight * 0.01),
            const Text(
              'Query Generated!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            const Text(
              'Your Query Generated Successfully.',
              style: TextStyle(fontSize: 14.5,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenHeight * 0.02),
            const Text(
              'Hiremi will try to solve your issue, As soon as possible',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC1272D), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Go to Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}