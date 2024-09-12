import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiremi_version_two/Profile_Screen.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:hiremi_version_two/widgets_mustufa/AddLanguages.dart';
import 'package:hiremi_version_two/widgets_mustufa/TextFieldWithTitle.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'package:shared_preferences/shared_preferences.dart';

import 'API_Integration/Add Personal Details/apiServices.dart';

class AddPersonalDetails extends StatefulWidget {
  const AddPersonalDetails({Key? key}) : super(key: key);

  @override
  State<AddPersonalDetails> createState() => _AddPersonalDetailsState();
}

class _AddPersonalDetailsState extends State<AddPersonalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedGender = '';
  String selectedMaritalStatus = '';
  String differentlyAbled = '';
  TextEditingController homeController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController localAddressController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  final AddPersonalDetailsService _apiService = AddPersonalDetailsService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  Future<void> _loadPersonalDetails() async {
    final service = AddPersonalDetailsService();
    final details = await service.getPersonalDetails();

    setState(() {
      selectedGender = details['gender'] ?? '';
      selectedMaritalStatus = details['marital_status'] ?? '';
      differentlyAbled = details['ability'] ?? '';

      homeController.text = details['home_town'] ?? '';
      pinCodeController.text = details['pincode']?.toString() ?? '';
      localAddressController.text = details['local_address'] ?? '';
      permanentAddressController.text = details['permanent_address'] ?? '';
      dobController.text = details['date_of_birth'] ?? '';
      categoryController.text = details['category'] ?? '';
      nationalityController.text = details['nationality'] ?? '';
    });
  }

  Future<void> _savePersonalDetails() async {
    if (_formKey.currentState?.validate() ?? false) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? profileId = prefs.getInt('profileId').toString();
      print('Profile ID: $profileId');

      if (profileId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile ID not found')),
        );
        return;
      }

      final details = {
        "date_of_birth": dobController.text,
        "gender": selectedGender,
        "marital_status": selectedMaritalStatus,
        "nationality": nationalityController.text,
        "home_town": homeController.text,
        "pincode": pinCodeController.text,
        "local_address": localAddressController.text,
        "permanent_address": permanentAddressController.text,
        "ability": differentlyAbled,
        "category": categoryController.text,
        "profile": profileId,
      };
      print(details);

      final success = await _apiService.addPersonalDetails(details);

      if (success) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Personal details added successfully')),
        // );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => NewNavbar(
              initTabIndex: 3, // Navigate to Profile tab
              isV: true, // Pass the verification status
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add personal details'),
            duration: Duration(seconds: 1), // Set the duration here
          ),
        );
      }
    }
  }

  Future<void> _saveAndNext() async {
    if (_formKey.currentState?.validate() ?? false) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? profileId = prefs.getInt('profileId').toString();
      print('Profile ID: $profileId');

      if (profileId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile ID not found')),
        );
        return;
      }

      final details = {
        "date_of_birth": dobController.text,
        "gender": selectedGender,
        "marital_status": selectedMaritalStatus,
        "nationality": nationalityController.text,
        "home_town": homeController.text,
        "pincode": pinCodeController.text,
        "local_address": localAddressController.text,
        "permanent_address": permanentAddressController.text,
        "ability": differentlyAbled,
        "category": categoryController.text,
        "profile": profileId,
      };
      print(details);

      final success = await _apiService.addPersonalDetails(details);

      if (success) {
        print("Success is $success");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Personal details added successfully'),
            duration: Duration(seconds: 1), // Set the duration here
          ),
        );
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => AddLanguages()));
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add personal details'),
            duration: Duration(seconds: 1), // Set the duration here
          ),
        );
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPersonalDetails();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: Sizes.responsiveXl(context),
                right: Sizes.responsiveDefaultSpace(context),
                bottom: Sizes.responsiveXxl(context) * 2.4,
                left: Sizes.responsiveDefaultSpace(context)),
            child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Gender',
                          style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
                    SizedBox(height: Sizes.responsiveXxs(context),),
                    Row(children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blue,
                            value: 'Male',
                            groupValue: selectedGender,
                            onChanged: (value) => setState(() {
                              selectedGender = value as String;
                            }),
                          ),
                          Text(
                            'Male',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: selectedGender == 'Male'
                                    ? Colors.black
                                    : AppColors.secondaryText),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blue,
                            value: 'Female',
                            groupValue: selectedGender,
                            onChanged: (value) => setState(() {
                              selectedGender = value as String;
                            }),
                          ),
                          Text(
                            'Female',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: selectedGender == 'Female'
                                    ? Colors.black
                                    : AppColors.secondaryText),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blue,
                            value: 'Other',
                            groupValue: selectedGender,
                            onChanged: (value) => setState(() {
                              selectedGender = value as String;
                            }),
                          ),
                          Text(
                            'Other',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: selectedGender == 'Other'
                                    ? Colors.black
                                    : AppColors.secondaryText),
                          )
                        ],
                      ),
                    ]),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Marital Status',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: Sizes.responsiveXxs(context),),
                    Row(children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blue,
                            value: 'Single',
                            groupValue: selectedMaritalStatus,
                            onChanged: (value) => setState(() {
                              selectedMaritalStatus = value as String;
                            }),
                          ),
                          Text(
                            'Single / Unmarried',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: selectedMaritalStatus ==
                                    'Single / Unmarried'
                                    ? Colors.black
                                    : AppColors.secondaryText),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blue,
                            value: 'Married',
                            groupValue: selectedMaritalStatus,
                            onChanged: (value) => setState(() {
                              selectedMaritalStatus = value as String;
                            }),
                          ),
                          Text(
                            'Married',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: selectedMaritalStatus == 'Married'
                                    ? Colors.black
                                    : AppColors.secondaryText),
                          ),
                        ],
                      ),
                    ]),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Differently Abled',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: Sizes.responsiveXxs(context),),
                    Row(children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blue,
                            value: 'Yes',
                            groupValue: differentlyAbled,
                            onChanged: (value) => setState(() {
                              differentlyAbled = value as String;
                            }),
                          ),
                          Text(
                            'Yes',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: differentlyAbled == 'Yes'
                                    ? Colors.black
                                    : AppColors.secondaryText),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: Colors.blue,
                            value: 'No',
                            groupValue: differentlyAbled,
                            onChanged: (value) => setState(() {
                              differentlyAbled = value as String;
                            }),
                          ),
                          Text(
                            'No',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: differentlyAbled == 'No'
                                    ? Colors.black
                                    : AppColors.secondaryText),
                          )
                        ],
                      ),
                    ]),
                  ],
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                Column(
                  children: [
                    TextFieldWithTitle(
                      controller: homeController,
                      maxLines:1,
                      title: 'Home Town',
                      hintText: 'Enter home town',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your home town';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Sizes.responsiveMd(context),
                    ),
                    TextFieldWithTitle(
                      controller: pinCodeController,
                      maxLines:1,
                      keyboardType: TextInputType.number, // Numeric keyboard
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Only digits allowed
                      ],
                      title: 'Pincode',
                      hintText: 'Enter pincode',

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your pincode';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Sizes.responsiveMd(context),
                    ),
                    TextFieldWithTitle(
                      controller: localAddressController,
                      title: 'Local Address',
                      hintText: 'Enter local address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your local address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Sizes.responsiveMd(context),
                    ),
                    TextFieldWithTitle(
                      controller: permanentAddressController,
                      title: 'Permanent Address',
                      hintText: 'Enter permanent address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your permanent address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Sizes.responsiveMd(context),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFieldWithTitle(
                          controller: dobController,
                          title: 'Date of Birth',
                          hintText: 'Enter date of birth',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your date of birth';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Sizes.responsiveMd(context),
                    ),
                    TextFieldWithTitle(
                      controller: categoryController,
                      maxLines:1,
                      title: 'Category',
                      hintText: 'Enter category',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your category';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Sizes.responsiveMd(context),
                    ),
                    // TextFieldWithTitle(
                    //   controller: nationalityController,
                    //   title: 'Nationality',
                    //   hintText: 'Enter nationality',
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your nationality';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ],
                ),
                SizedBox(
                  height: Sizes.responsiveXxl(context),
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
                        onPressed: _savePersonalDetails,
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
                          side:   BorderSide(color: AppColors.primary,width: 0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Sizes.radiusSm)),
                          padding: EdgeInsets.symmetric(
                              vertical: Sizes.responsiveSm(context),
                              horizontal: Sizes.responsiveMdSm(context)),
                        ),
                        onPressed: _saveAndNext,
                        child:  Row(
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
                        )),
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}
