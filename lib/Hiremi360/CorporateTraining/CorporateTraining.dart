import 'dart:convert';
import 'package:hiremi_version_two/Hiremi360/PaytmPayment/PaytmPayment.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/Hiremi360/Mentorship/FeatureCard.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CorporateTraining extends StatefulWidget {
  const CorporateTraining({Key? key}) : super(key: key);

  @override
  State<CorporateTraining> createState() => _CorporateTrainingState();
}

class _CorporateTrainingState extends State<CorporateTraining> {
  @override
  String Email="";
  String SavedId="";
  String OriginalPrice="";
  String DiscountedPrice="";
  String Discount="";
  String buttonText="";
  bool isEnrolled=false;
  bool isButtonDisabled = false;
  late PaymentService paymentService;

  Future<void> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? 'No email saved';
    print(email);
    Email=email;
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
      final response = await http.get(Uri.parse('${ApiUrls.baseurl}/api/corporatediscount/'));

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
  Future<void> fetchAndStoreDiscountedPrice() async {
    const String apiUrl = '${ApiUrls.baseurl}/api/corporatediscount/';

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
          await SharedPreferencesHelper.setCorporateDiscountedPrice(discountedPrice);

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
            "Corporate Training",
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
                Text("Why Choose Hiremi Corporate\n Training?",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:screenWidth*0.053,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                Padding(
                  padding:  EdgeInsets.only(left:screenWidth* 0.045),
                  child: Text("At Hiremi, our Corporate Training program is designed to foster comprehensive learning, embrace diversity, and promote career excellence.",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:screenWidth*0.0315,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                Padding(
                  padding:  EdgeInsets.only(left:screenWidth* 0.045),
                  child: Text("We provide hands-on expertise, practical exercises, and a structured curriculum, equipping individuals with the skills needed to tackle real-world challenges efficiently.",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:screenWidth*0.0315,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                const FeatureCard (
                    title: "College Students",
                    description: "Our Training + Internship assists students in\nnavigating their academic journey, making informed\ncareer choices, and preparing for the professional\nworld.",
                    gradientColors: [
                      Colors.blueAccent,
                      Colors.white,
                    ],
                  outerContainerColor: Color.fromARGB(255, 229, 246, 255),
                ),
                SizedBox(height:screenWidth*0.08 ,),
                Container(
                  color:const Color.fromARGB(255, 229, 246, 255),
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
                        "Corporate Training",
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
                              Colors.blueAccent,
                              Colors.white,
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
                                          Colors.blueAccent,
                                          Colors.white,

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
                                    "25000",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.043,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.012),

                                  Text(
                                    "50,000",
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
                                          color: Colors.lightBlueAccent,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                      child: ShaderMask(
                                        shaderCallback: (bounds) => LinearGradient(
                                          colors: [
                                            Colors.blueAccent,
                                            Colors.white,
                                          ], // Start and end colors of the gradient
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                                        child: Text(
                                          "40% off",
                                          style: const TextStyle(
                                            color: Colors.lightBlueAccent,
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
                          'Note:Entire academic year + one extra year.Dive deep into essential skills and knowledge for success with our corporate training program.',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.028, // Responsive font size for content
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.017),

                    ],
                  ),
                ),
                SizedBox(height:screenWidth*0.09 ,),
                // Text(
                //   "Essential Skills for Success",
                //   style: TextStyle(
                //     fontSize: MediaQuery.of(context).size.width*0.06,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   "The advantages of Hiremi 360's Corporate Training Program",
                //   style: TextStyle(
                //     fontSize: MediaQuery.of(context).size.width*0.03,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Container(
                  color:const Color.fromARGB(255, 229, 246, 255),
                  width: MediaQuery.of(context).size.width,
                  // height:MediaQuery.of(context).size.width ,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.017),

                      Text(
                        "Enhance Your Employability",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.065,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "How Corporate Training Program helps you",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width*0.037,
                          //   fontWeight: FontWeight.bold,
                        ),
                      ),

                      Container(
                        height: screenWidth * 0.3855,
                        width: screenWidth * 0.97,
                        margin: EdgeInsets.all(screenWidth * 0.04),
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blueAccent,
                              Colors.white,
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
                              Text(
                                "Enrollment in the Program",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.029),
                              Text(
                                "KickStart your journey to employability by enroling in\nour corporate Training program.This is your first step\ntowards continous learning and embarking on a\ntransfromative career path.",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.0262,

                                ),
                              ),
                              SizedBox(height: screenWidth * 0.023),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: screenWidth * 0.3855,
                        width: screenWidth * 0.97,
                        margin: EdgeInsets.all(screenWidth * 0.04),
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blueAccent,
                              Colors.white,
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
                              Text(
                                "Document Processing",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.029),
                              Text(
                                "Begin with a simple and efficient onboarding process\nSubmit your necessary documents, and once verified,\nyou 're officially enrolled in our Corporate Training Program.",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.0262,

                                ),
                              ),
                              SizedBox(height: screenWidth * 0.023),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: screenWidth * 0.3855,
                        width: screenWidth * 0.97,
                        margin: EdgeInsets.all(screenWidth * 0.04),
                        padding: EdgeInsets.all(screenWidth * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.04),
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blueAccent,
                              Colors.white,
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
                              Text(
                                "Enrollment in the Program",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                              SizedBox(height: screenWidth * 0.029),
                              Text(
                                "KickStart your journey to employability by enroling in\nour corporate Training program.This is your first step\ntowards continous learning and embarking on a\ntransfromative career path.",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.0262,

                                ),
                              ),
                              SizedBox(height: screenWidth * 0.023),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Note:Entire academic year + one extra year.Dive deep into essential skills and knowledge for success with our corporate training program.',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.028, // Responsive font size for content
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.017),

                    ],
                  ),
                ),

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
                      // Initiate the payment transaction and capture the result
                      bool isSuccess = await paymentService.makeTransactionRequest(_fullName, Email, Amount!);

                      // Display the result of the transaction
                      if (isSuccess) {

                        // _enrollInCorporateTraining(SavedId);
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
