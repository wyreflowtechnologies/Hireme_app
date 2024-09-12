//
// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
// import 'package:hiremi_version_two/Custom_Widget/RoundedContainer/roundedContainer.dart';
// import 'package:hiremi_version_two/Utils/AppSizes.dart';
// import 'package:hiremi_version_two/Utils/colors.dart';
// import 'package:hiremi_version_two/widgets_mustufa/AddLanguages.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class Languages extends StatefulWidget {
//   const Languages({Key? key}) : super(key: key);
//
//   @override
//   State<Languages> createState() => _LanguagesState();
// }
//
// class _LanguagesState extends State<Languages> {
//   int? profileId;
//   String? lastLanguage;
//
//   @override
//   void initState() {
//     super.initState();
//     loadProfileID();
//   }
//
//   Future<void> loadProfileID() async {
//     final prefs = await SharedPreferences.getInstance();
//     profileId = prefs.getInt('profileId');
//     if (profileId != null) {
//       await fetchLanguages();
//     }
//   }
//
//   Future<void> fetchLanguages() async {
//     final url = Uri.parse('http://13.127.81.177:8000/api/languages/');
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         List<dynamic> languages = jsonDecode(response.body);
//         // Filter languages by profileId
//         List<dynamic> filteredLanguages = languages
//             .where((lang) => lang['profile'] == profileId)
//             .toList();
//
//         if (filteredLanguages.isNotEmpty) {
//           setState(() {
//             // Get the last language
//             lastLanguage = filteredLanguages.last['language'];
//           });
//         }
//       } else {
//         print('Failed to fetch languages: ${response.body}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedContainer(
//       showEdit: true,
//       onTap: () async {
//         final result = await Navigator.of(context).push(
//           MaterialPageRoute(builder: (context) => const AddLanguages()),
//         );
//         if (result == true) {
//           await fetchLanguages(); // Refresh the language list
//         }
//       },
//       title: 'Languages',
//       child: lastLanguage != null
//           ? RoundedContainer(
//         radius: Sizes.radiusMd,
//         padding: EdgeInsets.symmetric(
//             horizontal: Sizes.responsiveHorizontalSpace(context),
//             vertical: Sizes.responsiveVerticalSpace(context)),
//         border: Border.all(width: 0.5, color: AppColors.primary),
//         child: Text(
//           lastLanguage!,
//           style: TextStyle(
//               fontSize: 10.0,
//               fontWeight: FontWeight.w400,
//               color: AppColors.primary),
//         ),
//       )
//           : const Text('No languages found.'),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Custom_Widget/RoundedContainer/roundedContainer.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/widgets_mustufa/AddLanguages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Languages extends StatefulWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  int? profileId;
  List<String> languagesList = [];

  @override
  void initState() {
    super.initState();
    loadProfileID();
  }

  Future<void> loadProfileID() async {
    final prefs = await SharedPreferences.getInstance();
    profileId = prefs.getInt('profileId');
    if (profileId != null) {
      await fetchLanguages();
    }
  }

  Future<void> fetchLanguages() async {
    final url = Uri.parse('${ApiUrls.baseurl}/api/languages/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> languages = jsonDecode(response.body);
        // Filter languages by profileId
        List<dynamic> filteredLanguages = languages
            .where((lang) => lang['profile'] == profileId)
            .toList();

        if (filteredLanguages.isNotEmpty) {
          setState(() {
            // Only take the languages from the last entry
            String lastLanguageEntry = filteredLanguages.last['language'];
            // Split the last language entry by spaces
            languagesList = lastLanguageEntry.split(',');
          });
        }
      } else {
        print('Failed to fetch languages: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      showEdit: true,
      onEditTap: () async {
        final result = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddLanguages()),
        );
        if (result == true) {
          await fetchLanguages(); // Refresh the language list
        }
      },
      title: 'Languages',
      child: languagesList.isNotEmpty
          ? Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: languagesList.map((language) {
          return Padding(
            padding: EdgeInsets.only(
              right: Sizes.responsiveSm(context),
              bottom: Sizes.responsiveSm(context),
            ),
            child: RoundedContainer(
              radius: Sizes.radiusMd,
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.responsiveHorizontalSpace(context),
                vertical: Sizes.responsiveVerticalSpace(context),
              ),
              border: Border.all(width: 0.5, color: AppColors.primary),
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        }).toList(),
      )
          : const Text('No languages found.'),
    );
  }
}
