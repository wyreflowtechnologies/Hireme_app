
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/OppurtunityCard.dart';
import 'package:hiremi_version_two/Custom_Widget/drawer_child.dart';
import 'package:hiremi_version_two/FresherJobs.dart';
import 'package:hiremi_version_two/InternshipScreen.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/experienced_jobs.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Apis/api.dart';

class AppliesScreen extends StatefulWidget {
  final bool isVerified;
  const AppliesScreen({Key? key, required this.isVerified}) : super(key: key);

  @override
  State<AppliesScreen> createState() => _AppliesScreenState();
}

class _AppliesScreenState extends State<AppliesScreen> {
  List<dynamic> appliedInternships = [];
  List<dynamic> appliedFresherJobs = [];
  List<dynamic> appliedExperiencedJobs = [];
  bool isLoading = true;

  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      await Future.wait([
        _fetchAppliedData(savedId, 'internship', 'internship-applications', (data) => appliedInternships = data),
        _fetchAppliedData(savedId, 'fresherjob', 'job-applications', (data) => appliedFresherJobs = data),
        _fetchAppliedData(savedId, 'experiencejob', 'experience-job-applications', (data) => appliedExperiencedJobs = data),
      ]);
    } else {
      print("No id found in SharedPreferences");
    }
    setState(() {
      isLoading = false; // Set loading to false after fetching data
    });
  }

  Future<void> _fetchAppliedData(int userId, String jobType, String applicationType, Function(List<dynamic>) setData) async {
    final jobUrl = '${ApiUrls.baseurl}/api/$jobType/';
    final applicationUrl = '${ApiUrls.baseurl}/api/$applicationType/';

    try {
      final jobResponse = await http.get(Uri.parse(jobUrl));
      final applicationResponse = await http.get(Uri.parse(applicationUrl));

      if (jobResponse.statusCode == 200 && applicationResponse.statusCode == 200) {
        final jobData = jsonDecode(jobResponse.body);
        final applicationData = jsonDecode(applicationResponse.body);

        final List<dynamic> filteredJobs = applicationData
            .where((application) => application['register'] == userId)
            .map((application) {
          final jobId = application[jobType];
          final jobDetails = jobData.firstWhere((job) => job['id'] == jobId);
          jobDetails['candidate_status'] = application['candidate_status']; // Assign candidate_status
          jobDetails['applied_date'] = application['applied_date']; // Assign applied_date
          return jobDetails;
        }).toList();

        setState(() {
          setData(filteredJobs);
        });
      } else {
        print('Failed to fetch $jobType data');
      }
    } catch (error) {
      print('Error fetching $jobType data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _retrieveId();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Combine all applied job lists
    final combinedApplications = [
      ...appliedInternships,
      ...appliedFresherJobs,
      ...appliedExperiencedJobs,
    ];

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: const Text("Applies",
      //       style: TextStyle(fontWeight: FontWeight.bold)),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (ctx) => const NotificationScreen()));
      //       },
      //       icon: const Icon(Icons.notifications),
      //     ),
      //   ],
      // ),
      // drawer: Drawer(
      //   child: DrawerChild(isVerified: widget.isVerified),
      // ),
      // body: appliedInternships.isEmpty &&
      //     appliedFresherJobs.isEmpty &&
      //     appliedExperiencedJobs.isEmpty
      //     ? _buildNoApplicationsView(screenHeight, screenWidth)
      //     : _buildApplicationsListView(
      //     screenHeight, screenWidth, combinedApplications),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : appliedInternships.isEmpty &&
          appliedFresherJobs.isEmpty &&
          appliedExperiencedJobs.isEmpty
          ? _buildNoApplicationsView(screenHeight, screenWidth)
          : _buildApplicationsListView(
          screenHeight, screenWidth, combinedApplications),
    );
  }


  Widget _buildNoApplicationsView(double screenHeight, double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(screenHeight * 0.01),
            child: Image.asset('images/Empty-bro.png', height: screenHeight * 0.4),
          ),
          SizedBox(height: screenHeight * 0.002),
           Text('No Applies, Select from Hiremi’s Featured to', style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.018), textAlign: TextAlign.center),
           Text('start your journey today.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.018), textAlign: TextAlign.center),
          SizedBox(height: screenHeight * 0.01),
          _buildNavigationButtons(screenWidth),
       
          SizedBox(height: screenHeight * 0.015),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavigationButton(
            'Internships',
            'images/Group 170.png',
            Colors.orange,
                () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => InternshipsScreen(isVerified: widget.isVerified))),
          ),
          _buildNavigationButton(
            'Fresher Jobs',
            'images/Group 170 (1).png',
            Colors.red,
                () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FresherJobs(isVerified: widget.isVerified))),
          ),
          _buildNavigationButton(
            'Experienced Jobs',
            'images/Ex (2).png',
            Color(0xFFDA6C9B),
                () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ExperiencedJobs(isVerified: widget.isVerified))),
          ),

          SizedBox(height: screenWidth * 0.045),
        ],
      ),
    );
  }

  Widget _buildNavigationButton(
      String text,
      String imagePath,
      Color color,
      VoidCallback onPressed, {
        LinearGradient? gradient,
      }) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: gradient != null
                  ? BorderSide.none
                  : BorderSide(color: color, width: 2),
            ),
          ),
          side: gradient != null
              ? MaterialStateProperty.all<BorderSide>(BorderSide.none)
              : MaterialStateProperty.all<BorderSide>(BorderSide(color: color, width: 2)),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        child: Container(
          decoration: gradient != null
              ? BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10.0),
          )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(imagePath),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                text,
                style: TextStyle(color: color, fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildApplicationsListView(double screenHeight, double screenWidth,
      List<dynamic> combinedApplications) {
    return Column(
      children: [
        // Display the total number of applied jobs
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.04, top: screenHeight * 0.02),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "You've Applied (${combinedApplications.length})",
              style: const TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: combinedApplications.length,
            itemBuilder: (context, index) {
              final application = combinedApplications[index];

              // Determine the type of job based on the data source
              final type = (appliedFresherJobs.contains(application))
                  ? 'Job'
                  : (appliedExperiencedJobs.contains(application))
                  ? 'Job'
                  : 'Internship';

              // Format the applied date
              final appliedDateString = application['applied_date'] ?? '';
              final appliedDate = DateTime.tryParse(appliedDateString);
              final daysPosted = appliedDate != null
                  ? DateTime.now().difference(appliedDate).inDays
                  : 0;

              return Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: OpportunityCard(
                    id: application['id'],
                    dp: Icon(Icons.business, color: Colors.grey),
                    profile: application['profile'] ?? 'N/A',
                    companyName: application['company_name'] ?? 'N/A',
                    location: application['location'] ?? 'N/A',
                    stipend: application['CTC']?.toString() ?? 'N/A',
                    mode: application['work_environment'] ?? 'Remote',
                    type: type, // Set the type here
                    exp: application['years_experience_required'] ?? 0,
                    daysPosted: daysPosted,
                    isVerified: widget.isVerified,
                    ctc: application['CTC']?.toString() ?? '0',
                    description: application['description'] ??
                        'No description available',
                    education: application['education'],
                    skillsRequired: application['skills_required'],
                    whoCanApply: application['who_can_apply'],
                    isApplied: true,
                    fromExperiencedJobs:
                    appliedExperiencedJobs.contains(application),
                    benefits: application['type'] == 'Internship'
                        ? application['benefits']
                        : null,
                    CandidateStatus: application['candidate_status'],
                    whocanApply: application['who_can_apply'],
                    aboutCompany: application["about_company"],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
