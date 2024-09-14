


import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import 'package:flutter/services.dart';
import 'package:hiremi_version_two/Custom_Widget/Custom_alert_box.dart';
// For BackdropFilter
import 'package:hiremi_version_two/Custom_Widget/OppurtunityCard.dart';
import 'package:hiremi_version_two/Custom_Widget/Verifiedtrue.dart';

//import 'package:hiremi_version_two/Custom_Widget/drawer_child.dart';
import 'package:hiremi_version_two/Custom_Widget/verification_status.dart';
import 'package:hiremi_version_two/InternshipScreen.dart';
//import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/Provider/HomePageOppurtunity.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/bottomnavigationbar.dart';

import 'package:hiremi_version_two/experienced_jobs.dart';
import 'package:hiremi_version_two/fresherJobs.dart';
//import 'package:hiremi_version_two/queries_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Apis/api.dart';


class HomePage extends StatefulWidget {
  final bool isVerified;

  const HomePage({Key? key, required this.isVerified}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  String _storedNumber = '0';
  String internshipUrl = '${ApiUrls.baseurl}/api/internship-applications/';
  String fresherJobUrl = '${ApiUrls.baseurl}/api/job-applications/';
  String experiencedJobUrl = '${ApiUrls.baseurl}/api/experience-job-applications/';
  Set<int> appliedJobIds = Set<int>(); // This should be updated based on actual application data
  Set<int>  appliedInternshipIds = Set<int>();
  Set<int> appliedExperienceJobIds= Set<int>();
 // Map<int, Set<String>> _appliedJobStatus = {};
  //Map<int, Set<String>> _appliedJobTypeIds={};

 //final CarouselController _controller = CarouselController();
  final CarouselController _controller = CarouselController();
  //int _selectedIndex = 0;
  double _blurAmount = 10.0;
  //int _currentPage = 0;
  final PageController _pageController = PageController();
  List<dynamic> _jobs = [];
  bool _isLoading = true;
  String FullName = "";
  String storedEmail = '';
  String UID="";

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _retrieveAndFetchJobs();
    _fetchStoredNumber();

    fetchAndSaveFullName();
  }


  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    setState(() {
      _blurAmount = (10 - (offset / 10)).clamp(0, 10);
    });
  }
  Future<void> _fetchStoredNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedNumber = prefs.getString('stored_number');
    setState(() {
      _storedNumber = storedNumber ?? '0';
    });

    print("stored number isss $_storedNumber");
  }
  Future<void> _retrieveAndFetchJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      final homePageOppurtunity = Provider.of<HomePageOppurtunity>(context, listen: false);
      await homePageOppurtunity.fetchAppliedJobs(savedId);
      await homePageOppurtunity.fetchJobs(); // Fetch jobs after fetching applied jobs
    } else {
      print("No id found in SharedPreferences");
    }
  }





  Future<void> fetchAndSaveFullName() async {
    const String apiUrl = "${ApiUrls.baseurl}/api/registers/";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        storedEmail = prefs.getString('email') ?? 'No email saved';

        for (var user in data) {
          if (user['email'] == storedEmail) {
            setState(() {
              FullName = user['full_name'] ?? 'No name saved';
              UID=user['unique'];

            });
            await SharedPreferencesHelper.setFullName(FullName);
            await SharedPreferencesHelper.setUid(UID);
            await prefs.setString('full_name', FullName);
            print('Full name saved: $FullName');
            break;
          }
        }

        if (FullName.isEmpty) {
          print('No matching email found');
        }
      } else {
        print('Failed to fetch full name');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: const CustomAlertbox(),
        );
      },
    );
  }



  final List<String> bannerImages = [
    'images/icons/Hiremi Banner.png',
    'images/icons/Hiremi Banner2.png',
    'images/icons/Hiremi Banner3.png',
    'images/icons/Hiremi Banner4.png',
    'images/icons/Hiremi Banner5.png',

  ];
  final List<String> verifiedBannerImages = [
    'images/icons/Hiremi Verified Banner.png',
    'images/icons/Hiremi Verified Banner2.png',
    'images/icons/Hiremi Verified Banner3.png',
    'images/icons/Hiremi Verified Banner4.png',
    'images/icons/Hiremi Verified Banner5.png'
  ];
  //Map<int, bool> _appliedJobStatus = {};

  @override
  Widget build(BuildContext context) {
    print("Building");
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async{
       SystemNavigator.pop();
        return false; // Returning false to indicate the back action is handled
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   title: const Text(
        //     "Hiremi's Home",
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(
        //           builder: (ctx) => const NotificationScreen(),
        //         ));
        //       },
        //       icon: const Icon(Icons.notifications),
        //     ),
        //   ],
        // ),
        // drawer:  Drawer(
        //   backgroundColor: Colors.white,
        //   child: DrawerChild(isVerified: widget.isVerified,),
        // ),
        body:SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (!widget.isVerified) VerificationStatus(percent: double.tryParse(_storedNumber)! / 100 ?? 0.0),
                if (widget.isVerified) VerifiedProfileWidget(name:  FullName.split(' ').first, ),
                SizedBox(height: screenHeight * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Explore hiremi',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    InkWell(
                      onTap: (){
                        if (!widget.isVerified) {
                          //  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => VerificationScreen()));
                          _showVerificationDialog();
                        }
                        else{
                          if ((widget.isVerified ? verifiedBannerImages : bannerImages)[_current] == 'images/icons/Hiremi Verified Banner2.png') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => InternshipsScreen(isVerified: widget.isVerified),
                              ),
                            );
                          }
                          if ((widget.isVerified ? verifiedBannerImages : bannerImages)[_current] == 'images/icons/Hiremi Verified Banner3.png') {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (ctx) => QueriesScreen(isVerified: widget.isVerified),
                            //   ),
                            // );
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const NewNavbar(
                                  initTabIndex: 2,
                                  isV: true,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.98,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: screenHeight*0.139,
                                viewportFraction: 1.25,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: (widget.isVerified ? verifiedBannerImages : bannerImages).map((image) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return SizedBox(
                                       width: MediaQuery.of(context).size.width *0.9, // Adjust the width as needed
                                        height: MediaQuery.of(context).size.height * 0.5, // Adjust the height as needed
                                        child: Image.asset(image));
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [1, 2, 3, 4, 5].asMap().entries.map((entry) {
                              return GestureDetector(
                                // onTap: () => _controller.animateToPage(entry.key),
                                onTap: () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                        ? Colors.white
                                        : AppColors.primary)
                                        .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),


                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  "Hiremi's Featured",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF6E01), Color(0xFFFEBC0D)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => InternshipsScreen(isVerified: widget.isVerified)));
                          },
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.spa,
                                size: screenWidth * 0.02,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            Text(
                              'Internships',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.025,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.007),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFC3E41), Color(0xFFFF6E01)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FresherJobs(isVerified: widget.isVerified)));
                        },
                        child: Row(
                          children: [
                            Container(
                              width: screenWidth * 0.05,
                              height: screenWidth * 0.05,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.business_center,
                                size: screenWidth * 0.02,
                                color: Colors.redAccent,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            Text(
                              'Fresher Jobs',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.025,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.007),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFCB44BD), Color(0xFFDB6AA0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  ExperiencedJobs(isVerified: widget.isVerified)));
                        },
                        child: Row(
                          children: [
                            Container(
                                width: screenWidth * 0.045,
                                height: screenWidth * 0.05,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Image.asset(
                                    "images/interactive_space.png"
                                )
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Text(
                              'Experienced Jobs',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.023,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  'Latest Opportunities',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: screenHeight * 0.01),
                Column(
                  children: _jobs.map<Widget>((job) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: OpportunityCard(
                        id: job['id'],
                        dp: const Icon(Icons.business, color: Colors.grey),  // Placeholder image
                        profile: job['profile'],
                        companyName: job['company_name'] ?? 'N/A',
                        location: job['location'] ?? 'N/A',
                        stipend: job['CTC']?.toString() ?? 'N/A',
                        mode: job['work_environment'],
                        type: job['type'] ?? 'Job',
                        exp: job['years_experience_required'] ?? 0,
                        daysPosted: DateTime.now().difference(DateTime.parse(job['upload_date'])).inDays,
                        isVerified: widget.isVerified,
                        ctc: job['CTC']?.toString() ?? '0',
                        description: job['description'] ?? 'No description available',
                        education: job['education'],
                        skillsRequired: job['skills_required'],
                        whoCanApply: job['who_can_apply'],
                        isApplied: job['isApplied'] ?? false, // Updated field
                        fromExperiencedJobs: job['fromExperienced'] ?? false,
                        benefits: job['benefits'],
                        CandidateStatus: "Actively Recruiting",
                        whocanApply: job['who_can_apply'],
                        aboutCompany: job["about_company"],
                      ),
                    );
                  }).toList(),
                ),
                Consumer<HomePageOppurtunity>(
                  builder: (context, homePageOppurtunity, child) {
                    if (homePageOppurtunity.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homePageOppurtunity.jobs.length,
                        itemBuilder: (context, index) {
                          final job = homePageOppurtunity.jobs[index];
                          return Padding(
                            padding:  EdgeInsets.only(bottom: screenHeight * 0.03),
                            child: OpportunityCard(
                              id: job['id'],
                              dp: const Icon(Icons.business, color: Colors.grey),  // Placeholder image
                              profile: job['profile'],
                              companyName: job['company_name'] ?? 'N/A',
                              location: job['location'] ?? 'N/A',
                              stipend: job['CTC']?.toString() ?? 'N/A',
                              mode: job['work_environment'],
                              type: job['type'] ?? 'Job',
                              exp: job['years_experience_required'] ?? 0,
                              daysPosted: DateTime.now().difference(DateTime.parse(job['upload_date'])).inDays,
                              isVerified: widget.isVerified,
                              ctc: job['CTC']?.toString() ?? '0',
                              description: job['description'] ?? 'No description available',
                              education: job['education'],
                              skillsRequired: job['skills_required'],
                              whoCanApply: job['who_can_apply'],
                              isApplied: job['isApplied'] ?? false,
                              fromExperiencedJobs: job['fromExperienced'] ?? false,
                              benefits: job['benifits'],
                              CandidateStatus: "Actively Recruiting",
                              whocanApply: job['who_can_apply'],
                              aboutCompany: job["about_company"],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height:  screenHeight * 0.03),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on CarouselController {
  animateToPage(int key) {

  }
}
