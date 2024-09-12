import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/Experience/AddExperience.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/API_Integration/Add%20Experience/apiServices.dart';
import 'package:intl/intl.dart';
class Experience extends StatefulWidget {
  const Experience({Key? key}) : super(key: key);

  @override
  _ExperienceState createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  List<Map<String, String>> experiences = [];

  @override
  void initState() {
    super.initState();
    _loadExperienceDetails();
  }

  Future<void> _loadExperienceDetails() async {
    final service = AddExperienceService();
    final details = await service.getExperienceDetails();
    setState(() {
      experiences = details;
    });
  }

  bool isValid() {
    return experiences.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      onEditTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExperience())),
      title: 'Experience',
      isTrue: isValid(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: experiences
            .map((exp) => ExperienceChild(
            title: exp['job_title'] ?? '',
            company: exp['company_name'] ?? '',
            jobType: exp['work_environment'] ?? '',
            timing: '${exp['start_date'] ?? ''} - ${exp['end_date'] ?? ''}'))
            .toList(),
      ),
    );
  }
}

class ExperienceChild extends StatelessWidget {
  const ExperienceChild({Key? key, required this.title, required this.jobType, required this.company, required this.timing}) : super(key: key);

  final String title, jobType, company, timing;
  // String _formatDate(String date) {
  //   if (date.isEmpty) return '';
  //   final parsedDate = DateTime.parse(date);
  //   final formatter = DateFormat('MMM yyyy'); // Format to 'Mon Year' (e.g., Aug 2024)
  //   return formatter.format(parsedDate);
  // }
  //
  // String getFormattedTiming(String timing) {
  //   final dates = timing.split(' - ');
  //   if (dates.length == 2) {
  //     final startDate = _formatDate(dates[0]);
  //     final endDate = dates[1] == _formatDate(DateTime.now().toString()) ? 'Now' : _formatDate(dates[1]);
  //     return '$startDate - $endDate';
  //   }
  //   return timing;
  // }
  String _formatDate(DateTime date) {
    final formatter = DateFormat('MMM yyyy'); // Format to 'Mon Year' (e.g., Aug 2024)
    return formatter.format(date);
  }

  String getFormattedTiming(String timing) {
    final now = DateTime.now();
    final dates = timing.split(' - ');

    if (dates.length == 2) {
      final startDateStr = dates[0];
      final endDateStr = dates[1];

      final startDate = DateTime.parse(startDateStr);
      final endDate = DateTime.parse(endDateStr);

      final formattedStartDate = _formatDate(startDate);
      final formattedEndDate = (endDate.year == now.year &&
          endDate.month == now.month &&
          endDate.day == now.day)
          ? 'Now'
          : _formatDate(endDate);

      return '$formattedStartDate - $formattedEndDate';
    }
    return timing;
  }

  @override
  Widget build(BuildContext context) {
    final formattedTiming = getFormattedTiming(timing);
    print('Timing: $formattedTiming');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.apartment,
          size: 64.0,
          color: Color(0xFFC1272D)
        ),
       SizedBox(width: 18,),
        Column(
         children: [
           Text(
             title,
             style: const TextStyle(
               fontSize: 9.5,
               fontWeight: FontWeight.w500,
             ),
           ),
           SizedBox(
             height: Sizes.responsiveXs(context),
           ),
           Text(
             jobType,
             style: const TextStyle(
               fontSize: 7.5,
               fontWeight: FontWeight.w400,
             ),
           ),
           SizedBox(
             height: Sizes.responsiveXxs(context),
           ),
           Text(
             company,
             style: const TextStyle(
               fontSize: 7.5,
               fontWeight: FontWeight.w400,
             ),
           ),
           SizedBox(
             height: Sizes.responsiveXxs(context),
           ),
           // Padding(
           //   padding: const EdgeInsets.only(left: 18.0),
           //   child: Text(
           //      formattedTiming,
           //     style: TextStyle(
           //       fontSize: 7.5,
           //       fontWeight: FontWeight.w500,
           //       color: AppColors.secondaryText,
           //     ),
           //   ),
           // ),
           SizedBox(height: Sizes.responsiveSm(context)),
           Divider(
             height: 0.25,
             thickness: 0.25,
             color: AppColors.secondaryText,
           ),
           SizedBox(height: Sizes.responsiveMd(context)),
         ],
       )
      ],
    );
  }
}