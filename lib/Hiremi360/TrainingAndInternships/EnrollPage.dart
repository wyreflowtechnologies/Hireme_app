import 'dart:convert';
import 'package:hiremi_version_two/Hiremi360/TrainingAndInternships/TrainingAndInternships.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:hiremi_version_two/Hiremi360/PaytmPayment/PaytmPayment.dart';
import 'package:hiremi_version_two/Sharedpreferences_data/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Enrollpage extends StatefulWidget {
  final Map<String, dynamic> program;
  const Enrollpage({Key? key,required this.program}) : super(key: key);

  @override
  State<Enrollpage> createState() => _EnrollpageState();
}

class _EnrollpageState extends State<Enrollpage> {
  late PaymentService paymentService;
  String Email="";
  String SavedId="";
  Future<void> _printSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? 'No email saved';
    print(email);
    Email=email;
  }
  Future<void> _enrollInTrainingAndMentorship(String SavedId) async {
    // var mentorshipData = MentorshipModel(
    //   paymentStatus: "Enrolled",
    //   applied: "applied",
    //   register: SavedId,
    // );
    //
    // await mentorshipController.EnrollInMentorship(mentorshipData);
  }
  Future<void> _retrieveId() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');

    if (savedId != null) {
      setState(() {
        SavedId = savedId.toString();
      });
      print("Retrieved id is in Verification $savedId");
      print("Training id is ${widget.program["id"]}");

      // Fetch the user details from the API

    } else {
      print("No id found in SharedPreferences");
    }
  }
  Future<void> postTrainingApplication() async {
    final url = Uri.parse('http://13.127.246.196:8000/api/training-applications/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'payment_status': 'Enrolled',
        'applied': 'Applied',
        'register': SavedId,
        'TrainingProgram': widget.program['id'],
      }),
    );

    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TrainingAndInternships()),
      );
      print('Application posted successfully');
    } else {
      print('Failed to post application: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _printSavedEmail();
    _retrieveId();
    paymentService = PaymentService(context);
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
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
            "Training + Internships",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,  // Text color is needed, but will be replaced by the gradient
            ),
          ),
        ),

         centerTitle: false,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(height: screenWidth*0.049,),
            Container(
              height:MediaQuery.of(context).size.width*0.4193 ,
              width:MediaQuery.of(context).size.width*0.97 ,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Outer margin for spacing
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005), // This controls the thickness of the border
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04), // Rounded corners for the border
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                  Colors.blueAccent,
                    Colors.redAccent
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Inner padding for content inside the border
                decoration: BoxDecoration(
                  color: Colors.white,  // Card content background
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.035), // Rounded corners slightly smaller to match border
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    SizedBox(height:screenWidth*0.01 ,),
                    Text(
                      ' ${widget.program['training_program']}',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size for heading
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.013), // Responsive space between heading and content

                    // Content
                    Row(
                      children: [
                        Icon(Icons.access_time,size: screenWidth*0.03,),
                        SizedBox(width: screenWidth*0.02,),
                        Text(
                          '${widget.program['duration']}',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03, // Responsive font size for content
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                    Text("This program includes a Certificate of Completion, hands-on experience through live projects, portfolio building, and a guaranteed internship with our client companies.",
                     style: TextStyle(
                       fontSize: MediaQuery.of(context).size.width * 0.027, // Responsive font size for content
                       color: Colors.grey[700],
                     ),
                   ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenWidth*0.109,),
            Container(

              width:MediaQuery.of(context).size.width*0.97 ,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Outer margin for spacing
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005), // This controls the thickness of the border
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04), // Rounded corners for the border
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blueAccent,
                    Colors.redAccent
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Inner padding for content inside the border
                decoration: BoxDecoration(
                  color: Colors.white,  // Card content background
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.035), // Rounded corners slightly smaller to match border
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    SizedBox(height:screenWidth*0.01 ,),
                    Text(
                      'Subscribe to this professional\nprogram',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04, // Responsive font size for heading
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.013), // Responsive space between heading and content

                    // Content
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          '₹ ${widget.program['discounted_price']}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.043,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),

                        Text(
                          '₹ ${widget.program['original_price']}',
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
                          width:MediaQuery.of(context).size.width*0.1820 ,
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.005), // This controls the thickness of the border
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.04), // Rounded corners for the border
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blueAccent,
                                Colors.redAccent
                              ],
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02), // Inner padding for content inside the border
                            decoration: BoxDecoration(
                              color: Colors.white,  // Card content background
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.035), // Rounded corners slightly smaller to match border
                            ),
                            child: Text(
                              '${widget.program['discount_percentage']}% Off',
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                color: Color.fromRGBO(193, 39, 45, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth*0.03
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                    // Text("Certificate of completion"),
                    // Text("Working on live projects"),
                    // Text("Portofolip building"),
                    // Text("Guranteed Internship with client companies")
                    // ,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02), // Padding between icon and text
                            Text("Certificate of completion",
                            style: TextStyle(
                              fontSize: screenWidth*0.028
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Space between each row
                        Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Text("Working on live projects",
                              style: TextStyle(
                                  fontSize: screenWidth*0.028
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Text("Portfolio building",
                                style: TextStyle(
                                    fontSize: screenWidth*0.028
                                ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Text("Guaranteed Internship with client companies",
                              style: TextStyle(
                                  fontSize: screenWidth*0.028
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),



                    SizedBox(height: MediaQuery.of(context).size.height * 0.023),



                  ],
                ),
              ),
            ),
            SizedBox(height: screenWidth*0.109,),
            Container(
              height: screenWidth*0.1, // Set your desired height
              width: screenWidth*0.8, // Set your desired width
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.redAccent

                  ], // Your gradient colors
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10), // Optional: for rounded corners
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Make the background transparent
                  elevation: 0, // Remove the button elevation
                ),
                onPressed: () async {

                  String? _fullName = await SharedPreferencesHelper.getFullName();
                  if (_fullName != null) {
                    print(_fullName);
                    // Initiate the payment transaction and capture the result
                    bool isSuccess = await paymentService.makeTransactionRequest(_fullName, Email, widget.program['discounted_price']);

                    // Display the result of the transaction
                    if (isSuccess) {
                      // _enrollInTrainingAndMentorship(SavedId);
                      postTrainingApplication();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Transaction successful! in elevated button'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 8),
                        ),
                      );
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Transaction failed in elevated buttomn.'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 8),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "Enroll Now",
                  style: TextStyle(color: Colors.white), // Text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
