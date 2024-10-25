import 'package:flutter/material.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/Experience/AddExperience.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/widgets/CustomTextField.dart';

import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import '../../API_Integration/Add Education/apiServices.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({Key? key}) : super(key: key);

  @override
  _AddEducationState createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  final educationController = TextEditingController();
  final courseController = TextEditingController();
  final yearController = TextEditingController();
  final marksController = TextEditingController();
  final AddEducationService _apiService = AddEducationService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String profileId = "";

  @override
  void initState() {
    super.initState();
    _loadEducationDetails();
  }

  Future<void> _loadEducationDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('profileId');
    if (savedId != null) {
      profileId = savedId.toString();
      final details = await _apiService.getEducationDetails();
      final latestDetails = details.isNotEmpty ? details.first : null;

      if (latestDetails != null) {
        setState(() {
          educationController.text = latestDetails['education'] ?? '';
          courseController.text = latestDetails['degree'] ?? '';
          yearController.text = latestDetails['passing_year'] ?? '';
          marksController.text = latestDetails['marks'] ?? '';
        });
      }
    } else {
      print('Profile ID not found');
    }
  }

  Future<bool> _saveEducation(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    final marksText = marksController.text;
    final marks = int.tryParse(marksText.replaceAll(RegExp(r'[^\d]'), ''));
    if (marks == null) {
      _showError('Marks should be a valid integer');
      return false;
    }

    final yearText = yearController.text;
    final year = int.tryParse(yearText);
    if (year == null) {
      _showError('Year should be a valid integer');
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('profileId');
    if (savedId != null) {
      profileId = savedId.toString();
    } else {
      _showError('Profile ID not found');
      return false;
    }

    final details = {
      "education": educationController.text,
      "degree": courseController.text,
      "marks": marks.toString(),
      "passing_year": year.toString(),
      "profile": profileId,
    };

    final success = await _apiService.addOrUpdateEducation(details);

    if (success) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => NewNavbar(
            initTabIndex: 3, // Navigate to the desired screen
            isV: true, // Pass the verification status
          ),
        ),
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Education details saved successfully')),
      // );
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (context) => ProfileScreen()));
    } else {
      _showError('Failed to save education details');
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: Sizes.responsiveXl(context),
              right: Sizes.responsiveDefaultSpace(context),
              bottom: kToolbarHeight,
              left: Sizes.responsiveDefaultSpace(context)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Education',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Row(
                  children: [
                    const Text(
                      'Education',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.responsiveSm(context),
                ),
                CustomTextField(
                  controller: educationController,
                  hintText: 'Select Education Level',
                  // suffix: const Icon(
                  //   Icons.arrow_drop_down,
                  //   color: AppColors.black,
                  //   size: 15,
                  // ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your education level';
                    }

                    return null;

                  },
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Row(
                  children: [
                    const Text(
                      'Subject/Course',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.responsiveSm(context),
                ),
                CustomTextField(
                  controller: courseController,
                  hintText: 'Select Subject or Course Level',
                  // suffix: const Icon(
                  //   Icons.arrow_drop_down,
                  //   color: AppColors.black,
                  //   size: 15,
                  // ),
                  validator: (value) {
                    final alphabetRegex = RegExp(r'^[a-zA-Z\s]+$');

                    if (value == null || value.isEmpty) {
                      return 'Please select your Subject';
                    } else if (!alphabetRegex.hasMatch(value)) {
                      return 'Only letters  are allowed';
                    }
                    return null;

                    return null;
                  },
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Row(
                  children: [
                    const Text(
                      'Passing Out Year',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.responsiveSm(context),
                ),
                CustomTextField(
                  controller: yearController,
                  hintText: 'eg: 2024',
                  // suffix: const Icon(
                  //   Icons.arrow_drop_down,
                  //   color: AppColors.black,
                  //   size: 15,
                  // ),
                  textInputType: TextInputType.number,
                  validator: (value) {
                    final numericRegex = RegExp(r'^[0-9]+$');  // Regular expression for numbers

                    if (value == null || value.isEmpty) {
                      return 'Please enter a passing out year';
                    } else if (!numericRegex.hasMatch(value)) {
                      return 'Only numbers are allowed';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Row(
                  children: [
                    const Text(
                      'Marks/Percentage/CGPA',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Sizes.responsiveSm(context),
                ),
                CustomTextField(
                  controller: marksController,
                  hintText: 'eg: 84.99%',
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter marks';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Sizes.radiusSm)),
                        padding: EdgeInsets.symmetric(
                            vertical: Sizes.responsiveHorizontalSpace(context),
                            horizontal: Sizes.responsiveMdSm(context)),
                      ),
                      onPressed: () async {
                        await _saveEducation(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary, width: 0.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Sizes.radiusSm)),
                        padding: EdgeInsets.symmetric(
                            vertical: Sizes.responsiveSm(context),
                            horizontal: Sizes.responsiveMdSm(context)),
                      ),
                      onPressed: () async {
                        if (await _saveEducation(context)) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddExperience()));
                        }
                      },
                      child:  Text(
                        'Save & Next',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
