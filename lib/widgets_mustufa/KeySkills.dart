import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/CustomContainer/OutlinedButton.dart';
import 'package:hiremi_version_two/Custom_Widget/RoundedContainer/roundedContainer.dart';
import 'package:hiremi_version_two/Edit_Profile_Section/Key%20Skills/AddKeySkills.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';

import '../API_Integration/Add Key Skills/apiServices.dart';

class KeySkills extends StatefulWidget {
  const KeySkills({Key? key}) : super(key: key);

  @override
  _KeySkillsState createState() => _KeySkillsState();
}

class _KeySkillsState extends State<KeySkills> {
  List<String> skills = [];

  @override
  void initState() {
    super.initState();
    _loadKeySkills();
  }

  Future<void> _loadKeySkills() async {
    final service = AddKeySkillsService();
    final loadedSkills = await service.getKeySkills();
    setState(() {
      skills = loadedSkills
          .expand((skill) => skill.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty))
          .toList();
    });
  }

  bool isValid() {
    return skills.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      title: 'Key Skills',
      onTap: () async {
        // await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddKeySkills()));
        // await _loadKeySkills(); // Reload skills after returning from AddKeySkills screen
      },
      onEditTap: ()async{
        await Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddKeySkills()));
        await _loadKeySkills();
      },
      isTrue: isValid(),
      child: Wrap(
        runSpacing: 10,
        spacing: Sizes.responsiveSm(context),
        children: skills.map((skill) => RoundedContainer(
          radius: 16,
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.responsiveHorizontalSpace(context),
            vertical: Sizes.responsiveVerticalSpace(context),
          ),
          border: Border.all(width: 0.5, color: AppColors.primary),
          child: Text(
            skill,
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
              color: AppColors.primary,
            ),
          ),
        )).toList(),
      ),
    );
  }
}
