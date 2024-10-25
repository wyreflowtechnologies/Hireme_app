

import 'package:flutter/material.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import '../../API_Integration/Add Experience/apiServices.dart';
import '../../Profile_Screen.dart';
import '../widgets/CustomTextField.dart';
import 'package:intl/intl.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({Key? key}) : super(key: key);

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  String experience = '';
  String environment = '';
  String currentCompany = '';
  final organizationController = TextEditingController();
  final jobTitleController = TextEditingController();
  final skillSetController = TextEditingController();
  final joiningDateController = TextEditingController();
  final EndingDateController=TextEditingController();
  final AddExperienceService _apiService = AddExperienceService();
  DateTime? _selectedDate;
  DateTime? _selectedEndingDate;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadExperienceDetails();
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //
  //   if (pickedDate != null && pickedDate != _selectedDate) {
  //     setState(() {
  //       _selectedDate = pickedDate;
  //       joiningDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  //     });
  //   }
  // }
  // Future<void> _selectEndingDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //
  //   if (pickedDate != null && pickedDate != _selectedDate) {
  //     setState(() {
  //       _selectedEndingDate = pickedDate;
  //       EndingDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  //     });
  //   }
  // }
  void _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      setState(() {
        joiningDateController.text = selectedDate.toString().split(' ')[0]; // Format YYYY-MM-DD
      });
    }
  }

  void _selectEndingDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // Parse the joining date from the controller
      DateTime? joiningDate;
      if (joiningDateController.text.isNotEmpty) {
        joiningDate = DateTime.tryParse(joiningDateController.text);
      }

      // Validate if the ending date is greater than the joining date
      if (joiningDate != null && selectedDate.isBefore(joiningDate)) {
        // Show error if ending date is before joining date
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ending Date should be after Joining Date')),
        );
      } else {
        // If valid, set the ending date in the controller
        setState(() {
          EndingDateController.text = selectedDate.toString().split(' ')[0]; // Format YYYY-MM-DD
        });
      }
    }
  }

  Future<void> _loadExperienceDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? profileId = prefs.getInt('profileId');

    if (profileId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile ID not found')),
      );
      return;
    }

    final details = await _apiService.getExperienceDetails();

    if (details.isNotEmpty) {
      final firstDetail = details.first;
      setState(() {
        experience = firstDetail["work_experience"] ?? '';
        environment = firstDetail["work_environment"] ?? '';
        organizationController.text = firstDetail["company_name"] ?? '';
        jobTitleController.text = firstDetail["job_title"] ?? '';
        skillSetController.text = firstDetail["skill_used"] ?? '';
        joiningDateController.text = firstDetail["start_date"] ?? '';
        currentCompany = firstDetail["current_company"] ?? '';
        EndingDateController.text = firstDetail["end_date"] ?? '';
      });
    }
  }

  Future<bool> _saveExperience() async {
    if (_formKey.currentState!.validate()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? profileId = prefs.getInt('profileId')?.toString();

      if (profileId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile ID not found')),
        );
        return false;
      }

      final details = {
        "work_experience": experience,
        "work_environment": environment,
        "company_name": organizationController.text,
        "job_title": jobTitleController.text,
        "skill_used": skillSetController.text.isEmpty ? null : skillSetController.text,
        "start_date": joiningDateController.text,
        "current_company": currentCompany,
        "end_date": EndingDateController.text,
        "profile": profileId,
      };

      final success = await _apiService.addExperience(details);

      if (success) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Experience details added successfully')),
        // );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NewNavbar(
              initTabIndex: 3, // Navigate to the desired screen
              isV: true, // Pass the verification status
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add experience details')),
        );
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: Sizes.responsiveXl(context),
          right: Sizes.responsiveDefaultSpace(context),
          bottom: kToolbarHeight,
          left: Sizes.responsiveDefaultSpace(context),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Experience',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Sizes.responsiveMd(context)*0.4,
              ),
              Row(
                children: [
                  const Text(
                    'Do you have work experience?',
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
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: Colors.blue,
                        value: 'YES',
                        groupValue: experience,
                        onChanged: (value) => setState(() {
                          experience = value!;
                        }),
                      ),
                      Text(
                        'Yes',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: experience == 'YES'
                              ? Colors.black
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: Colors.blue,
                        value: 'NO',
                        groupValue: experience,
                        onChanged: (value) {
                          setState(() {
                            experience = value!;
                          });
                        },
                      ),
                      Text(
                        'No',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: experience == 'NO'
                              ? Colors.black
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (experience == 'YES') ...[
                SizedBox(
                  height: Sizes.responsiveMd(context)*0.4,
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What type of work environment do you prefer?',
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
                  height: Sizes.responsiveMd(context)*0.4,
                ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: Colors.blue,
                        value: 'On-Site',
                        groupValue: environment,
                        onChanged: (value) => setState(() {
                          environment = value!;
                        }),
                      ),
                      Text(
                        'On-Site',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: environment == 'On-Site'
                              ? Colors.black
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: Colors.blue,
                        value: 'Hybrid',
                        groupValue: environment,
                        onChanged: (value) {
                          setState(() {
                            environment = value!;
                          });
                        },
                      ),
                      Text(
                        'Hybrid',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: environment == 'Hybrid'
                              ? Colors.black
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: Colors.blue,
                        value: 'Remote',
                        groupValue: environment,
                        onChanged: (value) {
                          setState(() {
                            environment = value!;
                          });
                        },
                      ),
                      Text(
                        'Remote',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: environment == 'Remote'
                              ? Colors.black
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
                SizedBox(
                  height: Sizes.responsiveMd(context)*0.4,
                ),
              Row(
                children: [
                  const Text(
                    'Is this your current company?',
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
                  height: Sizes.responsiveMd(context)*0.4,
                ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        activeColor: Colors.blue,
                        value: 'YES',
                        groupValue: currentCompany,
                        onChanged: (value) => setState(() {
                          currentCompany = value!;
                        }),
                      ),
                      Text(
                        'Yes',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: currentCompany == 'YES'
                              ? Colors.black
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
          
                  Row(
                    children: [
          
                      Radio<String>(
                        activeColor: Colors.blue,
                        value: 'NO',
                        groupValue: currentCompany,
                        onChanged: (value) {
                          setState(() {
                            currentCompany = value!;
                          });
                        },
                      ),
                      Text(
                        'No',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: currentCompany == 'NO'
                              ? Colors.black
                              : AppColors.secondaryText,
                        ),
                      ),
          
                    ],
                  ),
                ],
              ),
                SizedBox(
                  height: Sizes.responsiveMd(context)*0.4,
                ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text(
                            'Organization Name',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: Sizes.responsiveXs(context),
                        ),
                        CustomTextField(
                          controller: organizationController,
                          hintText: '',
                          validator: (value) {
                            final characterRegex = RegExp(r'^[a-zA-Z\s]+$');  // Regular expression for letters and spaces

                            if (value == null || value.isEmpty) {
                              return 'Organization Name is required';
                            } else if (!characterRegex.hasMatch(value)) {
                              return 'Only letters are allowed';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Sizes.responsiveSm(context)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text(
                            'Job Title',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: Sizes.responsiveXs(context),
                        ),
                        CustomTextField(
                          controller: jobTitleController,
                          hintText: '',
                          validator: (value) {
                            final characterRegex = RegExp(r'^[a-zA-Z\s]+$');  // Regular expression for letters and spaces

                            if (value == null || value.isEmpty) {
                              return 'Job Title is required';
                            } else if (!characterRegex.hasMatch(value)) {
                              return 'Only letters are allowed';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Text(
                      'Skill Set Used',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
          
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: Sizes.responsiveXs(context),
                  ),
                  CustomTextField(
                    controller: skillSetController,
                    hintText: '',
                    validator: (value) {
                      final characterRegex = RegExp(r'^[a-zA-Z\s]+$');  // Regular expression for letters and spaces

                      if (value == null || value.isEmpty) {
                        return 'Skill set is required';
                      } else if (!characterRegex.hasMatch(value)) {
                        return 'Only letters are allowed';
                      }
                      return null;
                    },
                  ),
                  SizedBox(width: Sizes.responsiveSm(context)),
                ],
              ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    const Text(
                      'Joining Date',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: Sizes.responsiveSm(context)*1.4,
                  ),
          
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.radiusXs),
                          border: Border.all(width: 0.37, color: AppColors.black),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1.0,
                              width: 0.37,
                              color: AppColors.black,
                            ),
                            Expanded(
                              child: TextField(
                                controller: joiningDateController,
                                cursorColor: AppColors.black,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'YYYY-MM-DD',
                                  suffixIconColor: AppColors.secondaryText,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: Sizes.responsiveSm(context),
                                    horizontal: Sizes.responsiveMd(context),
                                  ),
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryText,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Sizes.responsiveMd(context),
                  ),
                  Row(children: [
                    const Text(
                      'Ending Date',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: Sizes.responsiveSm(context),
                  ),
          
                  GestureDetector(
                    onTap: () => _selectEndingDate(context),
                    child: AbsorbPointer(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.radiusXs),
                          border: Border.all(width: 0.37, color: AppColors.black),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1.0,
                              width: 0.37,
                              color: AppColors.black,
                            ),
                            Expanded(
                              child: TextField(
                                controller: EndingDateController,
                                cursorColor: AppColors.black,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'YYYY-MM-DD',
                                  suffixIconColor: AppColors.secondaryText,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: Sizes.responsiveSm(context),
                                    horizontal: Sizes.responsiveMd(context),
                                  ),
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryText,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Sizes.responsiveMd(context)),
              ],
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) { // Validate the form
                        bool success = await _saveExperience();
                        if (success) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        }
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) { // Validate the form
                        bool success = await _saveExperience();
                        if (success) {
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => AddExperience()),
                        //   );

                        }


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
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: Sizes.responsiveXs(context)*2,
              ),
          
            ]),
          ),
        ),
      ),
    );
  }
}