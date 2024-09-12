import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';

class QueryStartingScreen extends StatelessWidget {
  const QueryStartingScreen({Key? key, this.onTap}) : super(key: key);

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Sizes.responsiveXxl(context),
          ),
          const Text(
            'Purpose :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Sizes.responsiveXs(context),
          ),
          const Text(
            'To resolve queries related to our services or career progression and provide ongoing support throughout your career journey',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: Sizes.responsiveXxl(context),
          ),
          const Text(
            'Process :',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Sizes.responsiveXs(context),
          ),
          const Text(
            '• 10-minute meeting will be scheduled by our team.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const Text(
            '• A HireMi mentor will address and clarify your queries.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const Text(
            '• You can raise additional queries every 15 days.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: Sizes.responsiveXxl(context),
          ),
          const Text(
            'For more advanced mentorship, personalized guidance, and roadmap creation throughout your academic journey, enroll in the Mentorship Plan.',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: Sizes.responsiveXxl(context),
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: onTap,
              child: const Text(
                'Continue',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
