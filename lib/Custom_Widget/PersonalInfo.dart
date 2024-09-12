import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';


class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key, 
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      title: 'Personal Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonalInfoChild(
            title: 'Gender',
            subtitle: 'Male',
          ),
          PersonalInfoChild(
            title: 'Marital Status',
            subtitle: 'Single / Unmarried',
          ),
          PersonalInfoChild(
            title: 'Date of Birth (DOB)',
            subtitle: '29-10-2002',
          ),
          PersonalInfoChild(
            title: 'Current Address',
            subtitle: 'Sheetal Mega City, Phase - 03, Mandideep, 462046',
          ),
          PersonalInfoChild(
            title: 'Permeant Address',
            subtitle: 'Sheetal Mega City, Phase - 03, Mandideep, 462046',
          ),
          PersonalInfoChild(
            title: 'Career Break',
            subtitle: 'No',
          ),
          PersonalInfoChild(
            title: 'Differently Abled',
            subtitle: 'No',
          ),
          PersonalInfoChild(
            title: 'Native Language',
            subtitle: 'Hindi',
          ),
        ],
      ),
    );
  }
}

class PersonalInfoChild extends StatelessWidget {
  const PersonalInfoChild({Key? key, 
    
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        SizedBox(
          height: Sizes.responsiveXs(context),
        ),
        Text(subtitle,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .apply(color: AppColors.secondaryText)),
        SizedBox(
          height: Sizes.responsiveSm(context),
        ),
        Divider(
          height: 0.25,
          thickness: 0.25,
          color: AppColors.secondaryText,
        ),
        SizedBox(
          height: Sizes.responsiveMd(context),
        ),
      ],
    );
  }
}