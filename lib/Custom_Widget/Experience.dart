import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';


class Experience extends StatelessWidget {
  const Experience({Key? key, 
  }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return  OutlinedContainer(
      title: 'Experience',
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ExperienceChild(
            title: 'Flutter UI Developer',
            company: 'CRTD Technologies',
            jobType: 'Remote',
            timing: 'Full time • Aug 2024 - Present',
          ),
          SizedBox(height: Sizes.responsiveMd(context),),
          const ExperienceChild(
            title: 'Backend Developer',
            company: 'CRTD Technologies',
            jobType: 'Bhopal, Madhya Pradesh, India',
            timing: 'Full time • Jul 2024 - Aug 2024',
          ),
        ],
      ),
    );
  }
}

class ExperienceChild extends StatelessWidget {
  const ExperienceChild({Key? key, 
     required this.title, required this.jobType, required this.company, required this.timing,
  }) : super(key: key);

  final String title,jobType,company,timing;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.apartment,size:25,color: AppColors.primary,),
        const SizedBox(width: 12,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),),
             SizedBox(height: Sizes.responsiveXs(context),),
            Text(jobType,style: const TextStyle(
              fontSize: 6.5,
              fontWeight: FontWeight.w400,
            ),),
            SizedBox(height: Sizes.responsiveXxs(context),),
            Text(company,style: const TextStyle(
              fontSize: 6.5,
              fontWeight: FontWeight.w400,
            ),),
            SizedBox(height: Sizes.responsiveXxs(context),),
            Text(timing,style: TextStyle(
              fontSize: 6.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryText,
            ),),
            Divider(height: 0.25,thickness: 0.25,color: AppColors.secondaryText,),
          ],
        )
      ],
    );
  }
}
