
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hiremi_version_two/PaymentFailedPage.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:hiremi_version_two/verified_page.dart';
import 'package:paytm_routersdk/paytm_routersdk.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/api.dart';

class VerificationScreen3 extends StatefulWidget {
  const VerificationScreen3({Key? key}) : super(key: key);

  @override
  State<VerificationScreen3> createState() => _VerificationScreen3State();
}

class _VerificationScreen3State extends State<VerificationScreen3>   {
  final _formKey = GlobalKey<FormState>();
  String _fullName="";
  double amount=10;
  String Email="";
  int? SavedId;
  bool _isLoading = false; // Loading state variable
  Map<String, dynamic>  taxDetailsforfailedpage={};
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final TextEditingController _IntrestedDomainController = TextEditingController();
  final TextEditingController _EnrollementNumberController = TextEditingController();

  @override

  void dispose() {
    _IntrestedDomainController.dispose();
    _EnrollementNumberController.dispose();
    super.dispose();
  }
@override
bool get wantKeepAlive => true;
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndStoreDiscountedPrice();
    _retrieveId();

    if (_fullName.isEmpty) {
      _fetchFullName();
    }
    if (Email.isEmpty) {
      _printSavedEmail();
    }
  }

  bool _isAllFieldsValid() {
    return _formKey.currentState?.validate() ?? false;
  }
  String responseText = "";
  String callbackResponseText = "";
  String transactionResponseText="";

  Future<void> fetchAndStoreDiscountedPrice() async {
    const String apiUrl = '${ApiUrls.baseurl}/api/discount/';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty && data[0]['discounted_price'] != null) {
          double discountedPrice = (data[0]['discounted_price'] as num).toDouble();

          // Store discounted price in SharedPreferences using helper class
          await SharedPreferencesHelper.setDiscountedPrice(discountedPrice);

          print("Discounted price stored: $discountedPrice");
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

  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');

    if (savedId != null) {
      setState(() {
        SavedId = savedId;
      });
      print("Retrieved id is in Verification $savedId");

      // Fetch the user details from the API
      final userEmail = await _fetchUserEmail(savedId);
      if (userEmail != null) {
        print("Email of user with ID $savedId is: $userEmail");
        Email=userEmail;
        print(Email);
        // You can now use this email as needed in your app
      } else {
        print("User with ID $savedId not found.");
      }
    } else {
      print("No id found in SharedPreferences");
    }
  }

  Future<String?> _fetchUserEmail(int savedId) async {
    final url = '${ApiUrls.baseurl}/api/registers/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> users = jsonDecode(response.body);

        // Find the user with the savedId
        final user = users.firstWhere((user) => user['id'] == savedId, orElse: () => null);

        if (user != null) {
          return user['email']; // Return the email if user is found
        }
      } else {
        print('Failed to load user data');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }

    return null; // Return null if user not found or error occurred
  }

  Future<void> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? 'No email saved';
    print(email);
    Email=email;
  }
  Future<void> _checkEmail() async {
    const String apiUrl = "${ApiUrls.baseurl}/api/registers/";

    try {
      final response = await http.get(Uri.parse('$apiUrl?email=$Email'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var user in data) {
          if (user['email'] == Email) {
            await updateUserVerificationStatus(user['id']);
            break;
          }
        }

        if (data.isEmpty) {
          print('No user found for email: $Email');
        }
      } else {
        print('Failed to fetch user data');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> updateUserVerificationStatus(int userId) async {
    final String updateUrl = "${ApiUrls.baseurl}/api/registers/$userId/";

    try {
      final response = await http.patch(
        Uri.parse(updateUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'verified': true,
        }),
      );

      if (response.statusCode == 200) {

        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (ctx) => const VerifiedPage()));

        final data = jsonDecode(response.body);
        print('User verification updated successfully: $data');

        if (data['verified'] == true) {
          //_showVerificationNotification();
        }
      }
      else {
        print('Failed to update user verification');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> _fetchFullName() async {
    final prefs = await SharedPreferences.getInstance();
    String? fullName = prefs.getString('full_name') ?? 'No name saved';
    setState(() {
      _fullName = fullName;
    });
  }
  Future<Map?> _initiateTransaction(String txnToken, String orderId, String amount, String mid, String callbackUrl, bool isStaging) async {
    print("We are in _initiateTransaction");
    try {
      // Initiate the transaction using Paytm Router SDK
      var transactionResponse = await PaytmRouterSdk.startTransaction(mid, orderId, amount, txnToken, callbackUrl, isStaging);

      // Handle the transaction response

      if (transactionResponse != null && transactionResponse['STATUS'] == 'TXN_SUCCESS') {

        print("Success in _initiateTransaction");
        print("transaction Succesfully");
        await _postVerificationDetails();
          print(transactionResponse);
          // setState(() {
          //   transactionResponseText=transactionResponse.toString();
          // });


          checkOrderStatus(orderId);


          return transactionResponse;
      }
      else {
        print("taxDetailsforfailedpage is  $taxDetailsforfailedpage");
        print("_navigateToPaymentFailedPage");
     _navigateToPaymentFailedPage();

        checkOrderStatus(orderId);
        // setState(() {
        //   transactionResponseText=transactionResponse.toString();
        // });
        print("$transactionResponseText in error");
        throw Exception('Transaction failed bhai: ${transactionResponse!['RESPMSG']}');
      }

    } catch (e) {

      throw Exception('Error initiating transaction: $e');
    }
  }

  void _navigateToPaymentFailedPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => PaymentFailedPage(
          // onTryAgain: _makeTransactionRequestforFailedPayment,
          //  onTryAgain: _makeTransactionRequestforFailedPayment,
          //
          // taxDetailsforfailedpage: taxDetailsforfailedpage,
        ),
      ),
    );
  }
  final String orderStatusUrl = '${ApiUrls.baseurl}/order-status/';
  void goToNextPage() {
    _checkEmail();
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (ctx) => const VerifiedPage()));

  }
  // Future<void> _postVerificationDetails() async {
  //
  // print("WE are in _postVerificationDetails");
  //
  //   try {
  //     final url = '${ApiUrls.baseurl}/api/verification-details/';
  //     final params = {
  //       "payment_status":"Enrolled",
  //       'college_id_number': _EnrollementNumberController.text,
  //       'interested_domain': _IntrestedDomainController.text,
  //       'register':SavedId
  //     };
  //
  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: json.encode(params),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //
  //     if (response.statusCode == 201)
  //     {
  //
  //     //    goToNextPage();  // Call this function only if the widget is still mounted
  //       //_checkEmail();
  //       if (mounted) {
  //         print("Navigating to next page..."); // Debug before navigation
  //         goToNextPage(); // Call this function only if the widget is still mounted
  //       } else {
  //         print("Widget is unmounted; skipping navigation.");
  //       }
  //
  //
  //       print('Verification details posted successfully');
  //       print(response.body);
  //
  //     }
  //     else {
  //       print('Failed to post verification details. Status code: ${response.statusCode}');
  //       print(response.body);
  //     }
  //   } catch (e) {
  //
  //     print('Error posting verification details: $e');
  //   }
  // }
  Future<void> _postVerificationDetails() async {
    print("WE are in _postVerificationDetails");

    try {
      final url = '${ApiUrls.baseurl}/api/verification-details/';
      final params = {
        "payment_status": "Enrolled",
        'college_id_number': _EnrollementNumberController.text,
        'interested_domain': _IntrestedDomainController.text,
        'register': SavedId
      };

      final response = await http.post(
        Uri.parse(url),
        body: json.encode(params),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        print('Verification details posted successfully');
        print(response.body);
        goToNextPage();
        // Adding a small delay to ensure no premature navigation
        Future.delayed(Duration(milliseconds: 300), () {
          if (mounted) {
            print("Navigating to next page...");
           // Call this function only if the widget is still mounted
          } else {
            print("Widget is unmounted,skipping navigation.");
          }
        });
      } else {
        print('Failed to post verification details. Status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error posting verification details: $e');
    }
  }

  Future<void> checkOrderStatus(String orderId) async {
    print("We are in checkOrderStatus");
    try {
      final response = await http.post(
        Uri.parse('$orderStatusUrl'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "order_id": orderId,
          "amount": amount,
        }),
      );

      if (response.statusCode == 200) {


        print("Success");
        print("Order is complete");
        print(response.statusCode);
        print(response.body);


        // Parse the response body to a JSON object
        var responseBody = jsonDecode(response.body);

        // Check if the status is "Success"
        if (responseBody['status'] == 'Success') {

        }
        else {
//_navigateToPaymentFailedPage();

          print("Order is not complete");
          print("Status code in else ${response.statusCode}");
          print(response.body);
        }

      }


    }
    catch (e) {
      print("Error in checkOrderStatus: $e");
    }
  }



  Future<void> _makeTransactionRequest(double amount) async {
    print("we are in makeTransactionRequest");

    setState(() {
      _isLoading = true; // Start loading
    });



    try {
      print("Helllo");
      // Ensure email is loaded



      // API endpoint
      var url = '${ApiUrls.baseurl}/pay/';

      // Generate a unique order ID
      var orderId = DateTime.now().millisecondsSinceEpoch.toString();

      // Parameters
      var params = {
        'name': _fullName,
        'amount': amount.toString(),
        'orderId': orderId,
        'email': Email
      };

      var response = await http.post(
        Uri.parse(url),
        body: json.encode(params),
        headers: {'Content-Type': 'application/json'},
      );

      // Checking response status
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print('Response data: $responseData'); // Print response data for debugging

        // Check if all required fields are present in the response
        if (responseData.containsKey('txnToken') && responseData.containsKey('orderId') && responseData.containsKey('amount')) {
          var txnToken = responseData['txnToken'];
          var orderId = responseData['orderId'];
          var amount = responseData['amount'];
          var mid = '216820000000000077910';
          var callbackUrll = '${ApiUrls.baseurl}/callback/';
          var isStaging = false; // Set to true for staging environment

          // Use router SDK to initiate transaction
          var transactionResponse = await _initiateTransaction(txnToken, orderId, amount, mid, callbackUrll, isStaging);

          // Check if transactionResponse is not null and contains 'TXNID'
          if (transactionResponse != null && transactionResponse.containsKey('TXNID')) {
            print("Helloin if section");
            var txnDetails = {
              'BANKTXNID': transactionResponse['BANKTXNID'],
              'CHECKSUMHASH': transactionResponse['CHECKSUMHASH'],
              'CURRENCY': transactionResponse['CURRENCY'],
              'GATEWAYNAME': transactionResponse['GATEWAYNAME'],
              'MID': transactionResponse['MID'],
              'ORDERID': transactionResponse['ORDERID'],
              'PAYMENTMODE': transactionResponse['PAYMENTMODE'],
              'RESPCODE': transactionResponse['RESPCODE'],
              'RESPMSG': transactionResponse['RESPMSG'],
              'STATUS': transactionResponse['STATUS'],
              'TXNAMOUNT': transactionResponse['TXNAMOUNT'],
              'TXNDATE': transactionResponse['TXNDATE'],
              'TXNID': transactionResponse['TXNID']
            };

            // setState(() {
            //   responseText = txnDetails.toString();
            // });
            print("txnDetails is $txnDetails");
            taxDetailsforfailedpage=txnDetails;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const VerifiedPage()));

            print('Transaction successful! Transaction ID: ${transactionResponse['TXNID']}');

            // Post transaction response to callback URL
            await _postTransactionResponse(callbackUrll, txnDetails);
          } else {
              print("It is empty");
           print('Error: Transaction failed or missing transaction ID in response');
          }
        } else {
         print('Error: Missing required data in response');
        }
      } else {
        // Request failed
        print(response.statusCode);
        print(response.body);
       print( 'Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred
      print( 'Error: $e');
    }
    finally{
      setState(() {
        _isLoading = false; // Start loading
      });
    }
  }
  // void resetTransactionState() {
  //   setState(() {
  //     // _transactionID = null;  // Reset transaction ID so it generates a new one for retry
  //     // _transactionStatus = null; // Reset the transaction status
  //     // _isLoading = false;  // Reset any loading flags
  //   });
  // }
  Future<void> _makeTransactionRequestforFailedPayment(double amount) async {
    print("we are in _makeTransactionRequestforFailedPayment");
    // setState(() {
    //   _isLoading = true; // Start loading
    // });

    try {
      print("Helllo");
      // Ensure email is loaded



      // API endpoint
      var url = '${ApiUrls.baseurl}/pay/';

      // Generate a unique order ID
      var orderId = DateTime.now().millisecondsSinceEpoch.toString();

      // Parameters
      var params = {
        'name': _fullName,
        'amount': amount.toString(),
        'orderId': orderId,
        'email': Email
      };

      var response = await http.post(
        Uri.parse(url),
        body: json.encode(params),
        headers: {'Content-Type': 'application/json'},
      );


      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print('Response data: $responseData'); // Print response data for debugging

        // Check if all required fields are present in the response
        if (responseData.containsKey('txnToken') && responseData.containsKey('orderId') && responseData.containsKey('amount')) {
          var txnToken = responseData['txnToken'];
          var orderId = responseData['orderId'];
          var amount = responseData['amount'];
          var mid = '216820000000000077910';
          var callbackUrll = 'http://13.127.246.196:8000/callback/';
          var isStaging = false; // Set to true for staging environment

          // Use router SDK to initiate transaction
          var transactionResponse = await _initiateTransaction(txnToken, orderId, amount, mid, callbackUrll, isStaging);

          // Check if transactionResponse is not null and contains 'TXNID'
          if (transactionResponse != null && transactionResponse.containsKey('TXNID')) {

            var txnDetails = {
              'BANKTXNID': transactionResponse['BANKTXNID'],
              'CHECKSUMHASH': transactionResponse['CHECKSUMHASH'],
              'CURRENCY': transactionResponse['CURRENCY'],
              'GATEWAYNAME': transactionResponse['GATEWAYNAME'],
              'MID': transactionResponse['MID'],
              'ORDERID': transactionResponse['ORDERID'],
              'PAYMENTMODE': transactionResponse['PAYMENTMODE'],
              'RESPCODE': transactionResponse['RESPCODE'],
              'RESPMSG': transactionResponse['RESPMSG'],
              'STATUS': transactionResponse['STATUS'],
              'TXNAMOUNT': transactionResponse['TXNAMOUNT'],
              'TXNDATE': transactionResponse['TXNDATE'],
              'TXNID': transactionResponse['TXNID']
            };


           //  taxDetailsforfailedpage=txnDetails;
            print('Transaction successful! Transaction ID: ${transactionResponse['TXNID']}');

            // Post transaction response to callback URL
            await _postTransactionResponse(callbackUrll, txnDetails);

          } else {
            print("It is empty");

            print('Error: Transaction failed or missing transaction ID in response');
          }
        } else {
          print('Error: Missing required data in response');
        }
      }


      else {
        // Request failed
        print(response.statusCode);
        print(response.body);
        print( 'Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred
      print( 'Error: $e');
    }
    finally{
      // setState(() {
      //   _isLoading = false; // Start loading
      // });
    }
  }




  Future<void> _postTransactionResponse(String callbackUrll, Map<String, dynamic> response) async {


    print("we are in _postTransactionResponse");
    try {
      // setState(() {
      //   responseText = json.encode(response);
      // });
      // Making POST request to callback URL with transaction response data
      var callbackResponse = await http.post(
        Uri.parse(callbackUrll),
        body: json.encode(response),
        headers: {'Content-Type': 'application/json'},
      );

      // Checking response status
      if (callbackResponse.statusCode == 200) {

        print('Transaction response posted successfully');
        print(callbackResponse.statusCode);
        print("Callback response is ${callbackResponse.body}");
        // console.log(callbackResponse.body);
        print("response is $response");
        var callbackResponseBody = json.decode(callbackResponse.body);

        if (callbackResponseBody['verifySignature'] == true) {
           print("Hello");
        //  _postVerificationDetails();
        }
        // Redirect to CallbackScreen

      }

      else {
        print("callback in else ${callbackResponse.statusCode}");
        print(callbackResponse.body);
        print("response is $response");
        // setState(() {
        //   callbackResponseText = "Failed to post transaction response. Status code: ${callbackResponse.statusCode} ${callbackResponse.body}";
        // });
        print('Failed to post transaction response. Status code: ${callbackResponse.statusCode} ${callbackResponse.body}');
      }
    }
    catch (e) {
      // Error occurred while posting transaction response
      print('Error posting transaction response:$e');
    }
  }
  String? _selectedDomain;

  final List<String> _domains = [
    'Backend Development',
    'Business Analytics',
    'Finance Management',
    'Flutter UI Development',
    'Frontend Development',
    'Human Resource Management',
    'International Business',
    'Java Development',
    'Marketing Management',
    'MERN Development',
    'Operations Management',
    'Software Development',
    'Supply Chain Management',
    'Website Development',
  ];
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Review & Verify Your Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircularPercentIndicator(
                    radius: screenHeight * 0.05,
                    lineWidth: 6,
                    percent: 0.75,
                    center: const Text(
                      '75%',
                      style: TextStyle(
                          color: Color(0xFF34AD78), fontWeight: FontWeight.bold),
                    ),
                    progressColor: Color(0xFF34AD78),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  SizedBox(height: screenHeight * 0.0075),
                  Text(
                    _fullName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.0075),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.1),
                      border: Border.all(color: const Color(0xFFC1272D)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.01),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: const Color(0xFFC1272D),
                            size: screenWidth * 0.02,
                          ),
                          Text(
                            ' Not verified',
                            style: TextStyle(
                              color: const Color(0xFFC1272D),
                              fontSize: screenWidth * 0.02,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0425),
            Container(
              height: 1,
              width: screenWidth * 0.9,
              color: Colors.grey,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: screenHeight * 0.02),
                    // Padding(
                    //   padding: EdgeInsets.all(screenWidth * 0.04),
                    //   child: const Text(
                    //     'Contact Information',
                    //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    //     textAlign: TextAlign.start,
                    //   ),
                    // ),
                    SizedBox(height: screenHeight * 0.013),
                    buildLabeledTextField(
                      context,
                      "Enrollment Number / Roll Number / College ID / UAN Number etc.",
                      "Ex->0105IT171125",
                      controller: _EnrollementNumberController,
                      validator: (value) {
                        final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');

                        if (value == null || value.isEmpty) {
                          return 'Please enter your enrollment number';
                        } else if (!alphanumericRegex.hasMatch(value)) {
                          return 'Only letters and numbers are allowed';
                        }
                        return null;
                      },
                    ),

                    buildLabeledTextField(
                      context,
                      "Interest Domain*",
                      "Select Domain",
                     dropdownItems: _domains,
                      controller: _IntrestedDomainController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your Domain';
                        }
                        final specialCharPattern = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

                        // Check if the value contains special characters
                        if (specialCharPattern.hasMatch(value)) {
                          return 'Special characters are not allowed in Domain';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDomain = newValue;
                          _IntrestedDomainController.text = newValue ?? '';
                        });
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Row(
                      children: [
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFC1272D),
                          ),
                          // child: TextButton(
                          //
                          //   onPressed: () {
                          //     if (_isAllFieldsValid()) {
                          //       _makeTransactionRequest(amount);
                          //     }
                          //   },
                          //   child: _isLoading
                          //       ? CircularProgressIndicator() // Show loading indicator
                          //       : Text('Review & Next',style: TextStyle(
                          //     fontSize: screenHeight*0.015,
                          //     color: Colors.white
                          //   ),),
                          // ),
                          child: TextButton(
                            onPressed: _isLoading
                                ? null  // Disable button when loading
                                : () async {
                              if (kDebugMode) {
                                print('Running in release mode');
                              }
                              else {
                                print('Running in debug or profile mode');
                              }
                              if (_isAllFieldsValid()) {
                                await SharedPreferencesHelper.setEnrollmentNumber(_EnrollementNumberController.text);
                                await SharedPreferencesHelper.setInterestedDomain(_IntrestedDomainController.text);
                                double? Amount = await SharedPreferencesHelper.getDiscountedPrice();
                               _makeTransactionRequest(Amount!);

                              }
                            },
                            child: _isLoading
                                ? CircularProgressIndicator() // Show loading indicator
                                : Text(
                              'Review & Next',
                              style: TextStyle(
                                fontSize: screenHeight * 0.015,
                                color: Colors.white,
                              ),
                            ),
                            // style: ButtonStyle(
                            //   backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            //         (Set<MaterialState> states) {
                            //       if (states.contains(MaterialState.disabled)) {
                            //         return Colors.grey; // Color when disabled
                            //       }
                            //       return Colors.blue; // Default color
                            //     },
                            //   ),
                            // ),
                          ),

                        ),
                        // ElevatedButton(onPressed: () async {
                        //   await _postVerificationDetails();
                        // }, child: Text("dcdc"),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,  // Let the column shrink-wrap its children
              children: [
                Text("Response:"),
                Flexible(  // Use Flexible instead of Expanded to allow child to take only necessary space
                  child: SingleChildScrollView(
                    child: Text(
                      // Display your response here
                      responseText,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),  // For spacing
                Text("transactionResponseText Response:"),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      // Display your callback response here
                      transactionResponseText,
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }


  Widget buildLabeledTextField(
      BuildContext context,
      String label,
      String hintText, {
        bool showPositionedBox = false,
        IconData? prefixIcon,
        bool obscureText = false,
        List<String>? dropdownItems,
        TextEditingController? controller,
        String? Function(String?)? validator,
        VoidCallback? onTap,
        TextInputType? keyboardType,
        ValueChanged<String?>? onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(color: Colors.black),
                ),
                const TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: dropdownItems != null
              ? DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            value: controller?.text.isNotEmpty == true ? controller?.text : null,
            hint: Text(hintText),
            onChanged: onChanged,
            items: dropdownItems.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            validator: validator,
            isExpanded: true,
          )
              : TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: obscureText,
            validator: validator,
            onTap: onTap,
            keyboardType: keyboardType,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
      ],
    );
  }


}
