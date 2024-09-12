import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/api.dart';

class VerifiedProfileWidget extends StatefulWidget {
  final String name;



  const VerifiedProfileWidget({
    Key? key,
    required this.name,

  }) : super(key: key);

  @override
  State<VerifiedProfileWidget> createState() => _VerifiedProfileWidgetState();
}

class _VerifiedProfileWidgetState extends State<VerifiedProfileWidget> {
  String UID="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchVerificationUID();
  }


  Future<void> _fetchVerificationUID() async {
    final prefs = await SharedPreferences.getInstance();
    final int? savedId = prefs.getInt('userId');

    if (savedId == null) {
      print("No id found in SharedPreferences");
      return;
    }

    const String verificationUrl = "${ApiUrls.baseurl}/api/verification-details/";

    try {
      final response = await http.get(Uri.parse(verificationUrl));

      if (!mounted) return; // Check if the widget is still mounted

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (var item in data) {
          if (item['register'] == savedId) {
            final String uid = item['uid'];
            setState(() {
              UID = uid;
            });

            await prefs.setString('uid', uid);
            print('UID stored: $uid');

            if (!mounted) return; // Check again if the widget is still mounted

            // Show the dialog with the UID

            break;
          }
        }
      } else {
        print('Failed to fetch verification details');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFFFBECEC),
          radius: MediaQuery.of(context).size.width * 0.07,
          child: const Icon(
            Icons.person,
            color: Color(0xFFC1272D),
            size: 18.86,
          ),
        ),
        const SizedBox(
            width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${widget.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Icon(
                  Icons.fingerprint,
                  size: 10.7,
                ),
                const Text(
                  'App ID: ',
                  style: TextStyle(fontSize: 10.7),
                ),
                Text(
                  UID,
                  style: const TextStyle(fontSize: 10.7, color: Colors.grey),
                ),

              ],
            ),

          ],
        ),
        const Spacer(),
        Container(
          height: MediaQuery.of(context).size.width * 0.08,
          width: MediaQuery.of(context).size.width * 0.17,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/new_releases (1).png'),
                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                const Text(
                  'Verfied',

                  style: TextStyle(color: Colors.white, fontSize: 8.42),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
