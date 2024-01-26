import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/intro_slide.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
            builder: (context) => IntroSlide(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFFFAF1F1),
        body: Center(
          child: Image.asset(
            'assets/images/loading_logo.png',
            width: screenSize.width * 0.78,
          ),
        ));
  }
}
