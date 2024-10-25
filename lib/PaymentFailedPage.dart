
import 'dart:convert';
import 'package:hiremi_version_two/PaytmPaymentForVerified.dart';
import 'package:hiremi_version_two/verified_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentFailedPage extends StatefulWidget {
//  final Function(double) onTryAgain;
  //final Map<String, dynamic> taxDetailsforfailedpage;

  const PaymentFailedPage({
    Key? key,
    //  required this.onTryAgain,
    //required this.taxDetailsforfailedpage,
  }) : super(key: key);

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  bool _isLoading = false;
  String SavedId="";
  String Email="";
  late PaymentServiceforVerified  paymentService;
  @override
  void initState() {
    // TODO: implement initState
    paymentService = PaymentServiceforVerified(context);

    _printSavedEmail();
    super.initState();

  }
  Future<void> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? 'No email saved';
    print(email);
    Email=email;
  }
  // Future<void> _retrieveId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final int? savedId = prefs.getInt('userId');
  //
  //   if (savedId != null) {
  //     setState(() {
  //       SavedId = savedId as String;
  //     });
  //     print("Retrieved id is in PaymentFailed $savedId");
  //
  //     // Fetch the user details from the API
  //
  //   }
  //
  // }

  // Future<void> _retrieveId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final int? savedId = prefs.getInt('userId');
  //   if (savedId != null) {
  //     print("Retrieved id is $savedId");
  //     SavedId = savedId.toString();
  //     print(SavedId);
  //   } else {
  //     print("No id found in SharedPreferences");
  //   }
  //
  // }

  // Future<void> _postVerificationDetails() async {
  //   _retrieveId();
  //   print("We are in _postVerificationDetails");
  //
  //   try {
  //     // Retrieve the enrollment number and interested domain from SharedPreferences
  //     String? enrollmentNumber = await SharedPreferencesHelper.getEnrollmentNumber();
  //     String? interestedDomain = await SharedPreferencesHelper.getInterestedDomain();
  //
  //     // Ensure values are not null
  //     if (enrollmentNumber != null && interestedDomain != null) {
  //       final url = '${ApiUrls.baseurl}/api/verification-details/';
  //       final params = {
  //         "payment_status": "Enrolled",
  //         'college_id_number': enrollmentNumber,
  //         'interested_domain': interestedDomain,
  //         'register': SavedId
  //       };
  //
  //       final response = await http.post(
  //         Uri.parse(url),
  //         body: json.encode(params),
  //         headers: {'Content-Type': 'application/json'},
  //       );
  //
  //       if (response.statusCode == 201) {
  //         print('Verification details posted successfully');
  //         print(response.body);
  //         // Adding a small delay to ensure no premature navigation
  //         Navigator.of(context).push(MaterialPageRoute(
  //             builder: (ctx) => const VerifiedPage()));
  //       } else {
  //         print('Failed to post verification details. Status code: ${response.statusCode}');
  //         print(response.body);
  //       }
  //     } else {
  //       print('Enrollment number or interested domain is null.');
  //     }
  //   } catch (e) {
  //     print('Error posting verification details: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment and Verification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
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
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFC1272D),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                  Text(
                    "Oops! Your Payment couldn't be processed",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.015,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFC1272D),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Image.asset(
              'images/Group 33983.png',
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Text(
              "Oh no!",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.035,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Something went wrong.",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.033,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "We aren't able to process your payment. Please try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFC1272D),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            // Display the transaction details
            //_buildTransactionDetails(),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),


            ElevatedButton(
              onPressed: _isLoading
                  ? null // Disable button when loading
                  : () async {
                setState(() {
                  _isLoading = true; // Set loading state to true
                });

                try {
                  String? _fullName = await SharedPreferencesHelper.getFullName();
                  double? Amount = await SharedPreferencesHelper.getDiscountedPrice();
                  if (_fullName != null) {

                    // Initiate the payment transaction and capture the result
                    bool isSuccess = await paymentService.makeTransactionRequestforVerified(_fullName, Email, Amount!);

                    // Handle success or failure
                    // if (isSuccess) {
                    //   // Perform post-verification actions if needed
                    // }
                  }
                } finally {
                  setState(() {
                    _isLoading = false; // Set loading state to false after operation
                  });
                }
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC1272D)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text(
                "Try Again",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.0165,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}