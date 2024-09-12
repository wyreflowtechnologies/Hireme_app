import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Internships/eligibilityCriteria.dart';
import 'package:hiremi_version_two/Internships/HeaderSectionInternship.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/Internships/roleDetails.dart';
import 'package:hiremi_version_two/Internships/skillsRequired.dart';
import 'package:hiremi_version_two/Provider/InternshipProvider.dart';

import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/API_Integration/Internship/Apiservices.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../API_Integration/Apply Fresher Jobs/apiServices.dart';
import '../Apis/api.dart';

class DetailedInternship extends StatefulWidget {
  final int id;
  final String profile;
  final String location;
  final String codeRequired;
  final int code;
  final String companyName;
  final String education;
  final String skillsRequired;

  final String? knowledgeStars;
  final String whoCanApply;
  final String description;
  final String termsAndConditions;
  final double ctc;
  final String benefits;
  final String daysPosted;
  final String mode;
  final String aboutCompany;
  final String exp;

  const DetailedInternship({
    Key? key,
    required this.id,
    required this.profile,
    required this.location,
    required this.codeRequired,
    required this.code,
    required this.companyName,
    required this.education,
    required this.skillsRequired,
    this.knowledgeStars,
    required this.whoCanApply,
    required this.description,
    required this.termsAndConditions,
    required this.ctc,
    required this.aboutCompany,
    required this.benefits,
    required this.daysPosted,
    required this.mode,
    required this.exp,
  }) : super(key: key);

  @override
  State<DetailedInternship> createState() => _DetailedInternshipState();
}

class _DetailedInternshipState extends State<DetailedInternship> {
  bool _isApplied = false;
  int? userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchApplications();

    _retrieveId();
  }
  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      setState(() {
        userId = savedId;
      });
      print("Retrieved id is $savedId");
    } else {
      print("No id found in SharedPreferences");
    }
  }
  Future<void> _fetchApplications() async {
    final apiService = ApiService('${ApiUrls.baseurl}/api/internship-applications/');
    final applications=await  apiService.fetchData();
    setState(() {
      _isApplied = applications.any((application) =>
      application['internship'] == widget.id &&
          application['register'] == userId);
    });
  }
  Future<void> showConfirmationDialog(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(screenWidth * 0.04),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              size: screenWidth * 0.032,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: screenWidth * 0.310,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Icon(
                          Icons.error_rounded,
                          color: const Color(0xFFC1272D),
                          size: screenWidth * 0.105,
                        ),
                        Container(
                          height: 1,
                          width: screenWidth * 0.310,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      'Are you sure you want to apply?',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.04),
                        color: Colors.green,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          _applyForInternship();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _applyForInternship() async {


    try {
      await ApiServices.applyForInternship(widget.id, context);
      // setState(() {
      //   _isApplied = true;
      // });

    } catch (error) {

      print('Error applying for Internship: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            print("Hello");
            final prefs = await SharedPreferences.getInstance();
            final int? savedId = prefs.getInt('userId');
            final internshipProvider = Provider.of<InternshipProvider>(context, listen: false);
            await internshipProvider.setUserId(savedId!);
            internshipProvider.fetchJobs();
            internshipProvider.fetchApplications();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const NotificationScreen()));
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.responsiveXl(context),
            right: Sizes.responsiveDefaultSpace(context),
            bottom: kToolbarHeight * 1.5,
            left: Sizes.responsiveDefaultSpace(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Sections
              HeaderSectionInternship(
                profile: widget.profile,
                companyName: widget.companyName,
                location: widget.location,
                mode:widget.mode,
                education:widget.education,
                daysPosted:widget.daysPosted,
                ctc: widget.ctc,
                exp:widget.exp,
                onTap:()async{
                  // await showConfirmationDialog(context);
                  if (_isApplied) {
                    // If the job is already applied
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('You have already applied for this Internship.'),
                        backgroundColor: Colors.redAccent,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // If not applied, proceed with the confirmation dialog
                  await showConfirmationDialog(context);
                } ,
                buttonText: _isApplied ? 'Applied >' : 'Apply Now',
              ),
              SizedBox(height: Sizes.responsiveXl(context)),

              /// Role Details
              RoleDetailsInternship(
                profile: widget.profile,
                location: widget.location,
                ctc: widget.ctc,
                description: widget.description,
              ),
              SizedBox(
                height: Sizes.responsiveLg(context),
              ),

              /// Skill Required
              SkillRequiredInternship(
                skillsRequired: widget.skillsRequired,
              ),
              // BenefitSection(),
              SizedBox(
                height: Sizes.responsiveLg(context),
              ),
              BenefitsSection(
                benefits: widget.benefits,
              ),
              SizedBox(
                height: Sizes.responsiveLg(context),
              ),

              /// Eligibility Criteria
              EligibilityCriteriaAboutCompanyInternship(
                  companyName:widget.companyName,
                  whoCanApply:widget.whoCanApply,
                  aboutCompany:widget.aboutCompany, education: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class BenefitsSection extends StatelessWidget {
  final String benefits;

  const BenefitsSection({Key? key, required this.benefits}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         'Benefits',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           color: Theme.of(context).primaryColor,
  //         ),
  //       ),
  //       SizedBox(height: 8),
  //       Text(
  //         benefits,
  //         style: TextStyle(fontSize: 14, color: Colors.black87),
  //       ),
  //     ],
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    // Assuming `benefits` is a string of comma-separated values
    List<String> benefitsList = benefits.split(',');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Benefits',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary)),
        SizedBox(
          height: 8,
        ),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: benefitsList.map((benefit) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6E5),
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.01),
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: Text(
                benefit,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

}
