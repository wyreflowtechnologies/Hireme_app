import 'package:flutter/material.dart';


import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';



class EligibilityCriteriaAboutCompany extends StatelessWidget {
  const EligibilityCriteriaAboutCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Eligibility Criteria',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary)),
        SizedBox(
          height: Sizes.responsiveMd(context),
        ),
        Padding(
          padding: EdgeInsets.only(left: Sizes.responsiveXxs(context)),
          child: Column(
            children: [
              buildBulletPoint(
                  context: context,
                  number: '1.',
                  text:
                  'Educational Qualification: BE/B.TECH/M.TECH/MCA/MBA/BCA/BSC/MSC or equivalent.'),
              buildBulletPoint(
                  context: context,
                  number: '2.',
                  text: 'Branch: All branches are eligible.'),
              buildBulletPoint(
                  context: context,
                  number: '3.',
                  text:
                  'Skills and Interests: Relevant skills and a keen interest in recruitment and talent acquisition.'),
            ],
          ),
        ),
        SizedBox(
          height: Sizes.responsiveLg(context),
        ),
        Text('About CRTD Technologies Company',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary)),
        SizedBox(
          height: Sizes.responsiveSm(context),
        ),
        const Text(
            'Hiremi is a platform connecting job seekers with employment opportunities. We strive to bridge the gap between talent and industry, fostering career growth and professional development.',
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
            )),
      ],
    );
  }
}


Padding buildBulletPoint(
    {required String text,
      required String number,
      required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: Sizes.responsiveXxs(context)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number ',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ))
      ],
    ),
  );
}
