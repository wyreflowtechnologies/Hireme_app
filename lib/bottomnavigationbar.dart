//
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:hiremi_version_two/Custom_Widget/Custom_alert_box.dart';
// import 'package:hiremi_version_two/Custom_Widget/drawer_child.dart';
// import 'package:hiremi_version_two/HomePage.dart';
// import 'package:hiremi_version_two/Notofication_screen.dart';
// import 'package:hiremi_version_two/Profile_Screen.dart';
// import 'package:hiremi_version_two/Utils/AppSizes.dart';
// import 'package:hiremi_version_two/Utils/colors.dart';
// import 'package:hiremi_version_two/applies_screen.dart';
// import 'package:hiremi_version_two/queries_screen.dart';
//
// import 'dart:math';
//
//
//
// class NewNavbar extends StatefulWidget {
//   final int initTabIndex;
//   final bool isV;
//   const NewNavbar({Key? key, required this.isV, this.initTabIndex = 0}) : super(key: key);
//
//   @override
//   State<NewNavbar> createState() => _NewNavbarState();
// }
//
// class _NewNavbarState extends State<NewNavbar> {
//   late int _currentIndex;
//   int _selectedIndex = 0;
//   late PageController _pageController = PageController();
//   final List<int> _navigationHistory = [];
//   late List<Widget> _pages;
//   String _storedNumber = '';
//
//   @override
//   void initState() {
//     super.initState();
//
//     _selectedIndex = widget.initTabIndex;  // Initialize the selected index with the initial tab index
//
//     _pages = [
//       HomePage(isVerified: widget.isV),
//       AppliesScreen(isVerified: widget.isV),
//       QueriesScreen(isVerified: widget.isV),
//       ProfileScreen(),
//     ];
//
//     _pageController = PageController(initialPage: widget.initTabIndex);  // Initialize PageController with the initial tab index
//
//     _pageController.addListener(() {
//       int nextPage = _pageController.page!.round();
//       if (nextPage == 2 && !widget.isV) {
//         _pageController.jumpToPage(_selectedIndex);
//         _showVerificationDialog();
//       }
//     });
//   }
//
//   // void _onItemTapped(int index) {
//   //   setState(() {
//   //     if (_selectedIndex != index) {
//   //       _navigationHistory.add(_selectedIndex); // Add the previous index to history
//   //     }
//   //     _selectedIndex = index;
//   //   });
//   //
//   //   if (!widget.isV && (index == 2 || index == 3)) {  // Check if widget.isV is false and the index is Queries or Profile page
//   //     _showVerificationDialog();
//   //   } else {
//   //     _pageController.jumpToPage(index);
//   //   }
//   // }
//   void _onItemTapped(int index) {
//     // Check if the user is trying to navigate to Queries or Profile page when not verified
//     if (!widget.isV && (index == 2 || index == 3)) {
//       _showVerificationDialog();
//       return;
//     }
//
//     // If verified or navigating to unrestricted pages, update the state and navigate
//     setState(() {
//       if (_selectedIndex != index) {
//         _navigationHistory.add(_selectedIndex); // Add the previous index to history
//       }
//       _selectedIndex = index;
//     });
//
//     _pageController.jumpToPage(index);
//   }
//
//
//   void _showVerificationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Stack(
//           children: [
//             // Background blur
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//               child: Container(
//                 color: Colors.black.withOpacity(0.3), // Dim the background
//               ),
//             ),
//             // Alert box content
//             Center(
//               child: AlertDialog(
//                 contentPadding: EdgeInsets.zero,
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 content: const CustomAlertbox(),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   // Future<bool> _onWillPop() async {
//   //   if (_pageController.page?.toInt() == 0) {
//   //     if (Navigator.canPop(context)) {
//   //       Navigator.of(context).pop(); // Handle nested navigation
//   //       return false; // Prevent default behavior
//   //     }
//   //   }
//   //
//   //   if (_navigationHistory.isNotEmpty) {
//   //     setState(() {
//   //       _selectedIndex = _navigationHistory.removeLast();
//   //     });
//   //     _pageController.jumpToPage(_selectedIndex);
//   //     return false; // Prevent default back behavior
//   //   }
//   //   return true; // Allow default back behavior if no navigation history
//   // }
//   Future<bool> _onWillPop() async {
//     // Define the back navigation flow
//     final Map<int, int> backNavigationMap = {
//       1: 0, // From AppliesScreen to HomePage
//       2: 1, // From QueriesScreen to AppliesScreen
//       3: 2, // From ProfileScreen to QueriesScreen
//     };
//
//     if (backNavigationMap.containsKey(_selectedIndex)) {
//       setState(() {
//         _selectedIndex = backNavigationMap[_selectedIndex]!;
//       });
//       _pageController.jumpToPage(_selectedIndex);
//       return false;
//     }
//
//     // Default behavior for HomePage or if the back navigation is not defined
//     return _selectedIndex == 0;
//   }
//   final List<String> _titles = [
//     "Hiremi's Home",
//     'Applies',
//     'Queries',
//     'Profile'
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop:_onWillPop ,
//       child: Scaffold(
//
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title:  Text(
//             _titles[_selectedIndex],
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (ctx) => const NotificationScreen(),
//                 ));
//               },
//               icon: const Icon(Icons.notifications),
//             ),
//           ],
//         ),
//         drawer:  Drawer(
//           backgroundColor: Colors.white,
//           child: DrawerChild(isVerified:widget.isV,),
//         ),
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//
//         body: PageView(
//           controller: _pageController,
//           physics: const NeverScrollableScrollPhysics(),
//           children: _pages,
//           onPageChanged: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//           },
//         ),
//         bottomNavigationBar: Container(
//           height: MediaQuery.of(context).size.height * 0.08,
//           decoration: BoxDecoration(
//               color: AppColors.primary,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//                 bottomLeft: Radius.circular(32),
//                 bottomRight: Radius.circular(32),
//               ),
//               boxShadow: const [
//                 BoxShadow(
//                     color: Colors.black38, blurRadius: 10, offset: Offset(4, 4))
//               ]),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10.0),
//                 topRight: Radius.circular(10.0),
//                 bottomRight: Radius.circular(20.0),
//                 bottomLeft: Radius.circular(20.0),
//
//               ),
//               child: BottomAppBar(
//                 color: Colors.white,
//                 shape: const CircularNotchedRectangle(),
//                 elevation: 4,
//                 notchMargin: 15,
//                 child: Padding(
//                   padding: EdgeInsets.all(Sizes.responsiveXxs(context)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       _buildNavItem(Icons.home_filled, 'HOME', 0),
//                       _buildNavItem(Icons.list_alt_rounded, 'APPLIES', 1),
//                       SizedBox(width: Sizes.responsiveXxl(context)),
//                       _buildNavItem(Icons.local_activity_outlined, 'QUERIES', 2),
//                       _buildNavItem(Icons.person_outline, 'PROFILE', 3),
//
//                     ],
//                   ),
//                 ),
//               ),
//
//               // child:Scaffold(
//               //   bottomNavigationBar: Stack(
//               //     children: [
//               //       BottomAppBar(
//               //         color: Colors.white, // Make the BottomAppBar transparent
//               //         shape: const CircularNotchedRectangle(),
//               //         notchMargin: 8,
//               //         elevation: 4,
//               //         child: SizedBox(height: 70), // Provide space for the content inside the Container
//               //       ),
//               //       SafeArea(
//               //         child: Container(
//               //           padding: EdgeInsets.all(16),
//               //           margin: EdgeInsets.symmetric(horizontal: 12),
//               //           decoration: BoxDecoration(
//               //             color: Colors.white,
//               //             borderRadius: BorderRadius.all(
//               //               Radius.circular(30)
//               //
//               //             )
//               //           ),
//               //           child: Row(
//               //             mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //                   crossAxisAlignment: CrossAxisAlignment.start,
//               //             children: [
//               //               _buildNavItem(Icons.home_filled, 'HOME', 0),
//               //                       _buildNavItem(Icons.list_alt_rounded, 'APPLIES', 1),
//               //                       SizedBox(width: Sizes.responsiveXxl(context)),
//               //                       _buildNavItem(Icons.local_activity_outlined, 'QUERIES', 2),
//               //                       _buildNavItem(Icons.person_outline, 'PROFILE', 3),
//               //             ],
//               //           ),
//               //         ),
//               //       ),
//               //
//               //     ],
//               //   ),
//               // )
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Transform.scale(
//           scale: pi * 0.4,
//           child: FloatingActionButton(
//             onPressed: () {
//               if (!widget.isV) {
//
//                 _showVerificationDialog();
//               }
//             },
//             elevation: 4,
//             backgroundColor: Colors.white,
//             shape: const CircleBorder(),
//             child: const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.all_inclusive,
//                     color: Color(0xFFC1272D),
//                     size: 20,
//                   ),
//                   Text(
//                     'HIREMI',
//                     style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '360',
//                     style: TextStyle(fontSize: 6, color: Color(0xFFC1272D)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem(IconData icon, String label, int index) {
//     return GestureDetector(
//       onTap: () => _onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 20,
//             color: _selectedIndex == index
//                 ? const Color(0xFFC1272D)
//                 : Colors.black,
//           ),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 8,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/Custom_alert_box.dart';
import 'package:hiremi_version_two/Custom_Widget/drawer_child.dart';
import 'package:hiremi_version_two/HomePage.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/Profile_Screen.dart';
import 'package:hiremi_version_two/Utils/AppSizes.dart';
import 'package:hiremi_version_two/Utils/colors.dart';
import 'package:hiremi_version_two/applies_screen.dart';
import 'package:hiremi_version_two/queries_screen.dart';
import 'dart:math';

class NewNavbar extends StatefulWidget {
  final int initTabIndex;
  final bool isV;
  const NewNavbar({Key? key, required this.isV, this.initTabIndex = 0}) : super(key: key);

  @override
  State<NewNavbar> createState() => _NewNavbarState();
}

class _NewNavbarState extends State<NewNavbar> {
  late int _currentIndex;
  int _selectedIndex = 0;
  late PageController _pageController = PageController();
  final List<int> _navigationHistory = [];
  late List<Widget> _pages;
  String _storedNumber = '';

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initTabIndex;  // Initialize the selected index with the initial tab index

    _pages = [
      HomePage(isVerified: widget.isV),
      AppliesScreen(isVerified: widget.isV),
      QueriesScreen(isVerified: widget.isV),
      ProfileScreen(),
    ];

    _pageController = PageController(initialPage: widget.initTabIndex);  // Initialize PageController with the initial tab index

    _pageController.addListener(() {
      int nextPage = _pageController.page!.round();
      if (nextPage == 2 && !widget.isV) {
        _pageController.jumpToPage(_selectedIndex);
        _showVerificationDialog();
      }
    });
  }

  void _onItemTapped(int index) {
    // Check if the user is trying to navigate to Queries or Profile page when not verified
    if (!widget.isV && (index == 2 || index == 3)) {
      _showVerificationDialog();
      return;
    }

    // If verified or navigating to unrestricted pages, update the state and navigate
    setState(() {
      if (_selectedIndex != index) {
        _navigationHistory.add(_selectedIndex); // Add the previous index to history
      }
      _selectedIndex = index;
    });

    _pageController.jumpToPage(index);
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Background blur
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3), // Dim the background
              ),
            ),
            // Alert box content
            Center(
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                content: const CustomAlertbox(),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    // Define the back navigation flow
    final Map<int, int> backNavigationMap = {
      1: 0, // From AppliesScreen to HomePage
      2: 1, // From QueriesScreen to AppliesScreen
      3: 2, // From ProfileScreen to QueriesScreen
    };

    if (backNavigationMap.containsKey(_selectedIndex)) {
      setState(() {
        _selectedIndex = backNavigationMap[_selectedIndex]!;
      });
      _pageController.jumpToPage(_selectedIndex);
      return false;
    }

    // Default behavior for HomePage or if the back navigation is not defined
    return _selectedIndex == 0;
  }

  final List<String> _titles = [
    "Hiremi's Home",
    'Applied',
    'Queries',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            _titles[_selectedIndex],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const NotificationScreen(),
                ));
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: DrawerChild(isVerified: widget.isV),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38, blurRadius: 10, offset: Offset(4, 4))
            ],
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              child: BottomAppBar(
                color: Colors.white,
                shape: const CircularNotchedRectangle(),
                elevation: 4,
                notchMargin: 15,
                child: Padding(
                  padding: EdgeInsets.all(Sizes.responsiveXxs(context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNavItem(Icons.home_filled, 'HOME', 0),
                      _buildNavItem(Icons.list_alt_rounded, 'APPLIED', 1),
                      SizedBox(width: Sizes.responsiveXxl(context)),
                      _buildNavItem(Icons.local_activity_outlined, 'QUERIES', 2),
                      _buildNavItem(Icons.person_outline, 'PROFILE', 3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Transform.scale(
          scale: pi * 0.4,
          child: FloatingActionButton(
            onPressed: () {
              if (!widget.isV) {
                _showVerificationDialog();
              }
            },
            elevation: 4,
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.all_inclusive,
                    color: Color(0xFFC1272D),
                    size: 20,
                  ),
                  Text(
                    'HIREMI',
                    style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '360',
                    style: TextStyle(fontSize: 6, color: Color(0xFFC1272D)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: _selectedIndex == index
                ? const Color(0xFFC1272D)
                : Colors.black,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
