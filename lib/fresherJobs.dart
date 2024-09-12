// //
// // import 'package:flutter/material.dart';
// // import 'package:hiremi_version_two/API_Integration/Internship/Apiservices.dart';
// // import 'package:hiremi_version_two/Custom_Widget/OppurtunityCard.dart';
// // import 'package:hiremi_version_two/HomePage.dart';
// // import 'package:hiremi_version_two/Notofication_screen.dart';
// // import 'package:hiremi_version_two/bottomnavigationbar.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class FresherJobs extends StatefulWidget {
// //   const FresherJobs({Key? key, required this.isVerified}) : super(key: key);
// //   final bool isVerified;
// //
// //   @override
// //   State<FresherJobs> createState() => _FresherJobsState();
// // }
// //
// // class _FresherJobsState extends State<FresherJobs> {
// //   late Future<List<dynamic>> futureJobs;
// //   late Future<List<dynamic>> futureApplications;
// //   int? userId;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _retrieveId();
// //     futureJobs = _getJobs();
// //     futureApplications = _getApplications();
// //   }
// //
// //   Future<void> _retrieveId() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final int? savedId = prefs.getInt('userId');
// //     if (savedId != null) {
// //       setState(() {
// //         userId = savedId;
// //       });
// //       print("Retrieved id is $savedId");
// //     } else {
// //       print("No id found in SharedPreferences");
// //     }
// //   }
// //
// //   Future<List<dynamic>> _getJobs() async {
// //     final apiService = ApiService('http://13.127.81.177:8000/api/fresherjob/');
// //     return await apiService.fetchData();
// //   }
// //
// //   Future<List<dynamic>> _getApplications() async {
// //     final apiService = ApiService('http://13.127.81.177:8000/api/job-applications/');
// //     return await apiService.fetchData();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final screenHeight = MediaQuery.of(context).size.height;
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Fresher Jobs',
// //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.of(context).pushAndRemoveUntil(
// //               MaterialPageRoute(builder: (context) => NewNavbar( isV: widget.isVerified,)),
// //                   (Route<dynamic> route) => false,
// //             );
// //           },
// //         ),
// //         actions: [
// //           IconButton(
// //             onPressed: () {
// //               Navigator.of(context).push(
// //                 MaterialPageRoute(builder: (ctx) => const NotificationScreen()),
// //               );
// //             },
// //             icon: const Icon(Icons.notifications),
// //           ),
// //         ],
// //       ),
// //       body: FutureBuilder<List<dynamic>>(
// //         future: Future.wait([futureJobs, futureApplications]),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator());
// //           } else if (snapshot.hasError) {
// //             return Center(child: Text('Error: ${snapshot.error}'));
// //           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
// //             return const Center(child: Text('No jobs available'));
// //           } else {
// //             final jobs = snapshot.data![0];
// //             final applications = snapshot.data![1];
// //
// //             // Check which jobs the user has already applied for
// //             final appliedJobs = applications
// //                 .where((application) => application['register'] == userId)
// //                 .map((application) => application['fresherjob'])
// //                 .toSet();
// //
// //             return SingleChildScrollView(
// //               child: Padding(
// //                 padding: EdgeInsets.all(screenWidth * 0.04), // 4% of screen width
// //                 child: Center(
// //                   child: Column(
// //                     children: [
// //                       Container(
// //                         width: screenWidth * 0.95, // 95% of screen width
// //                         height: screenHeight * 0.1, // 10% of screen height
// //                         decoration: BoxDecoration(
// //                           gradient: const LinearGradient(
// //                             colors: [Color(0xFFFC3E41), Color(0xFFFF6E01)],
// //                             begin: Alignment.topLeft,
// //                             end: Alignment.bottomRight,
// //                           ),
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                         child: Row(
// //                           children: [
// //                             SizedBox(
// //                               width: screenWidth * 0.04, // 4% of screen width
// //                             ),
// //                             Container(
// //                               width: screenWidth * 0.08, // 8% of screen width
// //                               height: screenWidth * 0.08, // 8% of screen width
// //                               decoration: const BoxDecoration(
// //                                 shape: BoxShape.circle,
// //                                 color: Colors.white,
// //                               ),
// //                               child: Icon(
// //                                 Icons.business_center,
// //                                 size: screenWidth * 0.04, // 4% of screen width
// //                                 color: const Color(0xFFFF3E41),
// //                               ),
// //                             ),
// //                             SizedBox(
// //                               width: screenWidth * 0.02, // 2% of screen width
// //                             ),
// //                             Text(
// //                               'Fresher Jobs',
// //                               style: TextStyle(
// //                                 fontSize: screenWidth * 0.045, // 4.5% of screen width
// //                                 color: Colors.white,
// //                               ),
// //                             ),
// //                             const Spacer(),
// //                             Container(
// //                               width: screenWidth * 0.23, // 23% of screen width
// //                               height: screenWidth * 0.27, // 23% of screen width
// //                               decoration: BoxDecoration(
// //                                 color: Colors.redAccent[100],
// //                                 shape: BoxShape.circle,
// //                               ),
// //                               child: Icon(
// //                                 Icons.business_center,
// //                                 color: const Color(0xFFFF3E41),
// //                                 size: screenWidth * 0.115, // 10% of screen width
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         height: screenHeight * 0.03, // 3% of screen height
// //                       ),
// //                       const Align(
// //                         alignment: Alignment.centerLeft,
// //                         child: Text(
// //                           'Available Fresher Jobs',
// //                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                           textAlign: TextAlign.left,
// //                         ),
// //                       ),
// //                       SizedBox(
// //                         height: screenHeight * 0.03, // 3% of screen height
// //                       ),
// //                       Column(
// //                         children: jobs.map<Widget>((job) {
// //                           bool isApplied = appliedJobs.contains(job['id']);
// //                           return Padding(
// //                             padding: EdgeInsets.only(bottom: screenHeight * 0.03),
// //                             child: OpportunityCard(
// //                               id: job['id'],
// //                               dp: Image.asset('images/icons/logo1.png'), // Placeholder image
// //                               profile: job['profile'] ?? 'N/A',
// //                               companyName: job['company_name'] ?? 'N/A',
// //                               location: job['location'] ?? 'N/A',
// //                               stipend: job['CTC']?.toString() ?? 'N/A',
// //                               mode: job['work_environment'], // Replace with actual data if available
// //                               type: 'Job', // Replace with actual data if available
// //                               exp: job['years_experience_required'] ?? 0, // Replace with actual data if available
// //                               daysPosted:DateTime.now().difference(DateTime.parse(job['upload_date'])).inDays, // Replace with actual data if available
// //                               isVerified: widget.isVerified,
// //                               ctc: job['CTC']?.toString() ?? '0', // Example, replace with actual field
// //                               description: job['description'] ?? 'No description available',
// //                               education: job['education'],
// //                               skillsRequired: job['skills_required'],
// //                               whoCanApply: job['who_can_apply'],
// //                               isApplied: isApplied, // Indicate if already applied
// //                               fromExperiencedJobs: false,
// //                               benefits: job['type'] == 'Internship' ? job['benefits'] : null,
// //                               CandidateStatus: "Actively Recruiting",
// //                             ),
// //                           );
// //                         }).toList(),
// //                       ),
// //                       SizedBox(
// //                         height: screenHeight * 0.35, // 35% of screen height
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Provider/fresherJobProvider.dart';
//
// import 'package:provider/provider.dart';
// import 'package:hiremi_version_two/Custom_Widget/OppurtunityCard.dart';
// import 'package:hiremi_version_two/Notofication_screen.dart';
// import 'package:hiremi_version_two/bottomnavigationbar.dart';
//
// class FresherJobs extends StatefulWidget {
//   const FresherJobs({Key? key, required this.isVerified}) : super(key: key);
//   final bool isVerified;
//
//   @override
//   State<FresherJobs> createState() => _FresherJobsState();
// }
//
// class _FresherJobsState extends State<FresherJobs> {
//   @override
//   void initState() {
//     super.initState();
//       final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
//       jobsProvider.retrieveId();
//       jobsProvider.fetchJobs();
//       jobsProvider.fetchApplications();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("HEllo");
//     final jobsProvider = Provider.of<JobsProvider>(context);
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Fresher Jobs',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => NewNavbar(isV: widget.isVerified)),
//                   (Route<dynamic> route) => false,
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (ctx) => const NotificationScreen()),
//               );
//             },
//             icon: const Icon(Icons.notifications),
//           ),
//         ],
//       ),
//       body: jobsProvider.jobs.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(screenWidth * 0.04),
//           child: Column(
//             children: [
//               Container(
//                 width: screenWidth * 0.95,
//                 height: screenHeight * 0.1,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFFFC3E41), Color(0xFFFF6E01)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(width: screenWidth * 0.04),
//                     Container(
//                       width: screenWidth * 0.08,
//                       height: screenWidth * 0.08,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                       child: Icon(
//                         Icons.business_center,
//                         size: screenWidth * 0.04,
//                         color: const Color(0xFFFF3E41),
//                       ),
//                     ),
//                     SizedBox(width: screenWidth * 0.02),
//                     Text(
//                       'Fresher Jobs',
//                       style: TextStyle(
//                         fontSize: screenWidth * 0.045,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       width: screenWidth * 0.23,
//                       height: screenWidth * 0.27,
//                       decoration: BoxDecoration(
//                         color: Colors.redAccent[100],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.business_center,
//                         color: const Color(0xFFFF3E41),
//                         size: screenWidth * 0.115,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Available Fresher Jobs',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               Column(
//                 children: jobsProvider.jobs.map<Widget>((job) {
//                   bool isApplied = jobsProvider.isApplied(job['id']);
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: screenHeight * 0.03),
//                     child: OpportunityCard(
//                       id: job['id'],
//                       dp: Image.asset('images/icons/logo1.png'), // Placeholder image
//                       profile: job['profile'] ?? 'N/A',
//                       companyName: job['company_name'] ?? 'N/A',
//                       location: job['location'] ?? 'N/A',
//                       stipend: job['CTC']?.toString() ?? 'N/A',
//                       mode: job['work_environment'], // Replace with actual data if available
//                       type: 'Job', // Replace with actual data if available
//                       exp: job['years_experience_required'] ?? 0, // Replace with actual data if available
//                       daysPosted: DateTime.now().difference(DateTime.parse(job['upload_date'])).inDays,
//                       isVerified: widget.isVerified,
//                       ctc: job['CTC']?.toString() ?? '0', // Example, replace with actual field
//                       description: job['description'] ?? 'No description available',
//                       education: job['education'],
//                       skillsRequired: job['skills_required'],
//                       whoCanApply: job['who_can_apply'],
//                       isApplied: isApplied, // Indicate if already applied
//                       fromExperiencedJobs: false,
//                       benefits: job['type'] == 'Internship' ? job['benefits'] : null,
//                       CandidateStatus: "Actively Recruiting",
//                       whocanApply: job['who_can_apply'],
//                       aboutCompany:job["about_company"],
//                     ),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: screenHeight * 0.35),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Provider/fresherJobProvider.dart';
import 'package:provider/provider.dart';
import 'package:hiremi_version_two/Custom_Widget/OppurtunityCard.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';

class FresherJobs extends StatefulWidget {
  const FresherJobs({Key? key, required this.isVerified}) : super(key: key);
  final bool isVerified;

  @override
  State<FresherJobs> createState() => _FresherJobsState();
}

class _FresherJobsState extends State<FresherJobs> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final jobsProvider = Provider.of<JobsProvider>(context, listen: false);
    jobsProvider.retrieveId();
    jobsProvider.fetchJobs().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    jobsProvider.fetchApplications();
  }

  @override
  Widget build(BuildContext context) {
    final jobsProvider = Provider.of<JobsProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fresher Jobs',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => NewNavbar(isV: widget.isVerified),
              ),
                  (Route<dynamic> route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const NotificationScreen()),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : jobsProvider.jobs.isEmpty
          ? Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(left:  screenWidth * 0.028),
                child: Container(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFC3E41), Color(0xFFFF6E01)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: screenWidth * 0.04),
                      Container(
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.business_center,
                          size: screenWidth * 0.04,
                          color: const Color(0xFFFF3E41),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Fresher Jobs',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: screenWidth * 0.23,
                        height: screenWidth * 0.27,
                        decoration: BoxDecoration(
                          color: Colors.redAccent[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.business_center,
                          color: const Color(0xFFFF3E41),
                          size: screenWidth * 0.115,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              SizedBox(height: screenHeight * 0.03),

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
          )
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.95,
                height: screenHeight * 0.1,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFC3E41), Color(0xFFFF6E01)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    SizedBox(width: screenWidth * 0.04),
                    Container(
                      width: screenWidth * 0.08,
                      height: screenWidth * 0.08,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.business_center,
                        size: screenWidth * 0.04,
                        color: const Color(0xFFFF3E41),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      'Fresher Jobs',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: screenWidth * 0.23,
                      height: screenWidth * 0.27,
                      decoration: BoxDecoration(
                        color: Colors.redAccent[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.business_center,
                        color: const Color(0xFFFF3E41),
                        size: screenWidth * 0.115,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Available Fresher Jobs',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Column(
                children: jobsProvider.jobs.map<Widget>((job) {
                  bool isApplied = jobsProvider.isApplied(job['id']);
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                    child: OpportunityCard(
                      id: job['id'],
                      dp: Icon(Icons.business, color: Colors.grey),  // Placeholder image
                      profile: job['profile'] ?? 'N/A',
                      companyName: job['company_name'] ?? 'N/A',
                      location: job['location'] ?? 'N/A',
                      stipend: job['CTC']?.toString() ?? 'N/A',
                      mode: job['work_environment'],
                      type: 'Job',
                      exp: job['years_experience_required'] ?? 0,
                      daysPosted: DateTime.now().difference(DateTime.parse(job['upload_date'])).inDays,
                      isVerified: widget.isVerified,
                      ctc: job['CTC']?.toString() ?? '0',
                      description: job['description'] ?? 'No description available',
                      education: job['education'],
                      skillsRequired: job['skills_required'],
                      whoCanApply: job['who_can_apply'],
                      isApplied: isApplied,
                      fromExperiencedJobs: false,
                      benefits: job['type'] == 'Internship' ? job['benefits'] : null,
                      CandidateStatus: "Actively Recruiting",
                      whocanApply: job['who_can_apply'],
                      aboutCompany: job["about_company"],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: screenHeight * 0.35),
            ],
          ),
        ),
      ),
    );
  }
}
