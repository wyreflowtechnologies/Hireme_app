import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';

class EligibilityCriteriaAboutCompanyFresher extends StatelessWidget {
  final String education;
  final String whoCanApply;
  final String companyName;

  const EligibilityCriteriaAboutCompanyFresher({
    Key? key,
    required this.education,
    required this.whoCanApply,
    required this.companyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Eligibility Criteria',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: Sizes.responsiveSm(context),
        ),
        Text(
          education,
          style: const TextStyle(
            fontSize: 8.0,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        SizedBox(
          height: Sizes.responsiveSm(context),
        ),
        Text(
          whoCanApply,
          style: const TextStyle(
            fontSize: 8.0,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        SizedBox(
          height: Sizes.responsiveSm(context),
        ),
        Text(
          'About $companyName',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: Sizes.responsiveSm(context),
        ),
        const Text(
          'Company description goes here...',
          style: TextStyle(
            fontSize: 8.0,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
