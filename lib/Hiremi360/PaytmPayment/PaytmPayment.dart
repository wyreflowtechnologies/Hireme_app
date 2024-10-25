import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Apis/api.dart';
import 'package:hiremi_version_two/PaymentFailedPage.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_routersdk/paytm_routersdk.dart';

class PaymentService {
  final BuildContext context;
  bool _isLoading = false;

  PaymentService(this.context);
  Map<String, dynamic>  taxDetailsforfailedpage={};


  Future<bool> makeTransactionRequest(String fullName, String email, double amount) async {
    print("we are in makeTransactionRequest");

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
      }
      else {
        print(response.body);
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


  // Function to initiate the transaction using SDK
  Future<Map?> _initiateTransaction(String txnToken, String orderId, String amount, String mid, String callbackUrl, bool isStaging) async {
    print("We are in _initiateTransaction");
    try {
      var transactionResponse = await PaytmRouterSdk.startTransaction(mid, orderId, amount, txnToken, callbackUrl, isStaging);

      if (transactionResponse != null && transactionResponse['STATUS'] == 'TXN_SUCCESS') {
        print("Transaction successful");
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
