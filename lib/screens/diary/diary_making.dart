import 'dart:async';

import 'package:flutter/material.dart';

import 'package:rest_note/screens/diary/diary_finish.dart';

class DiaryMakingPage extends StatefulWidget {
  DiaryMakingPage({super.key});
  @override
  _DiaryMakingPageState createState() => _DiaryMakingPageState();
}

class _DiaryMakingPageState extends State<DiaryMakingPage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(
          seconds:
              1), // Set the duration for which the splash screen will be displayed (e.g., 3 seconds)
      () {
        // After the specified duration, navigate to the home screen or any other screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DiaryFinishPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.3),
          Padding(
            padding: EdgeInsets.only(right: screenSize.width * 0.23),
            child: Image.asset(
              'assets/images/grinder.png',
              width: screenSize.width * 0.38,
            ),
          ),
          SizedBox(height: screenSize.height * 0.03),
          Text(
            'Making...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 38,
              fontWeight: FontWeight.w800,
              color: Color(0xFF302E2E),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          const Text(
            'We are making a new recipe for you',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF302E2E),
            ),
          ),
        ],
      ),
    ));
  }
}
