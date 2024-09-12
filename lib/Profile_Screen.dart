import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/PersonalLinks.dart';

import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/widgets_mustufa/BasicDetails.dart';
import 'package:hiremi_version_two/widgets_mustufa/Education.dart';
import 'package:hiremi_version_two/widgets_mustufa/Experience.dart';
import 'package:hiremi_version_two/widgets_mustufa/KeySkills.dart';
import 'package:hiremi_version_two/widgets_mustufa/Languages.dart';
import 'package:hiremi_version_two/widgets_mustufa/PersonalInfo.dart';
import 'package:hiremi_version_two/widgets_mustufa/ProfileStatusSection.dart';
import 'package:hiremi_version_two/widgets_mustufa/ProfileSummary.dart';
import 'package:hiremi_version_two/widgets_mustufa/Projects.dart';
import 'package:hiremi_version_two/widgets_mustufa/ResumeSection.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,


      body:SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: Sizes.responsiveDefaultSpace(context),
                right: Sizes.responsiveDefaultSpace(context),
                top: Sizes.responsiveDefaultSpace(context),
                bottom: Sizes.responsiveXxl(context) * 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfileStatusSection(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Divider(
                  height: 0.25,
                  thickness: 0.5,
                  color: AppColors.secondaryText,
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                ResumeSection(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                const BasicDetails(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                const ProfileSummary(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                KeySkills(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Education(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                const Experience(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                const Projects(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),

                const PersonalInfo(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                const PersonalLinks(),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),

                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                const Languages()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
