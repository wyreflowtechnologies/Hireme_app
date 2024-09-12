// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hiremi_version_two/API_Integration/Add%20Links/apiServices.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Utils/AppSizes.dart';
// import '../Utils/colors.dart';
// import '../Edit_Profile_Section/widgets/CustomTextField.dart';
//
// class EditLinksPage extends StatefulWidget {
//   @override
//   _EditLinksPageState createState() => _EditLinksPageState();
// }
//
// class _EditLinksPageState extends State<EditLinksPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _linkedInController = TextEditingController();
//   final TextEditingController _gitHubController = TextEditingController();
//   final TextEditingController _portfolioController = TextEditingController();
//   final TextEditingController _otherController = TextEditingController();
//
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadLinks();
//   }
//
//   Future<void> _loadLinks() async {
//     final prefs = await SharedPreferences.getInstance();
//     _linkedInController.text = prefs.getString('linkedInLink') ?? '';
//     _gitHubController.text = prefs.getString('gitHubLink') ?? '';
//     _portfolioController.text = prefs.getString('portfolioLink') ?? '';
//     _otherController.text = prefs.getString('otherLink') ?? '';
//   }
//
//   Future<void> _saveLinks() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final prefs = await SharedPreferences.getInstance();
//     final profileID = prefs.getInt('profileId')?.toString();
//
//     if (profileID == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Profile ID not found.')),
//       );
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }
//
//     final apiService = LinksApiService();
//     final details = {
//       'linkedin_url': _linkedInController.text.trim(),
//       'github_url': _gitHubController.text.trim(),
//       'Portfolio': _portfolioController.text.trim(),
//       'Others': _otherController.text.trim(),
//       'profile': profileID,
//     };
//
//     final success = await apiService.addOrUpdateLinks(details);
//
//     if (success) {
//       await prefs.setString('linkedInLink', _linkedInController.text.trim());
//       await prefs.setString('gitHubLink', _gitHubController.text.trim());
//       await prefs.setString('portfolioLink', _portfolioController.text.trim());
//       await prefs.setString('otherLink', _otherController.text.trim());
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Links saved successfully!')),
//       );
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to save links.')),
//       );
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   Widget _buildLinkField({
//     required TextEditingController controller,
//     required Widget icon,
//     required String hintText,
//   }) {
//     return Column(
//       children: [
//         CustomTextField(
//           controller: controller,
//           hintText: hintText,
//           prefix: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 8.0, left: 10),
//                 child: icon,
//               ),
//             ],
//           ),
//           validator: (value) {
//             if (value == null || value.isEmpty) {
//               return 'Please enter a $hintText link';
//             }
//             final urlPattern = r'^(https?:\/\/)';
//             final regExp = RegExp(urlPattern, caseSensitive: false);
//             if (!regExp.hasMatch(value)) {
//               return 'Please enter a valid URL';
//             }
//             return null;
//           },
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Links"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildLinkField(
//                 controller: _linkedInController,
//                 icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue, size: 20),
//                 hintText: 'LinkedIn',
//               ),
//               _buildLinkField(
//                 controller: _gitHubController,
//                 icon: const FaIcon(FontAwesomeIcons.github, color: AppColors.black, size: 20),
//                 hintText: 'GitHub',
//               ),
//               _buildLinkField(
//                 controller: _portfolioController,
//                 icon: const FaIcon(FontAwesomeIcons.briefcase, color: AppColors.black, size: 20),
//                 hintText: 'Portfolio',
//               ),
//               _buildLinkField(
//                 controller: _otherController,
//                 icon: const FaIcon(FontAwesomeIcons.link, color: AppColors.black, size: 20),
//                 hintText: 'Other',
//               ),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(Sizes.radiusSm),
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     vertical: Sizes.responsiveHorizontalSpace(context),
//                     horizontal: Sizes.responsiveMdSm(context),
//                   ),
//                 ),
//                 onPressed: _isLoading ? null : () async {
//                   await _saveLinks();
//                 },
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text(
//                   'Save',
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:hiremi_version_two/bottomnavigationbar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hiremi_version_two/API_Integration/Add%20Links/apiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/api.dart';
import '../Utils/AppSizes.dart';
import '../Utils/colors.dart';
import '../Edit_Profile_Section/widgets/CustomTextField.dart';

class EditLinksPage extends StatefulWidget {
  @override
  _EditLinksPageState createState() => _EditLinksPageState();
}

class _EditLinksPageState extends State<EditLinksPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _linkedInController = TextEditingController();
  final TextEditingController _gitHubController = TextEditingController();
  final TextEditingController _portfolioController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();

  bool _isLoading = false;
  int? profileId;

  @override
  void initState() {
    super.initState();
    _loadProfileId();
    _fetchAndLoadLinks();
    //_fetchLinks();
  }

  Future<void> _loadProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    profileId = prefs.getInt('profileId');
  }

  Future<void> _fetchAndLoadLinks() async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final profileID = prefs.getInt('profileId');

    if (profileID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile ID not found.')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final response = await http.get(Uri.parse('${ApiUrls.baseurl}/api/links/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      final profileData = data.firstWhere(
            (item) => item['profile'] == profileID,
        orElse: () => null,
      );

      if (profileData != null) {
        _linkedInController.text = profileData['linkedin_url'] ?? '';
        _gitHubController.text = profileData['github_url'] ?? '';
        _portfolioController.text = profileData['Portfolio'] ?? '';
        _otherController.text = profileData['Others'] ?? '';
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('No data found for this profile.')),
        // );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load links.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveLinks() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final profileID = prefs.getInt('profileId')?.toString();

    if (profileID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile ID not found.')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final apiService = LinksApiService();
    final details = {
      'linkedin_url': _linkedInController.text.trim(),
      'github_url': _gitHubController.text.trim(),
      'Portfolio': _portfolioController.text.trim(),
      'Others': _otherController.text.trim(),
      'profile': profileID,
    };

    final success = await apiService.addOrUpdateLinks(details);

    if (success) {
      await prefs.setString('linkedInLink', _linkedInController.text.trim());
      await prefs.setString('gitHubLink', _gitHubController.text.trim());
      await prefs.setString('portfolioLink', _portfolioController.text.trim());
      await prefs.setString('otherLink', _otherController.text.trim());

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Links saved successfully!')),
      // );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => NewNavbar(
            initTabIndex: 3,
            isV: true,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save links.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildLinkField({
    required TextEditingController controller,
    required Widget icon,
    required String hintText,
  }) {
    return Column(
      children: [
        CustomTextField(
          controller: controller,
          hintText: hintText,
          prefix: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 10),
                child: icon,
              ),
            ],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a $hintText link';
            }
            final urlPattern = r'^(https?:\/\/)';
            final regExp = RegExp(urlPattern, caseSensitive: false);
            if (!regExp.hasMatch(value)) {
              return 'Please enter a valid URL';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Links"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildLinkField(
                controller: _linkedInController,
                icon: const FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue, size: 20),
                hintText: 'LinkedIn',
              ),
              _buildLinkField(
                controller: _gitHubController,
                icon: const FaIcon(FontAwesomeIcons.github, color: AppColors.black, size: 20),
                hintText: 'GitHub',
              ),
              _buildLinkField(
                controller: _portfolioController,
                icon: const FaIcon(FontAwesomeIcons.briefcase, color: AppColors.black, size: 20),
                hintText: 'Portfolio',
              ),
              _buildLinkField(
                controller: _otherController,
                icon: const FaIcon(FontAwesomeIcons.link, color: AppColors.black, size: 20),
                hintText: 'Other',
              ),
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
                onPressed: _isLoading ? null : () async {
                  await _saveLinks();
                },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
