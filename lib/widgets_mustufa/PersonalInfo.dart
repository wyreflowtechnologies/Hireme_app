import 'package:flutter/material.dart';
import 'package:hiremi_version_two/AddPersonalDetails.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/API_Integration/Add%20Personal%20Details/apiServices.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  Map<String, String> personalDetails = {
    'gender': 'N/A',
    'marital_status': 'N/A',
    'home_town': 'N/A',
    'pincode': 'N/A',
    'local_address': 'N/A',
    'permanent_address': 'N/A',
    'date_of_birth': 'N/A',
    'ability': 'N/A',
    'category': 'N/A',
    'profile': 'N/A'
  };

  @override
  void initState() {
    super.initState();
    _loadPersonalDetails();
  }

  Future<void> _loadPersonalDetails() async {
    final service = AddPersonalDetailsService();
    final details = await service.getPersonalDetails();
    setState(() {
      personalDetails = {
        'gender': details['gender'] ?? 'N/A',
        'marital_status': details['marital_status'] ?? 'N/A',
        'home_town': details['home_town']?.isEmpty ?? true ? 'N/A' : details['home_town'] ?? 'N/A',
        'pincode': details['pincode']?.toString() ?? 'N/A',
        'local_address': details['local_address']?.isEmpty ?? true ? 'N/A' : details['local_address'] ?? 'N/A',
        'permanent_address': details['permanent_address']?.isEmpty ?? true ? 'N/A' : details['permanent_address'] ?? 'N/A',
        'date_of_birth': details['date_of_birth'] ?? 'N/A',
        'ability': details['ability'] ?? 'N/A',
        'category': details['category']?.isEmpty ?? true ? 'N/A' : details['category'] ?? 'N/A',
        'profile': details['profile']?.toString() ?? 'N/A',
      };
    });
    print(details);
  }

  @override
  Widget build(BuildContext context) {
    bool hasDetails = personalDetails.isNotEmpty;

    return OutlinedContainer(
      onEditTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddPersonalDetails()),
        );
        if (result == true) {
          // Refresh the details if the result indicates success
          _loadPersonalDetails();
        }
      },
      title: 'Personal Details',
      isTrue: hasDetails,
      child: hasDetails
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          PersonalInfoChild(
            title: 'Gender',
            subtitle: personalDetails['gender'] ?? 'N/A',
          ),
          PersonalInfoChild(
            title: 'Marital Status',
            subtitle: personalDetails['marital_status'] ?? 'N/A',
          ),
          PersonalInfoChild(
            title: 'Date of Birth (DOB)',
            subtitle: personalDetails['date_of_birth'] ?? 'N/A',
          ),
          PersonalInfoChild(
            title: 'Current Address',
            subtitle: personalDetails['local_address'] ?? 'N/A',
          ),
          PersonalInfoChild(
            title: 'Permanent Address',
            subtitle: personalDetails['permanent_address'] ?? 'N/A',
          ),
          // PersonalInfoChild(
          //   title: 'Career Break',
          //   subtitle: personalDetails['career_break'] ?? 'N/A',
          // ),
          PersonalInfoChild(
            title: 'Differently Abled',
            subtitle: personalDetails['ability'] ?? 'N/A',
          ),
          PersonalInfoChild(
            title: 'Native',
            subtitle: personalDetails['home_town'] ?? 'N/A',
          ),
        ],
      )
          : const Text(''),
    );
  }
}

class PersonalInfoChild extends StatelessWidget {
  const PersonalInfoChild({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        SizedBox(height: Sizes.responsiveXs(context)),
        Text(
          subtitle,
          style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w500, color: AppColors.secondaryText),
        ),
        SizedBox(height: Sizes.responsiveSm(context)),
        Divider(height: 0.25, thickness: 0.25, color: AppColors.secondaryText),
        SizedBox(height: Sizes.responsiveMd(context)),

      ],
    );
  }
}
