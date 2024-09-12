
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';





class Education extends StatelessWidget {
  const Education({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(title: 'Education',child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const EducationChild(
          course: 'B.Tech, CSE',
          place: 'Bhopal, Madhya Pradesh',
          duration: '2021-2025 | Percentage: 70.00%',
        ),
         SizedBox(height: Sizes.responsiveSm(context)),
        Divider(height: 0.25,thickness: 0.25,color: AppColors.secondaryText,),
        SizedBox(height: Sizes.responsiveMd(context)),
        const EducationChild(
          course: '12th, Math’s Stream',
          place: 'Bhopal, Madhya Pradesh',
          duration: '2021-2020 | Percentage: 84.00%',
        ),
        SizedBox(height: Sizes.responsiveSm(context)),
        Divider(height: 0.25,thickness: 0.25,color: AppColors.secondaryText,),
        SizedBox(height: Sizes.responsiveMd(context)),
        const EducationChild(
          course: '10th, All Subjects',
          place: 'Bhopal, Madhya Pradesh',
          duration: '2019-2018 | Percentage: 84.02%',
        ),
      ],
    ),);
  }
}

class EducationChild extends StatelessWidget {
  const EducationChild({
    Key? key, required this.course, required this.place, required this.duration,

  }) : super(key: key);

  final String course,place,duration;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(course,style: const TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w500,
        ),),
         SizedBox(height: Sizes.responsiveXs(context),),
         Text(place,style: const TextStyle(
          fontSize: 7.5,
          fontWeight: FontWeight.w400,
        ),),
        SizedBox(height: Sizes.responsiveXxs(context),),
        Text(duration,style: TextStyle(
          fontSize: 7.5,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryText,
        ),),
      ],
    );
  }
}