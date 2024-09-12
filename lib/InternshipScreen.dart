
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Provider/InternshipProvider.dart';
import 'package:provider/provider.dart';
import 'package:hiremi_version_two/Custom_Widget/OppurtunityCard.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class InternshipsScreen extends StatefulWidget {
  const InternshipsScreen({Key? key, required this.isVerified}) : super(key: key);
  final bool isVerified;

  @override
  State<InternshipsScreen> createState() => _InternshipsScreenState();
}

class _InternshipsScreenState extends State<InternshipsScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _retrieveIdAndFetchData();
  }

  Future<void> _retrieveIdAndFetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      final internshipProvider = Provider.of<InternshipProvider>(context, listen: false);
      await internshipProvider.setUserId(savedId);
      internshipProvider.fetchJobs();
      internshipProvider.fetchApplications();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Internship Jobs',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const NotificationScreen()));
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      body: Consumer<InternshipProvider>(
        builder: (context, internshipProvider, child) {
          if (internshipProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final jobs = internshipProvider.jobs;
          final applications = internshipProvider.applications;
          final appliedJobs = applications
              .where((application) => application['register'] == internshipProvider.userId)
              .map((application) => application['internship'])
              .toSet();

          if (jobs.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    width: screenWidth * 0.95, // 95% of screen width
                    height: screenHeight * 0.1, // 10% of screen height
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6E01), Color(0xFFFEBC0D)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: screenWidth * 0.04, // 4% of screen width
                        ),
                        Container(
                          width: screenWidth * 0.08, // 8% of screen width
                          height: screenWidth * 0.08, // 8% of screen width
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.spa,
                            size: screenWidth * 0.04, // 4% of screen width
                            color: const Color(0xFFFF3E41),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02, // 2% of screen width
                        ),
                        Text(
                          'Internship Jobs',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045, // 4.5% of screen width
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: screenWidth * 0.28, // 23% of screen width
                          height: screenWidth * 0.28, // 23% of screen width
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.spa,
                            color: Colors.orangeAccent,
                            size: screenWidth * 0.1, // 10% of screen width
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03, // 3% of screen height
                  ),
                  Image.asset('images/Team work-bro.png'),
                  SizedBox(height: screenHeight * 0.01),
                  const Text(
                    'Hiremi’s Recruiters are planning for new jobs',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'please wait for few days',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.95, // 95% of screen width
                      height: screenHeight * 0.1, // 10% of screen height
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6E01), Color(0xFFFEBC0D)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.04, // 4% of screen width
                          ),
                          Container(
                            width: screenWidth * 0.08, // 8% of screen width
                            height: screenWidth * 0.08, // 8% of screen width
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.spa,
                              size: screenWidth * 0.04, // 4% of screen width
                              color: const Color(0xFFFF3E41),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02, // 2% of screen width
                          ),
                          Text(
                            'Internship Jobs',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045, // 4.5% of screen width
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: screenWidth * 0.28, // 23% of screen width
                            height: screenWidth * 0.28, // 23% of screen width
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.spa,
                              color: Colors.orangeAccent,
                              size: screenWidth * 0.1, // 10% of screen width
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03, // 3% of screen height
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Available Internship Jobs',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03, // 3% of screen height
                    ),
                    Column(
                      children: jobs.map<Widget>((job) {
                        bool isApplied = appliedJobs.contains(job['id']);
                        return Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                          child: OpportunityCard(
                            id: job['id'],
                            dp: const Icon(Icons.business, color: Colors.grey),  // Placeholder image
                            profile: job['profile'] ?? 'N/A',
                            companyName: job['company_name'] ?? 'N/A',
                            location: job['location'] ?? 'N/A',
                            stipend: job['Stipend']?.toString() ?? 'N/A',
                            mode: job['work_environment'], // Replace with actual data if available
                            type: 'Internships', // Replace with actual data if available
                            exp: job['years_experience_required'] ?? 0, // Replace with actual data if available
                            daysPosted: DateTime.now().difference(DateTime.parse(job['upload_date'])).inDays,
                            isVerified: widget.isVerified,
                            ctc: job['Stipend']?.toString() ?? '0',
                            description: job['description'] ?? 'No description available',
                            education: job['education'],
                            skillsRequired: job['skills_required'],
                            whoCanApply: job['who_can_apply'],
                            isApplied: isApplied,
                            fromExperiencedJobs: false,
                            benefits: job['benifits'],
                            CandidateStatus: "Actively Recruiting",
                            whocanApply: job['who_can_apply'],
                            aboutCompany:job["about_company"],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
