import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/PaymentFailedPage.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:hiremi_version_two/verified_page.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_routersdk/paytm_routersdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentServiceforVerified {
  final BuildContext context;
  bool _isLoading = false;

  PaymentServiceforVerified(this.context);
  String SavedId="";
  String Email="";
  Map<String, dynamic>  taxDetailsforfailedpage={};

  // Function to handle transaction requests
  // Function to handle transaction requests
  Future<bool> makeTransactionRequestforVerified(String fullName, String email, double amount) async {
    print("we are in makeTransactionRequestforVerified");

    _setLoading(true);

    try {
      var url = '${ApiUrls.baseurl}/pay/';
      var orderId = DateTime.now().millisecondsSinceEpoch.toString();

      var params = {
        'name': fullName,
        'amount': amount.toString(),
        'orderId': orderId,
        'email': email
      };

      var response = await http.post(
        Uri.parse(url),
        body: json.encode(params),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print('Response data: $responseData');

        if (responseData.containsKey('txnToken') && responseData.containsKey('orderId') && responseData.containsKey('amount')) {
          var txnToken = responseData['txnToken'];
          var orderId = responseData['orderId'];
          var amount = responseData['amount'];
          var mid = '216820000000000077910';
          var callbackUrll = '${ApiUrls.baseurl}/callback/';
          var isStaging = false;

          var transactionResponse = await _initiateTransaction(txnToken, orderId, amount, mid, callbackUrll, isStaging);

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
            print("Transaction successful");
            await _postTransactionResponse(callbackUrll, txnDetails);
            return true; // Transaction was successful
          } else {
            print('Transaction failed');
            return false; // Transaction failed
          }
        } else {
          print('Error: Missing required data in response');
          return false;
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
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
  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');
    if (savedId != null) {
      print("Retrieved id is $savedId");
      SavedId = savedId.toString();
      print(SavedId);
    } else {
      print("No id found in SharedPreferences");
    }

  }

  Future<void> _postVerificationDetails() async {
    _retrieveId();
    print("We are in _postVerificationDetails");

    try {
      // Retrieve the enrollment number and interested domain from SharedPreferences
      String? enrollmentNumber = await SharedPreferencesHelper.getEnrollmentNumber();
      String? interestedDomain = await SharedPreferencesHelper.getInterestedDomain();

      // Ensure values are not null
      if (enrollmentNumber != null && interestedDomain != null) {
        final url = '${ApiUrls.baseurl}/api/verification-details/';
        final params = {
          "payment_status": "Enrolled",
          'college_id_number': enrollmentNumber,
          'interested_domain': interestedDomain,
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
          // Adding a small delay to ensure no premature navigation
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => const VerifiedPage()));
        } else {
          print('Failed to post verification details. Status code: ${response.statusCode}');
          print(response.body);
        }
      } else {
        print('Enrollment number or interested domain is null.');
      }
    }
    catch (e) {
      print('Error posting verification details: $e');
    }
  }


  // Function to initiate the transaction using SDK
  Future<Map?> _initiateTransaction(String txnToken, String orderId, String amount, String mid, String callbackUrl, bool isStaging) async {
    print("We are in _initiateTransaction");
    try {
      var transactionResponse = await PaytmRouterSdk.startTransaction(mid, orderId, amount, txnToken, callbackUrl, isStaging);

      if (transactionResponse != null && transactionResponse['STATUS'] == 'TXN_SUCCESS') {
        print("Transaction successful");
        _postVerificationDetails();
        _checkOrderStatus(orderId);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Transaction successful! Transaction ID: ${transactionResponse['TXNID']}"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        return transactionResponse;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transaction failed: ${transactionResponse!['RESPMSG']}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        print('Transaction failed: ${transactionResponse!['RESPMSG']}');
        _checkOrderStatus(orderId);

        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error initiating transaction: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      throw Exception('Error initiating transaction: $e');
    }
  }

  // Function to post transaction response to the server
  Future<void> _postTransactionResponse(String callbackUrl, Map<String, dynamic> response) async {
    print("we are in _postTransactionResponse");
    try {
      var callbackResponse = await http.post(
        Uri.parse(callbackUrl),
        body: json.encode(response),
        headers: {'Content-Type': 'application/json'},
      );

      if (callbackResponse.statusCode == 200) {
        print('Transaction response posted successfully');
        var callbackResponseBody = json.decode(callbackResponse.body);

        if (callbackResponseBody['verifySignature'] == true) {
          print("Signature verified");
        }
      } else {
        print('Failed to post transaction response. Status code: ${callbackResponse.statusCode}');
      }
    } catch (e) {
      print('Error posting transaction response: $e');
    }
  }

  // Helper functions
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  Map<String, dynamic> _extractTransactionDetails(Map<String, dynamic> transactionResponse) {
    return {
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
      'TXNID': transactionResponse['TXNID'],
    };
  }


  void _checkOrderStatus(String orderId) {
    // Logic to check the order status
    print('Checking order status for orderId: $orderId');
  }


}
