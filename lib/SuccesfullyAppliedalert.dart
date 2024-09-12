import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/roundedContainer.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';

import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:intl/intl.dart';

class SuccessfullyAppliedAlert extends StatelessWidget {
  const SuccessfullyAppliedAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    return RoundedContainer(
      radius: Sizes.radiusSm,
      padding: EdgeInsets.all(Sizes.responsiveXl(context)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedContainer(
              radius: 50,
              color: AppColors.green,
              padding: EdgeInsets.all(Sizes.responsiveMd(context)),
              child: const Icon(
                Icons.done_all,
                color: Colors.white,
                size: 27,
              )),
          SizedBox(
            height: Sizes.responsiveMd(context),
          ),
          RichText(
              text: TextSpan(children: [
                const TextSpan(
                    text: 'Thank you for applying at ',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: 16)),
                TextSpan(
                    text: 'Hiremi!',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        fontSize: 16))
              ])),
          SizedBox(
            height: Sizes.responsiveXl(context),
          ),
          Text(
            'You\'ve successfully applied in this opportunity.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.green),
          ),
          SizedBox(
            height: Sizes.responsiveMd(context),
          ),
          Text(
            'We\'ll update you after few working hours.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 8,
                color: AppColors.secondaryText),
          ),
          SizedBox(
            height: Sizes.responsiveLg(context),
          ),
          SizedBox(
            height: Sizes.responsiveXl(context) * 1.02,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Sizes.radiusXs)),
                  padding: EdgeInsets.symmetric(
                      vertical: Sizes.responsiveVerticalSpace(context),
                      horizontal: Sizes.responsiveMdSm(context)),
                ),

                onPressed: (){
                  Navigator.of(context).push(
                    // MaterialPageRoute(builder: (ctx) => const AppliesScreen(isVerified: true,)
                    //
                    MaterialPageRoute(
                      builder: (ctx) => NewNavbar(
                        initTabIndex: 1, // Set this to 1 to show AppliesScreen
                        isV: true,       // Pass the verification status
                      ),

                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'View in Applies',
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: Sizes.responsiveXs(context),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 8,
                      color: AppColors.white,
                    )
                  ],
                )),
          ),
          SizedBox(
            height: Sizes.responsiveMd(context),
          ),
          Text(
            'Applied Date${DateFormat('dd/MM/yyyy').format(date)}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColors.black),
          ),
        ],
      ),
    );
  }
}
