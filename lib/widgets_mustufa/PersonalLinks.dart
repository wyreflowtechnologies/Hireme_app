import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hiremi_version_two/Edit_Profile_Section/editLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom_Widget/CustomContainer/OutlinedButton.dart';
import '../Utils/AppSizes.dart';
import '../Utils/colors.dart';

class SocialLinks extends StatefulWidget {
  const SocialLinks({Key? key}) : super(key: key);

  @override
  _SocialLinksState createState() => _SocialLinksState();
}

class _SocialLinksState extends State<SocialLinks> {
  Map<String, String> _socialLinks = {
    'linkedin_url': '',
    'github_url': '',
    'Portfolio': '',
    'Others': '',
  };

  @override
  void initState() {
    super.initState();
    _loadSocialLinks();
  }

  Future<void> _loadSocialLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final profileId = prefs.getInt('profileId');
    if (profileId != null) {
      setState(() {
        _socialLinks = {
          'linkedin_url': prefs.getString('linkedInLink') ?? '',
          'github_url': prefs.getString('gitHubLink') ?? '',
          'Portfolio': prefs.getString('portfolioLink') ?? '',
          'Others': prefs.getString('otherLink') ?? '',
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasLinks = _socialLinks.values.any((link) => link.isNotEmpty);

    return OutlinedContainer(
      title: 'Social Links',
      showEdit: true,
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditLinksPage()),
        );
        _loadSocialLinks();
      },
      child: hasLinks
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _socialLinks.entries.map((entry) {
          if (entry.value.isNotEmpty) {
            return Container(
              margin: EdgeInsets.only(bottom: Sizes.responsiveSm(context)),
              padding: EdgeInsets.symmetric(
                vertical: Sizes.responsiveXs(context),
                horizontal: Sizes.responsiveSm(context),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: AppColors.secondaryText,
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  _getIcon(entry.key),
                  SizedBox(width: Sizes.responsiveSm(context)),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.75),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        }).toList(),
      )
          : SizedBox.shrink(),
    );
  }

  Widget _getIcon(String platform) {
    switch (platform) {
      case 'linkedin_url':
        return FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue, size: 20);
      case 'github_url':
        return FaIcon(FontAwesomeIcons.github, color: AppColors.black, size: 20);
      case 'Portfolio':
        return FaIcon(FontAwesomeIcons.briefcase, color: AppColors.black, size: 20);
      case 'Others':
        return FaIcon(FontAwesomeIcons.link, color: AppColors.black, size: 20);
      default:
        return SizedBox.shrink();
    }
  }
}
