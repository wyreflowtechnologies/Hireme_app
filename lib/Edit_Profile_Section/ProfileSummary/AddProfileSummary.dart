import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/Key%20Skills/AddKeySkills.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/widgets/CustomTextField.dart';

import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import '../../API_Integration/Add Profile Summary/apiServices.dart';

class AddProfileSummary extends StatefulWidget {
  AddProfileSummary({Key? key}) : super(key: key);

  @override
  _AddProfileSummaryState createState() => _AddProfileSummaryState();
}

class _AddProfileSummaryState extends State<AddProfileSummary> {
  final _formKey = GlobalKey<FormState>();
  final summaryController = TextEditingController();
  final AddProfileSummaryService _apiService = AddProfileSummaryService();
  String profileId = '';

  @override
  void initState() {
    super.initState();
    _loadProfileSummary();
  }

  Future<void> _loadProfileSummary() async {
    final summary = await _fetchProfileSummary();
    if (summary != null) {
      setState(() {
        summaryController.text = summary;
      });
    }
  }

  Future<String?> _fetchProfileSummary() async {
    final summary = await _apiService.getProfileSummary();
    print('Fetched profile summary: $summary');
    return summary;
  }

  Future<void> _saveProfileSummary(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final int? savedId = await SharedPreferencesHelper.getProfileId();
      profileId = savedId?.toString() ?? '';

      if (profileId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile ID not found')),
        );
        return;
      }

      final details = {
        "profile": profileId,
        "summary": summaryController.text,
      };
      print(details);

      final success = await _apiService.addOrUpdateProfileSummary(details);

      if (success) {

     //  Navigator.pop(context, true);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NewNavbar(
              initTabIndex: 3, // Navigate to the desired screen
              isV: true, // Pass the verification status
            ),
          ),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Profile summary addxxzed/updated successfully')),
        // );
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (ctx) => ProfileScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add/update profile summary')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in the required fields correctly')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.responsiveXl(context),
            right: Sizes.responsiveDefaultSpace(context),
            bottom: kToolbarHeight,
            left: Sizes.responsiveDefaultSpace(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Sizes.responsiveMd(context),
              ),
              Row(
                children: [
                  const Text(
                    'About You',
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
                controller: summaryController,
                hintText: 'Tell us about yourself...',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a profile summary';
                  }
                  if (value.split(' ').length < 20 ||
                      value.split(' ').length > 100) {
                    return 'Summary must be between 20 and 100 words';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Sizes.responsiveXs(context),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Word Limit is 20-100 words.',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryText,
                  ),
                ),
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
                        borderRadius: BorderRadius.circular(Sizes.radiusSm),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.responsiveHorizontalSpace(context),
                        horizontal: Sizes.responsiveMdSm(context),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveProfileSummary(context);
                      }
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
                        borderRadius: BorderRadius.circular(Sizes.radiusSm),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes.responsiveSm(context),
                        horizontal: Sizes.responsiveMdSm(context),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveProfileSummary(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => AddKeySkills()));
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Save & Next',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(
                          width: Sizes.responsiveXs(context),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 11,
                          color: AppColors.primary,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
