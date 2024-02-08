import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rest_note/screens/auth/intro_slide.dart';
import 'package:rest_note/screens/auth/auth_complete.dart'; // AuthCompletePage 임포트
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // 사용자가 이미 로그인되어 있다면 AuthCompletePage로 바로 이동
      _navigateToHome();
    } else {
      // 사용자가 로그인되어 있지 않다면 일정 시간 후에 IntroSlide로 이동
      Timer(const Duration(seconds: 2), () {
        _navigateToIntro();
      });
    }
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AuthCompletePage()),
    );
  }

  void _navigateToIntro() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => IntroSlide()),
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
      ),
    );
  }
}
