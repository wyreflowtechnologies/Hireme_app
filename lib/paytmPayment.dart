// import 'dart:convert';
// import 'dart:ui';
//
// import 'package:hiremi_version_two/api_services/base_services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:paytm_routersdk/paytm_routersdk.dart';
//
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';
//
//
// class MyPaytmPayment extends StatefulWidget {
//   final String? sourceScreen;
//   final int paymentAmount;
//   const MyPaytmPayment({Key? key, this.sourceScreen,required this.paymentAmount}) : super(key: key);
//   @override
//   _MyPaytmPaymentState createState() => _MyPaytmPaymentState();
// }
//
// class _MyPaytmPaymentState extends State<MyPaytmPayment> {
//   String loginEmail="";
//   String ID2=" ";
//   String email =" ";
//   String UIDforCorporateTraining="";
//   String UIDforMentorship="";
//   var Phone_Number;
//   String rateUrCommunication="";
//   String collegeId =" ";
//   String yourSkills =" ";
//   String status =" ";
//   String scheduleDate =" ";
//   String scheduleTime =" ";
//   String uid = '';
//   String Name=" ";
//   var uuid = Uuid();
//   // final TextEditingController _amountController = TextEditingController();
//
//
//   late TextEditingController _amountController;
//   late String _orderId;
//   String responseText = '';
//   @override
//   void initState() {
//     super.initState();
//
//     _loadUserEmailandPhoneNumber();
//
//
//     //_showVerificationDialog();
//     // _startPayment();
//     // Generate Order ID when the screen initializes
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 children: [
//
//
//
//                 ],
//               ),
//               // Text(
//               //   '${_amountController.text}', // Access text from the controller
//               //   style: TextStyle(fontSize: 48,fontWeight: FontWeight.bold,),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 18.0),
//                 child: ElevatedButton(
//                   onPressed:(){
//                     _makeTransactionRequest();
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => PaymentScreen(paymentAmount: 1),
//                     //   ),
//                     // );
//
//                   }
//
//                   // paymentScreen._startPayment
//                   // Navigate to payment screen with the discounted price
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => PaymentScreen(paymentAmount: 1),
//                   //   ),
//                   // );
//                   ,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF13640),
//                     minimumSize: Size(250, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   child: RichText(
//                     text: TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "Proceed to Pay",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 20,
//                           ),
//                         ),
//
//                         // TextSpan(
//                         //   text: " ${discountedPrice.toInt().toString()}",
//                         //   style: TextStyle(
//                         //     color: Colors.white,
//                         //     fontWeight: FontWeight.w700,
//                         //     fontSize: 20,
//                         //   ),
//                         // ),
//
//                         // TextSpan(
//                         //   text: "1000",
//                         //   style: TextStyle(
//                         //     color: Colors.white,
//                         //     fontWeight: FontWeight.w700,
//                         //     fontSize: 20,
//                         //     decoration: TextDecoration.lineThrough,
//                         //     decorationColor: Colors.black87,
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//
//               // ElevatedButton(
//               //   onPressed: _startPayment,
//               //   child: Text('Make Payment'),
//               // ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   final String orderStatusUrl = 'http://13.127.81.177:8000/order-status/';
//   Future<void> checkOrderStatus(String orderId) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$orderStatusUrl'),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"order_id": orderId}),
//       );
//
//       if (response.statusCode == 200) {
//         print("Order is complete");
//         print(response.statusCode);
//         print(response.body);
//       } else {
//         print("Order is not complete");
//         print(response.statusCode);
//         print(response.body);
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//   Future<void> _loadUserEmailandPhoneNumber() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? savedUsername = prefs.getString('username');
//
//     if (savedUsername != null && savedUsername.isNotEmpty) {
//       setState(() {
//         loginEmail = savedUsername;
//       });
//       try {
//         final response = await http.get(Uri.parse('http://13.127.81.177:8000/api/registers/?email=$loginEmail'));
//
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//
//           if (data is List && data.isNotEmpty) {
//             // Iterate through the data to find the user with matching email
//             for (final userData in data) {
//               final email = userData['email'];
//               if (email == loginEmail) {
//                 final name=userData['full_name'];
//                 final phoneNumber = userData['phone_number']; // Change 'phone_number' to the actual field name
//                 // Use the retrieved phone number as needed
//                 Name=name;
//                 print('Phone Number is: $phoneNumber');
//
//                 var Phone_Number=phoneNumber;
//                 break; // Exit the loop once the user is found
//               }
//             }
//           } else {
//             print('No user found with the email $loginEmail.');
//           }
//         } else {
//           print('Failed to load user data. Status code: ${response.statusCode}');
//         }
//       } catch (error) {
//         print('Error fetching user data: $error');
//       }
//     }
//   }
//
//
//   Future<void> _makeTransactionRequest() async {
//
//     try {
//       print("Helllo");
//       // Ensure email is loaded
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       email = "yashmanu0761@gmail.com";
//
//       if (email.isEmpty) {
//         print('Error: Email is required');
//         setState(() {
//           responseText = 'Error: Email is required';
//         });
//         return;
//       }
//
//       // API endpoint
//       var url = 'http://13.127.81.177:8000/pay/';
//
//       // Generate a unique order ID
//       var orderId = DateTime.now().millisecondsSinceEpoch.toString();
//
//       // Parameters
//       var params = {
//         'name': Name,
//         'amount': widget.paymentAmount.toString(),
//         'orderId': orderId,
//         'email': email // Add email to the parameters
//       };
//
//       var response = await http.post(
//         Uri.parse(url),
//         body: json.encode(params),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       // Checking response status
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.body);
//         print('Response data: $responseData'); // Print response data for debugging
//
//         // Check if all required fields are present in the response
//         if (responseData.containsKey('txnToken') && responseData.containsKey('orderId') && responseData.containsKey('amount')) {
//           var txnToken = responseData['txnToken'];
//           var orderId = responseData['orderId'];
//           var amount = responseData['amount'];
//           var mid = '216820000000000077910';
//           var callbackUrll = 'http://13.127.81.177:8000/callback/';
//           var isStaging = false; // Set to true for staging environment
//
//           // Use router SDK to initiate transaction
//           var transactionResponse = await _initiateTransaction(txnToken, orderId, amount, mid, callbackUrll, isStaging);
//
//           // Check if transactionResponse is not null and contains 'TXNID'
//           if (transactionResponse != null && transactionResponse.containsKey('TXNID')) {
//             print("Helloin if section");
//             var txnDetails = {
//               'BANKTXNID': transactionResponse['BANKTXNID'],
//               'CHECKSUMHASH': transactionResponse['CHECKSUMHASH'],
//               'CURRENCY': transactionResponse['CURRENCY'],
//               'GATEWAYNAME': transactionResponse['GATEWAYNAME'],
//               'MID': transactionResponse['MID'],
//               'ORDERID': transactionResponse['ORDERID'],
//               'PAYMENTMODE': transactionResponse['PAYMENTMODE'],
//               'RESPCODE': transactionResponse['RESPCODE'],
//               'RESPMSG': transactionResponse['RESPMSG'],
//               'STATUS': transactionResponse['STATUS'],
//               'TXNAMOUNT': transactionResponse['TXNAMOUNT'],
//               'TXNDATE': transactionResponse['TXNDATE'],
//               'TXNID': transactionResponse['TXNID']
//             };
//
//             setState(() {
//               responseText = 'Transaction successful! Transaction ID: ${transactionResponse['TXNID']}';
//             });
//
//             // Post transaction response to callback URL
//             await _postTransactionResponse(callbackUrll, txnDetails);
//           } else {
//             setState(() {
//               responseText = 'Error: Transaction failed or missing transaction ID in response';
//             });
//           }
//         } else {
//           setState(() {
//             responseText = 'Error: Missing required data in response';
//           });
//         }
//       } else {
//         // Request failed
//         print(response.statusCode);
//         print(response.body);
//         setState(() {
//           print("Hello in else section");
//           responseText = 'Request failed with status: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       // Error occurred
//       setState(() {
//         responseText = 'Error: $e';
//         print(e);
//       });
//     }
//   }
//
//
//
//
//   Future<void> VerificationID() async {
//     try {
//       final response = await http.get(Uri.parse('${ApiUrls.baseurl}api/verification-details/'));
//
//       if (response.statusCode == 200) {
//         final List<dynamic> dataList = json.decode(response.body);
//
//         for (int index = 0; index < dataList.length; index++) {
//           final Map<String, dynamic> data = dataList[index];
//
//           // Generate a unique ID based on the index
//           final String generatedIdoforAll = (index + 1).toString();
//
//           // Print the generated ID
//           // print('Generated ID for index $index: $generatedIdoforAll');
//           final String userEmail=data['user_email'];
//           if(userEmail==loginEmail)
//           {
//             ID2=(index+1).toString();
//             print(ID2);
//             break;
//           }
//           // Here you can use the generated ID and other data as needed
//           // For example:
//           // final String uid = data['uid']?.toString() ?? '';
//           // final String userEmail = data['user_email']?.toString() ?? '';
//
//           // Now you can use the generated ID and other data as needed
//           // For example, you can make your API call or update the UI
//         }
//       } else {
//         print('Status code: ${response.statusCode}');
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print('Error in fetchData: $e');
//     }
//   }
//   void printDataFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     email = prefs.getString('email') ?? '';
//     collegeId = prefs.getString('collegeId') ?? '';
//     rateUrCommunication=prefs.getString('communication_skills') ?? '';
//     yourSkills = prefs.getString('yourSkills') ?? '';
//     status = prefs.getString('status') ?? '';
//     scheduleDate = prefs.getString('scheduleDate') ?? '';
//     scheduleTime = prefs.getString('scheduleTime') ?? '';
//
//     print("Data from SharedPreferences:");
//     print("Email: $email");
//     print("Rate ur communication :$rateUrCommunication");
//     print("College ID: $collegeId");
//     print("Your Skills: $yourSkills");
//     print("Status: $status");
//     print("Schedule Date: $scheduleDate");
//     print("Schedule Time: $scheduleTime");
//
//   }
//   void updatePaymentStatusInRegistration() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? savedUsername = prefs.getString('username');
//
//     if (savedUsername != null && savedUsername.isNotEmpty) {
//       setState(() {
//         loginEmail = savedUsername;
//       });
//
//       // Replace the API URL with your actual API endpoint
//       final apiUrl = '${ApiUrls.baseurl}/api/registers/';
//
//       try {
//         final response = await http.get(Uri.parse(apiUrl));
//
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//
//           if (data is List && data.isNotEmpty) {
//             for (final user in data) {
//               final email = user['email'];
//
//               if (email == loginEmail) {
//
//
//                 setState(() {
//                   // Assuming you have the registration ID stored somewhere
//                   int registrationId = user['id']; // Replace with the actual registration ID
//
//                   // Make a request to update payment status only if the transaction status is SUCCESS
//
//                   //_updatePaymentStatusInRegistration(registrationId);
//
//                 });
//
//                 // Exit the loop once a match is found
//                 break;
//               }
//             }
//           } else {
//             print('Email not found on the server.');
//           }
//         }
//       } catch (e) {
//         print('Error in PhonePeGateway: $e');
//       }
//
//     }
//   }
//
//
//   Future<Map?> _initiateTransaction(String txnToken, String orderId, String amount, String mid, String callbackUrl, bool isStaging) async {
//     try {
//       // Initiate the transaction using Paytm Router SDK
//       var transactionResponse = await PaytmRouterSdk.startTransaction(mid, orderId, amount, txnToken, callbackUrl, isStaging);
//
//       // Handle the transaction response
//
//       if (transactionResponse != null && transactionResponse['STATUS'] == 'TXN_SUCCESS') {
//
//         print("Success");
//         checkOrderStatus(orderId);
//         printDataFromSharedPreferences();
//
//
//         return transactionResponse;
//       } else {
//         checkOrderStatus(orderId);
//         throw Exception('Transaction failed: ${transactionResponse!['RESPMSG']}');
//       }
//     } catch (e) {
//       // Error occurred during transaction initiation
//       throw Exception('Error initiating transaction: $e');
//     }
//   }
//
//
//
//
//
//
//
//
//   Future<void> _postTransactionResponse(String callbackUrl, Map<String, dynamic> response) async {
//     try {
//       // Making POST request to callback URL with transaction response data
//       var callbackResponse = await http.post(
//         Uri.parse(callbackUrl),
//         body: json.encode(response),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       // Checking response status
//       if (callbackResponse.statusCode == 200) {
//
//         print('Transaction response posted successfully');
//         print(callbackResponse.statusCode);
//         print(callbackResponse.body);
//         // console.log(callbackResponse.body);
//
//         // Redirect to CallbackScreen
//
//       } else {
//         print('Failed to post transaction response. Status code: ${callbackResponse.statusCode}');
//       }
//     } catch (e) {
//       // Error occurred while posting transaction response
//       print('Error posting transaction response: $e');
//     }
//   }
// }
//
