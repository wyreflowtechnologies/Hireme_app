// import 'package:flutter/material.dart';
//
// import 'package:hiremi_version_two/Utils/AppSizes.dart';
//
// import 'Utils/colors.dart';
//
//
//
// class RoleDetailsFresher extends StatelessWidget {
//   const RoleDetailsFresher({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Job Title
//         Text('Role : Full-Time Recruiter',
//             style: TextStyle(
//                 fontSize: 14.0,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.primary)),
//         SizedBox(height: Sizes.responsiveLg(context)),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Location: ',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.green,
//               ),
//             ),
//             // Type of Job
//             const Text(
//               'Remote',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: Sizes.responsiveXs(context),
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Salary: ',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.green,
//               ),
//             ),
//             // Salary
//             const Text(
//               '₹15,000 per month',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: Sizes.responsiveXl(context)),
//         // About Job Section
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('About the Role',
//                 style: TextStyle(
//                     fontSize: 14.0,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.primary)),
//             SizedBox(
//               height: Sizes.responsiveXs(context),
//             ),
//             const Text(
//               'As a Full-Time Recruiter, your day-to-day responsibilities will include',
//               style: TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             Padding(
//               padding:
//               EdgeInsets.only(left: Sizes.responsiveXxs(context)),
//               // First
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   buildBulletPoint(
//                       context: context,
//                       number: '1.',
//                       text:
//                       'Sourcing and Recruiting: Identify and recruit potential candidates through various channels.'),
//                   buildBulletPoint(
//                       context: context,
//                       number: '2.',
//                       text:
//                       'Screening Resumes: Evaluate candidate qualifications and skills.'),
//                   buildBulletPoint(
//                       context: context,
//                       number: '3.',
//                       text:
//                       'Conducting Interviews: Arrange and conduct interviews with potential candidates.'),
//                   buildBulletPoint(
//                       context: context,
//                       number: '4.',
//                       text:
//                       'Coordinating: Manage and coordinate with hiring managers to fulfill staffing needs.'),
//                   buildBulletPoint(
//                       context: context,
//                       number: '5.',
//                       text:
//                       'Maintaining Records: Keep accurate records of all candidates and their status in the hiring process.'),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }
// Padding buildBulletPoint({required String text,
//   required String number,
//   required BuildContext context}) {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: Sizes.responsiveXxs(context)),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           '$number ',
//           overflow: TextOverflow.ellipsis,
//           maxLines: 2,
//           style: const TextStyle(
//             fontSize: 10,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w400,
//               ),
//             ))
//       ],
//     ),
//   );
// }
//
//
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'Utils/colors.dart';

class RoleDetailsFresher extends StatelessWidget {
  const RoleDetailsFresher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Job Title
        Text('Role : Full-Time Recruiter',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary)),
        SizedBox(height: Sizes.responsiveLg(context)),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Location: ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.green,
              ),
            ),
            // Type of Job
            const Text(
              'Remote',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Sizes.responsiveXs(context),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Salary: ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.green,
              ),
            ),
            // Salary
            const Text(
              '₹15,000 per month',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: Sizes.responsiveXl(context)),
        // About Job Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About the Role',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
            SizedBox(
              height: Sizes.responsiveXs(context),
            ),
            const Text(
              'As a Full-Time Recruiter, your day-to-day responsibilities will include',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Sizes.responsiveXxs(context)),
              // First
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBulletPoint(
                      context: context,
                      number: '1.',
                      text:
                      'Sourcing and Recruiting: Identify and recruit potential candidates through various channels.'),
                  buildBulletPoint(
                      context: context,
                      number: '2.',
                      text:
                      'Screening Resumes: Evaluate candidate qualifications and skills.'),
                  buildBulletPoint(
                      context: context,
                      number: '3.',
                      text:
                      'Conducting Interviews: Arrange and conduct interviews with potential candidates.'),
                  buildBulletPoint(
                      context: context,
                      number: '4.',
                      text:
                      'Coordinating: Manage and coordinate with hiring managers to fulfill staffing needs.'),
                  buildBulletPoint(
                      context: context,
                      number: '5.',
                      text:
                      'Maintaining Records: Keep accurate records of all candidates and their status in the hiring process.'),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

Padding buildBulletPoint({
  required String text,
  required String number,
  required BuildContext context,
}) {
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
          ),
        )
      ],
    ),
  );
}

