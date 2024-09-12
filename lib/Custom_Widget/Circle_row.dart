import 'package:flutter/material.dart';

class CircleRow extends StatelessWidget {
  const CircleRow({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double circleSize = MediaQuery.of(context).size.width * 0.03;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: const BoxDecoration(
            color: Color(0xFFC1272D), // Color for the filled circle
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: circleSize * 0.6), // Spacing between circles
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Border color for empty circles
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: circleSize * 0.6),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: circleSize * 0.6),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: circleSize * 0.6),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
