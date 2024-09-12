// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
// import 'package:hiremi_version_two/Utils/AppSizes.dart';
// import 'package:hiremi_version_two/Utils/colors.dart';
//
//
// class ProfileStatusSection extends StatefulWidget {
//   const ProfileStatusSection({Key? key, }) : super(key: key);
//
//   @override
//   State<ProfileStatusSection> createState() => _ProfileStatusSectionState();
// }
//
// class _ProfileStatusSectionState extends State<ProfileStatusSection> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadFullName();
//   }
//   Future<void> _loadFullName() async {
//     final name = await SharedPreferencesHelper.getFullName();
//     setState(() {
//       fullName = name ?? 'No Name Found'; // Default if name is not found
//     });
//   }
//
//   final percent = 0.25;
//
//   final showPercent = .25 * 100;
//   String? fullName;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(Sizes.responsiveLg(context)),
//             decoration: BoxDecoration(
//                 color: HexColor('#FBEEEE'),
//                 shape: BoxShape.circle,
//                 border: Border.all(width: 5, color: AppColors.green)),
//             child: Icon(
//               Icons.person,
//               color: AppColors.primary,
//             ),
//           ),
//           SizedBox(
//             height: Sizes.responsiveMd(context),
//           ),
//     //      Text('Harsh Pawar', style: Theme.of(context).textTheme.headlineSmall),
//           Text(
//             fullName!.split(' ').first, // Display fullName or a loading text
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           SizedBox(
//             height: Sizes.responsiveSm(context),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(
//               vertical: Sizes.responsiveVerticalSpace(context),
//               horizontal: Sizes.responsiveHorizontalSpace(context),
//             ),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 border: Border.all(
//                   width: 0.7,
//                   color: AppColors.green,
//                 )),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                   'images/icons/verified.png',
//                   height: MediaQuery.of(context).size.width * 0.025,
//                   width: MediaQuery.of(context).size.width * 0.025,
//                 ),
//                 SizedBox(
//                   width: Sizes.responsiveXs(context),
//                 ),
//                 Text(
//                   'Verified',
//                   style: TextStyle(
//                     color: AppColors.green,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: Sizes.responsiveSm(context),
//           ),
//           // Text('Last updated today',
//           //     style: TextStyle(
//           //       fontSize: 10.0,
//           //       fontWeight: FontWeight.w400,
//           //       color: AppColors.secondaryText,
//           //     )),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';

class ProfileStatusSection extends StatefulWidget {
  const ProfileStatusSection({Key? key}) : super(key: key);

  @override
  State<ProfileStatusSection> createState() => _ProfileStatusSectionState();
}

class _ProfileStatusSectionState extends State<ProfileStatusSection> {
  String? fullName; // Full name can be null initially

  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  Future<void> _loadFullName() async {
    try {
      final name = await SharedPreferencesHelper.getFullName();
      setState(() {
        fullName = name ?? 'No Name Found'; // Default value if name is not found
      });
    } catch (error) {
      // Handle any errors that occur during fetching the name
      setState(() {
        fullName = 'Error fetching name'; // Default value in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Sizes.responsiveLg(context)),
            decoration: BoxDecoration(
              color: HexColor('#FBEEEE'),
              shape: BoxShape.circle,
              border: Border.all(width: 5, color: AppColors.green),
            ),
            child: Icon(
              Icons.person,
              color: AppColors.primary,
              size: Sizes.responsiveMd(context), // Adjust icon size as needed
            ),
          ),
          SizedBox(height: Sizes.responsiveMd(context)),
          Text(
            fullName != null ? fullName!.split(' ').first : 'Loading...', // Handle null case
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: Sizes.responsiveSm(context)),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Sizes.responsiveVerticalSpace(context),
              horizontal: Sizes.responsiveHorizontalSpace(context),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 0.7,
                color: AppColors.green,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'images/icons/verified.png',
                  height: MediaQuery.of(context).size.width * 0.025,
                  width: MediaQuery.of(context).size.width * 0.025,
                ),
                SizedBox(width: Sizes.responsiveXs(context)),
                Text(
                  'Verified',
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Sizes.responsiveSm(context)),
          // Uncomment and use if needed
          // Text(
          //   'Last updated today',
          //   style: TextStyle(
          //     fontSize: 10.0,
          //     fontWeight: FontWeight.w400,
          //     color: AppColors.secondaryText,
          //   ),
          // ),
        ],
      ),
    );
  }
}
