// import 'package:flutter/material.dart';
//
//
//
// class RoundedImage extends StatelessWidget {
//   const RoundedImage({Key? key,  required this.image, required this.border}) : super(key: key);
//
//   final String image;
//   final Border border;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: border,
//         shape: BoxShape.circle
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(50),
//         child: Image.asset(image,height: 31.5,width: 31.5,),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class RoundedIconforInternship extends StatelessWidget {
  const RoundedIconforInternship({
    Key? key,
    required this.icon,
    required this.border,
    required this.iconSize,
  }) : super(key: key);

  final IconData icon;
  final Border border;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Container(
          height: iconSize,
          width: iconSize,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: iconSize - 10, // Adjust size to fit within the border
          ),
        ),
      ),
    );
  }
}
