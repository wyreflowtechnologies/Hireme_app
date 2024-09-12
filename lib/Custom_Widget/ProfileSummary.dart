import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Utils/colors.dart';



class ProfileSummary extends StatelessWidget {
  const ProfileSummary({Key? key, 
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      title: 'Profile Summary',
      child: Column(
        children: [
          Text(
              'I’m a fresher and looking for internships, I\'ve a skillset including Web Development from frontend work to backend work, Development from frontend work to backend work.',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              )),
        ],
      ),
    );
  }
}