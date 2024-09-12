import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/Education/AddEducation.dart';

import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import '../../API_Integration/Add Key Skills/apiServices.dart';
import '../widgets/CustomTextField.dart';

class AddKeySkills extends StatefulWidget {
  AddKeySkills({Key? key}) : super(key: key);

  @override
  _AddKeySkillsState createState() => _AddKeySkillsState();
}

class _AddKeySkillsState extends State<AddKeySkills> {
  final skillController = TextEditingController();
  final AddKeySkillsService _apiService = AddKeySkillsService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String profileId = "";
  int? existingSkillId;

  @override
  void initState() {
    super.initState();
    _loadKeySkills();
  }

  Future<void> _loadKeySkills() async {
    final loadedSkills = await _apiService.getKeySkills();
    setState(() {
      skillController.text = loadedSkills.join(', ');
    });
  }

  Future<void> _saveKeySkills(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final int? savedId = await SharedPreferencesHelper.getProfileId();
      profileId = savedId?.toString() ?? "";

      if (profileId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile ID not found')),
        );
        return;
      }

      final details = {
        "profile": profileId,
        "skill": skillController.text,
      };
      print(details);

      final success = await _apiService.addOrUpdateKeySkills(details);

      if (success) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Key skills added/updated successfully'),
        //     duration: Duration(milliseconds: 500), // 0.5 seconds
        //   ),
        // );

        Future.delayed(const Duration(seconds: 0), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => NewNavbar(
                initTabIndex: 3, // Navigate to Profile tab
                isV: true, // Pass the verification status
              ),
            ),
          );
        });


    } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add/update key skills')),
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
      body: Padding(
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
                'Key Skills',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Sizes.responsiveMd(context),
              ),
              Row(
                children: [
                  const Text(
                    'Key Skills',
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
                controller: skillController,
                hintText: 'Eg: Flutter Developer',
                suffix: Icon(
                  Icons.open_with,
                  size: 15,
                  color: AppColors.secondaryText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a skill';
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
                  'Word Limit is 100-250 words.',
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
                          borderRadius: BorderRadius.circular(Sizes.radiusSm)),
                      padding: EdgeInsets.symmetric(
                          vertical: Sizes.responsiveHorizontalSpace(context),
                          horizontal: Sizes.responsiveMdSm(context)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _saveKeySkills(context);

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
                          borderRadius: BorderRadius.circular(Sizes.radiusSm)),
                      padding: EdgeInsets.symmetric(
                          vertical: Sizes.responsiveSm(context),
                          horizontal: Sizes.responsiveMdSm(context)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _saveKeySkills(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddEducation()));
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
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          size: 15,
                          color: AppColors.primary,
                        ),
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
