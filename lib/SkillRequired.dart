// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Custom_Widget/roundedContainer.dart';
// import 'package:hiremi_version_two/Utils/AppSizes.dart';
// import 'package:hiremi_version_two/Utils/colors.dart';
//
//
//
//
// class SkillRequired extends StatelessWidget {
//   const SkillRequired({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Skill Required',
//             style: TextStyle(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.primary)),
//         SizedBox(
//           height: Sizes.responsiveMd(context),
//         ),
//         Wrap(
//           runSpacing: 8,
//           spacing: 8,
//           children: [
//             RoundedContainer(
//                 color: AppColors.lightOrange,
//                 radius: 2,
//                 padding: EdgeInsets.all(
//                     Sizes.responsiveXs(context) * 1.2),
//                 child: const Text(
//                   'Communication',
//                   style: TextStyle(
//                     fontSize: 9.5,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 )),
//             RoundedContainer(
//                 color: AppColors.lightOrange2,
//                 radius: 2,
//                 padding:
//                 EdgeInsets.all(Sizes.responsiveXs(context)),
//                 child: const Text(
//                   'Team Management',
//                   style: TextStyle(
//                     fontSize: 9.5,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 )),
//             RoundedContainer(
//                 color: AppColors.lightPink,
//                 radius: Sizes.radiusXs,
//                 padding:
//                 EdgeInsets.all(Sizes.responsiveXs(context)),
//                 child: const Text(
//                   'Tool Adoption',
//                   style: TextStyle(
//                     fontSize: 9.5,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 )),
//             RoundedContainer(
//                 color: AppColors.lightPink,
//                 radius: 2,
//                 padding:
//                 EdgeInsets.all(Sizes.responsiveXs(context)),
//                 child: const Text(
//                   'Work Independently',
//                   style: TextStyle(
//                     fontSize: 9.5,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ))
//           ],
//         )
//       ],
//     );
//   }
// }
