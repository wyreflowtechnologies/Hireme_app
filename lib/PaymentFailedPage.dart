
import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Notofication_screen.dart';

class PaymentFailedPage extends StatefulWidget {
  final Function(double) onTryAgain;

  const PaymentFailedPage({Key? key, required this.onTryAgain}) : super(key: key);

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment and verification',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const NotificationScreen()));
            },
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
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
                      color: Color(0xFFC1272D),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Image.asset(
              'images/Group 33983.png',
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
        

        
            Text(
              "We aren't able to process your payment. Please try again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.025,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC1272D),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
        
        
            ElevatedButton(
              onPressed: _isLoading
                  ? null // Disable button when loading
                  : () async {
                setState(() {
                  _isLoading = true;
                });
        
                try {
                  widget.onTryAgain(10.00); // Call the passed function with the amount parameter
        
                } finally {
                  setState(() {
                    _isLoading = false;
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
                'Try Again',
                style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.0165),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
