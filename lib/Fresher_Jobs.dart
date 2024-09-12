// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Eligibility_Criteria_About_Company.dart';
// import 'package:hiremi_version_two/HeaderSectionFresher.dart';
// import 'package:hiremi_version_two/Notofication_screen.dart';
// import 'package:hiremi_version_two/Role_Details.dart';
// import 'package:hiremi_version_two/Skill_Required.dart';
// import 'package:hiremi_version_two/Utils/AppSizes.dart';
//
//
//
//
//
// class FresherJobsScreen extends StatefulWidget {
//   const FresherJobsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<FresherJobsScreen> createState() => _FresherJobsScreenState();
// }
//
// class _FresherJobsScreenState extends State<FresherJobsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Fresher Jobs'),
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (ctx) => const NotificationScreen()));
//                 },
//                 icon: const Icon(Icons.notifications))
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Padding(padding: EdgeInsets.only(
//               top: Sizes.responsiveXl(context),
//               right: Sizes.responsiveDefaultSpace(context),
//               bottom: kToolbarHeight * 1.5,
//               left: Sizes.responsiveDefaultSpace(context)),
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//               /// Header Sections
//               const HeaderSectionFresher(),
//
//               SizedBox(height: Sizes.responsiveXl(context)),
//
//               /// Role Details
//               const RoleDetailsFresher(),
//               SizedBox(
//                 height: Sizes.responsiveLg(context),
//               ),
//
//               /// Skill Required
//               const SkillRequiredFresher(),
//               SizedBox(
//                 height: Sizes.responsiveLg(context),
//               ),
//
//               /// Eligibility Criteria
//               const EligibilityCriteriaAboutCompanyFresher()
//             ]),
//           ),
//         )
//     );
//   }
// }
//
//
