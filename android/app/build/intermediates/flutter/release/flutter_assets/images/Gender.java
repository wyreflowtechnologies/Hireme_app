import 'package:flutter/material.dart';
import 'package:hiremi_version_two/Custom_Widget/Curved_Container.dart';
import 'package:hiremi_version_two/Custom_Widget/Elevated_Button.dart';
import 'package:hiremi_version_two/Custom_Widget/SliderPageRoute.dart';
import 'package:hiremi_version_two/Custom_Widget/TextFeild.dart';
import 'package:hiremi_version_two/Login.dart';

enum Gender { male, female, other }

class Registers extends StatefulWidget {
  const Registers({Key? key}) : super(key: key);

  @override
  State<Registers> createState() => _RegistersState();
}

class _RegistersState extends State<Registers> {
  Gender? _selectedGender;
  String? _selectedState;
  List<String> _states = ['State 1', 'State 2', 'State 3', 'State 4'];

  void _handleGenderChange(Gender? value) {
    setState(() {
      _selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.6;
    double imageHeight = MediaQuery.of(context).size.height * 0.157;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'images/Hiremi_new_Icon.png',
                width: imageSize,
                height: imageHeight,
              ),
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Register to get started\n",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Start your journey with us ",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0425),
            CurvedContainer(
              backgroundColor: Colors.white,
              borderColor: Colors.black,
              borderWidth: 0.53,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.045),
                  buildSectionHeader("Personal Information"),
                  buildLabeledTextField(
                    context,
                    "Full Name",
                    "John Doe",
                  ),
                  buildLabeledTextField(
                    context,
                    "Father's Full Name",
                    "Robert Dave",
                  ),
                  buildGenderField(),
                  buildLabeledTextField(
                    context,
                    "Email Address",
                    "yourEmail@gmail.com",
                  ),
                  buildLabeledTextField(
                    context,
                    "Date Of Birth",
                    "DD/MM/YYYY",
                    showPositionedBox: true,
                    prefixIcon: Icons.calendar_month,
                  ),
                  buildLabeledTextField(
                    context,
                    "Birth Place",
                    "Select State",
                  ),
                  buildSectionHeader("Contact Information"),
                  buildLabeledTextField(
                    context,
                    "Phone Number",
                    "+91",
                  ),
                  buildLabeledTextField(
                    context,
                    "WhatsApp Number",
                    "+91",
                  ),
                  buildSectionHeader("Educational Information"),
                  buildLabeledTextField(
                    context,
                    "College Name",
                    "College Name here",
                  ),
                  buildStateDropdownField(
                    context,
                    "College's state",
                  ),
                  buildLabeledTextField(
                    context,
                    "Branch",
                    "Select Branch",
                  ),
                  buildLabeledTextField(
                    context,
                    "Degree",
                    "Select course",
                  ),
                  buildLabeledTextField(
                    context,
                    "Passing Year",
                    "Enter your passing year",
                  ),
                  buildSectionHeader("Let's Create Password"),
                  buildLabeledTextField(
                    context,
                    "Password",
                    "********",
                    prefixIcon: Icons.lock,
                    showPositionedBox: true,
                    obscureText: true,
                  ),
                  buildLabeledTextField(
                    context,
                    "Confirm Password",
                    "********",
                    prefixIcon: Icons.lock,
                    showPositionedBox: true,
                    obscureText: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                  Center(
                    child: CustomElevatedButton(
                      width: MediaQuery.of(context).size.width * 0.775,
                      height: MediaQuery.of(context).size.height * 0.0625,
                      text: 'Register Now',
                      onPressed: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(page: LogIn()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.018),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(String text) {
    return Column(
      children: [
        Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
      ],
    );
  }

  Widget buildLabeledTextField(
      BuildContext context,
      String label,
      String hintText, {
        bool showPositionedBox = false,
        IconData? prefixIcon,
        bool obscureText = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: CurvedTextField(
            hintText: hintText,
            showPositionedBox: showPositionedBox,
            prefixIcon: prefixIcon,
            obscureText: obscureText,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
      ],
    );
  }

  Widget buildStateDropdownField(BuildContext context, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            value: _selectedState,
            hint: Text('Select State'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedState = newValue;
              });
            },
            items: _states.map((String state) {
              return DropdownMenuItem<String>(
                value: state,
                child: Text(state),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
      ],
    );
  }

  Widget buildGenderField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Gender",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.0185),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: Gender.values.map((gender) {
              return Row(
                children: [
                  Radio<Gender>(
                    value: gender,
                    groupValue: _selectedGender,
                    onChanged: _handleGenderChange,
                  ),
                  Text(gender.name.capitalize()),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
