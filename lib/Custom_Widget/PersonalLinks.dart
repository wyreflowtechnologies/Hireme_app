
import 'dart:convert';
import 'dart:math';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Custom_Widget/roundedContainer.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/editLinks.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalLinks extends StatefulWidget {
  const PersonalLinks({Key? key}) : super(key: key);

  @override
  State<PersonalLinks> createState() => _PersonalLinksState();
}

class _PersonalLinksState extends State<PersonalLinks> {
  String _linkedinUrl = '';
  String _gitHubUrl = '';
  String _portofolio="";
  String _other="";
  String profileId = '';

  @override
  void initState() {
    super.initState();
    _loadProfileId();
  }

  Future<void> _loadProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('profileId'); // Fetching the profileId from SharedPreferences
    profileId = savedId?.toString() ?? '';
    if (profileId.isNotEmpty) {
      _fetchLinks();
    }
  }

  Future<void> _fetchLinks() async {
    final url = Uri.parse('${ApiUrls.baseurl}/api/links/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> linksData = json.decode(response.body);
        final links = linksData.firstWhere(
              (link) => link['profile'].toString() == profileId,
          orElse: () => null,
        );

        if (links != null) {
          setState(() {
            _linkedinUrl = links['linkedin_url'] ?? '';
            _gitHubUrl = links['github_url'] ?? '';
            _portofolio=links['Portfolio'] ?? '';
            _other=links['Others'] ?? '';
          });
        }
      } else {
        // Handle other status codes or error responses
        print('Failed to load links: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching links: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      showEdit: false,
      title: 'Add Links',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PersonalLinksChild(
            platform: 'LinkedIn',
            link: _linkedinUrl,
          ),
          SizedBox(
            height: Sizes.responsiveMd(context),
          ),
          PersonalLinksChild(
            platform: 'Github',
            link: _gitHubUrl,
          ),
          SizedBox(
            height: Sizes.responsiveMd(context),
          ),
          PersonalLinksChild(
            platform: 'Portfolio',
            link: _portofolio,
          ),
          SizedBox(
            height: Sizes.responsiveMd(context),
          ),
          PersonalLinksChild(
            platform: 'Other',
            link: _other,
          ),
          SizedBox(
            height: Sizes.responsiveMd(context),
          ),
          SizedBox(
            width: Sizes.responsiveXxl(context) * 2.3,
            height: Sizes.responsiveLg(context) * 1.06,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.radiusXs),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.responsiveHorizontalSpace(context),
                  horizontal: Sizes.responsiveMdSm(context),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditLinksPage(),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Text(
                    'Add Links ',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: AppColors.white),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 8,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalLinksChild extends StatelessWidget {
  const PersonalLinksChild({
    Key? key,
    required this.platform,
    required this.link,
  }) : super(key: key);

  final String platform, link;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: RoundedContainer(
            color: link.isNotEmpty ? AppColors.green : Colors.transparent,
            border: Border.all(width: 0.5, color: AppColors.secondaryText),
            radius: 2,
            padding: EdgeInsets.only(
              left: Sizes.responsiveSm(context) * 1.15,
              top: Sizes.responsiveSm(context) * 0.9,
              bottom: Sizes.responsiveSm(context) * 0.9,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_link,
                  size: 9,
                  color: link.isNotEmpty
                      ? AppColors.white
                      : Colors.black.withOpacity(.75),
                ),
                SizedBox(
                  width: Sizes.responsiveHorizontalSpace(context),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: Sizes.responsiveSm(context),
                  ),
                  child: Text(
                    platform.isNotEmpty ? platform : 'Link Title',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: link.isNotEmpty
                          ? AppColors.white
                          : Colors.black.withOpacity(0.25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: Sizes.responsiveSm(context),
        ),
        Expanded(
          flex: 7,
          child: RoundedContainer(
            border: Border.all(
              width: 0.5,
              color: link.isNotEmpty
                  ? AppColors.green
                  : AppColors.secondaryText,
            ),
            radius: 2,
            padding: EdgeInsets.only(
              left: Sizes.responsiveSm(context) * 1.15,
              top: Sizes.responsiveSm(context) * 0.9,
              bottom: Sizes.responsiveSm(context) * 0.9,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: pi * 1.5,
                  child: Icon(
                    Icons.add_link,
                    size: 9.5,
                    color: link.isNotEmpty
                        ? Colors.blue
                        : Colors.black.withOpacity(.75),
                  ),
                ),
                SizedBox(
                  width: Sizes.responsiveHorizontalSpace(context),
                ),
                Text(
                  link.isNotEmpty ? link : 'Paste Link',
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w500,
                    color: link.isNotEmpty
                        ? Colors.blue
                        : Colors.black.withOpacity(0.25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
