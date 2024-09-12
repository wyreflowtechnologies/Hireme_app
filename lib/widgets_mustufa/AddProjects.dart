import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API_Integration/Add Projects/apiServices.dart';
import '../Edit_Profile_Section/ProfileSummary/AddProfileSummary.dart';
import '../Utils/AppSizes.dart';
import '../Utils/colors.dart';
import 'TextFieldWithTitle.dart';

class AddProjects extends StatefulWidget {
  const AddProjects({Key? key}) : super(key: key);

  @override
  _AddProjectsState createState() => _AddProjectsState();
}

class _AddProjectsState extends State<AddProjects> {
  final titleController = TextEditingController();
  final clientController = TextEditingController();
  final projectLinkController = TextEditingController();
  final startingDateController = TextEditingController();
  final completionDateController = TextEditingController();
  final descriptionController = TextEditingController();
  String? projectStatus;
  final _formKey = GlobalKey<FormState>();
  final AddProjectDetailsService _apiService = AddProjectDetailsService();
  int? profileId;

  @override
  void initState() {
    super.initState();
    _loadProjectDetails();
  }

  Future<void> _loadProjectDetails() async {
    final prefs = await SharedPreferences.getInstance();
    profileId = prefs.getInt('profileId');
    final project = await _apiService.getProjectDetails();
    setState(() {
      titleController.text = project['project_title'] ?? '';
      clientController.text = project['client'] ?? '';
      projectLinkController.text = project['link'] ?? '';
      startingDateController.text = project['start_date'] ?? '';
      completionDateController.text = project['end_date'] ?? "null";
      descriptionController.text = project['description'] ?? '';
      projectStatus = project['status'] ?? '';
    });
  }


  Future<bool> _saveProject() async {
    if (_formKey.currentState!.validate()) {
      // Create a map with all the project details
      final Map<String, String?> details = {
        'project_title': titleController.text,
        'client': clientController.text,
        'link': projectLinkController.text,
        'start_date': startingDateController.text,
        'description': descriptionController.text,
        'status': projectStatus,
      };

      // If the project is not ongoing, add the end_date to the map
      if (projectStatus != 'On-Going') {
        details['end_date'] = completionDateController.text;
      }

      // Remove any key-value pairs where the value is null
      final cleanedDetails = <String, String>{};
      details.forEach((key, value) {
        if (value != null && value.isNotEmpty) {
          cleanedDetails[key] = value;
        }
      });

      if (profileId != null) {
        final success = await _apiService.addOrUpdateProjectDetails(cleanedDetails, profileId!);
        if (success) {
          Navigator.pop(context, true);
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save project details')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile ID not found')),
        );
      }
    }
    return false;
  }


  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startingDateController.text = picked.toIso8601String().split('T').first;
        } else {
          completionDateController.text = picked.toIso8601String().split('T').first;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add Project'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.responsiveXl(context),
            right: Sizes.responsiveDefaultSpace(context),
            bottom: kToolbarHeight,
            left: Sizes.responsiveDefaultSpace(context),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Projects',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: Sizes.responsiveMd(context)),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWithTitle(
                        controller: titleController,
                        title: 'Project Title',
                        hintText: 'eg: Project Title',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Project Title is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: Sizes.responsiveMd(context)),
                    Expanded(
                      child: TextFieldWithTitle(
                        controller: clientController,
                        title: 'Client',
                        hintText: 'eg: Organisation or Client etc.',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Client is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Sizes.responsiveMd(context)),
                TextFieldWithTitle(
                  controller: projectLinkController,
                  title: 'Add Project Link',
                  hintText: 'eg: paste project link here.',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Project Link is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Sizes.responsiveMd(context)),
                GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: AbsorbPointer(
                    child: TextFieldWithTitle(
                      title: 'Starting Date',
                      hintText: 'YYYY-MM-DD',
                      spaceBtwTextField: Sizes.responsiveMd(context),
                      controller: startingDateController,
                      prefix: Icon(
                        Icons.calendar_month_sharp,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Starting Date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),



                SizedBox(height: Sizes.responsiveMd(context)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Project Status',
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
                            Radio(
                              activeColor: Colors.blue,
                              value: 'Completed',
                              groupValue: projectStatus,
                              onChanged: (value) => setState(() {
                                projectStatus = value as String;
                              }),
                            ),
                            Text(
                              'Completed',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  color: projectStatus == 'Completed'
                                      ? Colors.black
                                      : AppColors.secondaryText),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: Colors.blue,
                              value: 'On-Going',
                              groupValue: projectStatus,
                              onChanged: (value) {
                                setState(() {
                                  projectStatus = value as String;
                                });
                              },
                            ),
                            Text(
                              'On-Going',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  color: projectStatus == 'On-Going'
                                      ? Colors.black
                                      : AppColors.secondaryText),
                            )
                          ],
                        ),
                      ],
                    ),

                    if (projectStatus == 'Completed')
                      GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: AbsorbPointer(
                          child: TextFieldWithTitle(
                            title: 'Completion Date, if “Completed” selected above.',
                            starNeeded: false,
                            hintText: 'YYYY-MM-DD',
                            controller: completionDateController,
                            spaceBtwTextField: Sizes.responsiveMd(context),
                            prefix: Icon(
                              Icons.calendar_month_sharp,
                              size: 16,
                              color: AppColors.secondaryText,
                            ),
                            validator: (value) {
                              if (projectStatus == 'Completed' && (value == null || value.isEmpty)) {
                                return 'Completion Date is required for completed projects';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                  ],
                ),


                SizedBox(height: Sizes.responsiveMd(context)),
                TextFieldWithTitle(
                  title: 'Project Description',
                  hintText: 'Tell us about your project...',
                  controller: descriptionController,
                  spaceBtwTextField: Sizes.responsiveMd(context),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Project Description is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Sizes.responsiveMd(context) * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(Sizes.radiusSm)),
                          padding: EdgeInsets.symmetric(
                              vertical: Sizes.responsiveHorizontalSpace(context),
                              horizontal: Sizes.responsiveMdSm(context)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveProject();
                          }
                        },


                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                        )),
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
                        bool success = await _saveProject();
                        if (success) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => AddProfileSummary()));
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
