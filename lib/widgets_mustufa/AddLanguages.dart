// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Profile_Screen.dart';
// import 'package:hiremi_version_two/Utils/AppSizes.dart';
// import 'package:hiremi_version_two/Utils/colors.dart';
// import 'package:hiremi_version_two/bottomnavigationbar.dart';
// import 'package:hiremi_version_two/widgets_mustufa/TextFieldWithTitle.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class AddLanguages extends StatefulWidget {
//   const AddLanguages({Key? key}) : super(key: key);
//
//   @override
//   State<AddLanguages> createState() => _AddLanguagesState();
// }
//
// class _AddLanguagesState extends State<AddLanguages> {
//   final TextEditingController languageController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   int? profileId;
//
//   Future<void> loadProfileID() async {
//     final prefs = await SharedPreferences.getInstance();
//     profileId = prefs.getInt('profileId');
//     print("profileId is $profileId");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfileID();
//   }
//
//   Future<void> _submitLanguage() async {
//     if (_formKey.currentState!.validate()) {
//       final language = languageController.text.trim();
//
//       if (profileId != null && language.isNotEmpty) {
//         final url = Uri.parse('http://13.127.81.177:8000/api/languages/');
//         final headers = {'Content-Type': 'application/json'};
//         final body = jsonEncode({
//           'language': language,
//           'profile': profileId,
//         });
//
//         try {
//           final response = await http.post(url, headers: headers, body: body);
//           if (response.statusCode == 201) {
//             // Language added successfully
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (ctx) => NewNavbar(
//                   initTabIndex: 3, // Navigate to the desired screen
//                   isV: true, // Pass the verification status
//                 ),
//               ),
//             );
//           } else {
//             // Handle error
//             print('Failed to add language: ${response.body}');
//           }
//         } catch (e) {
//           print('Error occurred: $e');
//         }
//       } else {
//         // Handle missing profileId or empty language
//         print('Profile ID or language is missing');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: Sizes.responsiveXl(context),
//             right: Sizes.responsiveDefaultSpace(context),
//             bottom: kToolbarHeight,
//             left: Sizes.responsiveDefaultSpace(context),
//           ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Languages',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: Sizes.responsiveMd(context),
//                 ),
//                 TextFieldWithTitle(
//                   controller: languageController,
//                   title: 'Add Language',
//                   hintText: 'eg: Hindi, English etc.',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a language';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: Sizes.responsiveMd(context) * 2),
//                 Center(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(Sizes.radiusSm),
//                       ),
//                       padding: EdgeInsets.symmetric(
//                         vertical: Sizes.responsiveHorizontalSpace(context),
//                         horizontal: Sizes.responsiveMdSm(context),
//                       ),
//                     ),
//                     onPressed: _submitLanguage,
//                     child: const Text(
//                       'Save',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/api_services/base_services.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:hiremi_version_two/widgets_mustufa/TextFieldWithTitle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddLanguages extends StatefulWidget {
  const AddLanguages({Key? key}) : super(key: key);

  @override
  State<AddLanguages> createState() => _AddLanguagesState();
}

class _AddLanguagesState extends State<AddLanguages> {
  final TextEditingController languageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? profileId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAndLoadLanguages();
  }


  Future<void> _fetchAndLoadLanguages() async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    profileId = prefs.getInt('profileId');

    if (profileId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile ID not found.')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final response = await http.get(Uri.parse('${ApiUrls.baseurl}/api/languages/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Find the language associated with the profileId
      final profileData = data.where((item) => item['profile'] == profileId).toList();

      if (profileData.isNotEmpty) {
        languageController.text = profileData.last['language'] ?? '';
      } else {
        print("No languages found for this profile");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load languages.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _submitLanguage() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final language = languageController.text.trim();

      if (profileId != null && language.isNotEmpty) {
        final url = Uri.parse('${ApiUrls.baseurl}/api/languages/');
        final headers = {'Content-Type': 'application/json'};
        final body = jsonEncode({
          'language': language,
          'profile': profileId,
        });

        try {
          final response = await http.post(url, headers: headers, body: body);
          if (response.statusCode == 201) {

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => NewNavbar(
                  initTabIndex: 3, // Navigate to the desired screen
                  isV: true, // Pass the verification status
                ),
              ),
            );
          } else {
            // Handle error
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to add language.')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error occurred while adding language.')),
          );
        }
      } else {
        // Handle missing profileId or empty language
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile ID or language is missing.')),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                  'Languages',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: Sizes.responsiveMd(context),
                ),
                TextFieldWithTitle(
                  controller: languageController,
                  title: 'Add Language',
                  hintText: 'eg: Hindi, English etc.',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a language';
                    }
                    return null;
                  },
                ),
                SizedBox(height: Sizes.responsiveMd(context) * 2),
                Center(
                  child: ElevatedButton(
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
                    onPressed: _submitLanguage,
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
