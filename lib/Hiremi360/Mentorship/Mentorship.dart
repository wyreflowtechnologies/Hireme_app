import 'dart:convert';

import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/Controller/MentorshipController.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/Model/MentorshipModel.dart';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/FeatureCard.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/ServiceHighlight.dart';
import 'package:hiremi_version_two/Hiremi360/PaytmPayment/PaytmPayment.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Mentorship extends StatefulWidget {
  const Mentorship({Key? key}) : super(key: key);

  @override
  State<Mentorship> createState() => _MentorshipState();
}

class _MentorshipState extends State<Mentorship> {
  String buttonText="";
  bool isEnrolled=false;

  Future<void> _enrollInMentorship(String SavedId) async {
    var mentorshipData = MentorshipModel(
      program_status: "Applied",
      candidateStatus: "Applied",
      applied: true,
      register: SavedId,
    );

    try {
      await mentorshipController.EnrollInMentorship(mentorshipData);
      _checkEnrollmentStatus();
    } catch (e) {
      print("Enrollment failed: $e"); // Handle errors if the enrollment fails
    }
  }
  Future<void> fetchAndStoreDiscountedPrice() async {
    const String apiUrl = '${ApiUrls.baseurl}/api/mentorshipdiscount/';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty && data[0]['discounted_price'] != null) {
          var discountedPriceValue = data[0]['discounted_price'];
          double discountedPrice;

          if (discountedPriceValue is int) {
            discountedPrice = discountedPriceValue.toDouble();
          } else if (discountedPriceValue is double) {
            discountedPrice = discountedPriceValue;
          } else {
            print("Unexpected type for discounted_price: ${discountedPriceValue.runtimeType}");
            return;
          }

          OriginalPrice = data[0]['original_price'].toString();
          DiscountedPrice = discountedPrice.toString();
          Discount = data[0]['discount'].toString();

          // Store discounted price in SharedPreferences using helper class
          await SharedPreferencesHelper.setMentorshipDiscountedPrice(discountedPrice);

          print("Discounted price stored: $discountedPrice");

          // Update the UI
          setState(() {});
        } else {
          print("Discounted price not found in the response.");
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching discounted price: $e");
    }
  }

  Future<void> _checkEnrollmentStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');

    if (savedId != null) {
      setState(() {
        SavedId = savedId.toString();
      });
      print("Retrieved id is in Verification $savedId");

      // Fetch the user details from the API
      final response = await http.get(Uri.parse('${ApiUrls.baseurl}/api/mentorship/'));

      if (response.statusCode == 200) {
        final List<dynamic> mentorshipData = jsonDecode(response.body);
          print("sdhjjdjsdjkds${response.statusCode}");
        print("${response.body}");

        // Check if any register matches the savedId
        for (var mentorship in mentorshipData) {
          if (mentorship['register'] == savedId) {
            setState(() {
              buttonText = "Enrolled-${mentorship['unique']}";
              isEnrolled = true; // Indicate that the user is already enrolled
            });
            break; // No need to check further once a match is found
          }
        }
      }

      else {
        print("Failed to load mentorship data from API");
      }

    }
    else {
      print("No savedId id found in SharedPreferences");
    }
  }


  bool isButtonDisabled = false;
  final MentorshipController mentorshipController = MentorshipController();
late PaymentService paymentService;
 String Email="";
 String SavedId="";
 String OriginalPrice="";
 String DiscountedPrice="";
 String Discount="";
Future<void> _printSavedEmail() async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email') ?? 'No email saved';
  print(email);
  Email=email;
}
  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');

    if (savedId != null) {

      setState(() {
        SavedId = savedId.toString();
      });
      print("Retrieved id is in Verification $savedId");
      _checkEnrollmentStatus();

      // Fetch the user details from the API

    } else {
      print("No id found in SharedPreferences");
    }
  }


@override
  void initState() {
    // TODO: implement initState
  paymentService = PaymentService(context);
    super.initState();
  fetchAndStoreDiscountedPrice();
  _retrieveId();
    _printSavedEmail();

  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.redAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
          "Mentorship",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,  // Text color is needed, but will be replaced by the gradient
            ),
          ),
        ),

        centerTitle: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("  Why Choose Hiremi Mentorship\n  Program?",
               // textAlign: TextAlign.center,
                style: TextStyle(
                fontSize:screenWidth*0.058,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height:screenWidth*0.02 ,),

                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Hiremi 360° Mentorship Program",
                          style: TextStyle(
                            fontSize: screenWidth * 0.0315,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [
                                  Colors.blueAccent,
                                  Colors.redAccent,
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.bottomLeft,
                              ).createShader(Rect.fromLTWH(0.0, 0.0, screenWidth, 0.0)),
                          ),
                        ),
                        TextSpan(
                          text:
                          " is designed to guide you through your entire college journey. Our expert mentors will help you stay updated on market trends, make informed academic decisions, and provide career advice.",
                          style: TextStyle(
                            fontSize: screenWidth * 0.0315,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height:screenWidth*0.02,),
                // Padding(
                //   padding:  EdgeInsets.all(screenWidth*0.03),
                //   child: Text("we offer a guaranteed internship in your preferred domain, ensuring you gain practical experience to kickstart your career. With Hiremi, you’ll have the support you need to succeed both academically and professionally.",
                //    // textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontSize:screenWidth*0.0315,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.03),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "we offer a ",
                          style: TextStyle(
                            fontSize: screenWidth * 0.0315,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                          TextSpan(
                            text: "guaranteed internship ",
                            style: TextStyle(
                              fontSize: screenWidth * 0.0315,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = LinearGradient(
                                  colors: [
                                    Colors.blueAccent,
                                    Colors.redAccent,

                                  ],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.bottomLeft,
                                ).createShader(Rect.fromLTWH(0.0, 0.0, screenWidth, 0.0)),
                            ),
                          ),
                          TextSpan(
                            text:
                            "in your preferred domain, ensuring you gain practical experience to kickstart your career. With Hiremi, you’ll have the support you need to succeed both academically and professionally.",
                            style: TextStyle(
                              fontSize: screenWidth * 0.0315,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: screenWidth*0.012),
                  child: Image.asset(
                    "images/Group 33784 (1).png",
                    width: screenWidth*0.92,
                    height: screenWidth*0.47,
                  ),
                ),
                FeatureCard (
                  title: "College Students",
                  description: "Our mentorship program assists students in\nnavigating their academic journey, making informed\ncareer choices, and preparing for the professional\nworld.",
                  gradientColors: [
                    Color(0xFFF249DC), // #F249DC // You can pass custom gradient colors
                    Color(0xFF1B1D9C),
                  ],
                  outerContainerColor:  const Color.fromARGB(255, 245, 235, 255),
                ),

                SizedBox(height:screenWidth*0.08 ,),
                Container(
                  color:const Color.fromARGB(255, 245, 235, 255),
                  width: MediaQuery.of(context).size.width,
                  // height:MediaQuery.of(context).size.width ,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.017),

                      Text(
                        "One Time Program Pricing",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.065,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Mentorship",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.037,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),

                      Container(
                        height: screenWidth * 0.3255,
                        width: screenWidth * 0.97,
                        margin: EdgeInsets.all(screenWidth * 0.04),
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFF249DC), // #F249DC
                              Color(0xFF1B1D9C),
                            ],
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenWidth * 0.035),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: screenWidth * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    "Standard Package",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.1),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFFF249DC), // #F249DC
                                          Color(0xFF1B1D9C),

                                        ],
                                      ),
                                    ),
                                    padding: EdgeInsets.all(4.0), // Optional padding around CircleAvatar
                                    child: CircleAvatar(
                                      radius: screenWidth * 0.02, // Adjust the radius as needed
                                      backgroundColor: Colors.white, // Background color inside the gradient
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenWidth * 0.029),




                              Row(
                                children: [
                                  Text(
                                    DiscountedPrice,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.043,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.012),

                                  Text(
                                    OriginalPrice,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.032,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.07),

                                  Container(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xFF95152F),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                      child: ShaderMask(
                                        shaderCallback: (bounds) => LinearGradient(
                                          colors: [
                                            Color(0xFFF249DC), // #F249DC
                                            Color(0xFF1B1D9C), // #1B1D9C
                                          ], // Start and end colors of the gradient
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                                        child: Text(
                                          "$Discount% off",
                                          style: const TextStyle(
                                            color: Color.fromRGBO(193, 39, 45, 1),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenWidth * 0.023),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Note:Entire academic year + one extra year.Dive deep into essential skills and knowledge for success with our mentorship program.',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.028, // Responsive font size for content
                                color: Colors.grey[700],
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:screenWidth*0.06 ,),

                Text("Why Choose Hiremi Mentorship?",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.054,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:screenWidth*0.0083 ,),

                Text("The Advantages of Hiremi 360's program",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.034,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height:screenWidth*0.0383 ,),


                Servicehighlight(),
                Padding(
              padding:  EdgeInsets.only(left: screenWidth*0.058),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Unlock Your Potential with ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.black, // Default color
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: 'Hiremi',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.red, // Red color for 'Hiremi'
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(
                      text: ' & ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        color: Colors.black, // Default color for '&'
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    WidgetSpan(
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: <Color>[Colors.redAccent, Colors.blueAccent],
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Hiremi 360',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            color: Colors.white, // This will be masked by the gradient
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
                SizedBox(height:screenWidth*0.0383 ,),
                Padding(
                  padding:  EdgeInsets.only(left: screenWidth*0.045),
                  child: Text("Experience the perfect blend of Mentorship and\npersonalized guidance to help you succeed in your\ncareer journey.",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                SizedBox(height:screenWidth*0.0383 ,),
                Image.asset("images/Group 33822.png"),
                SizedBox(height:screenWidth*0.0999 ,),


                SizedBox(height:screenWidth*0.0383 ,),


              ],
            ),

          ),

          Positioned(
            bottom: 16,
            left: screenWidth * 0.075,
            right: screenWidth * 0.075,
            child: SizedBox(
              width: screenWidth * 0.95,
              height: screenWidth * 0.099,
              child: ElevatedButton(
                onPressed: isButtonDisabled || isEnrolled ? null : () async {
                  setState(() {
                    isButtonDisabled = true; // Disable the button
                  });

                  try {
                    // Fetch full name from SharedPreferencesl


                    String? _fullName = await SharedPreferencesHelper.getFullName();
                    double? Amount = await SharedPreferencesHelper.getMentorshipDiscountedPrice();
                    print("Amount is $Amount");
                    if (_fullName != null) {
                      print("Email is $Email");
                      print("Name is $_fullName");
                      print("Amount is $Amount");
                      // Initiate the payment transaction and capture the result
                      bool isSuccess = await paymentService.makeTransactionRequest(_fullName, Email, Amount!);

                      // Display the result of the transaction
                      if (isSuccess) {

                        _enrollInMentorship(SavedId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Transaction successful! in elevated button'),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 4),
                          ),
                        );

                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Transaction failed in elevated button.'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 8),
                          ),
                        );
                      }
                    }
                  }
                  catch (e) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error during transaction: $e'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }

                  finally {

                    setState(() {
                      isButtonDisabled = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF249DC), // Start color
                        Color(0xFF1B1D9C), // End color
                      ],
                      stops: [0.1047, 0.9086],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      isButtonDisabled
                          ? "Processing..."
                          : (isEnrolled
                          ? buttonText
                          : "Enroll Now"), // Nested ternary to handle both conditions
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
