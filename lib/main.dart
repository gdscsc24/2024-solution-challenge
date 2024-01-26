import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/splash_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rest_Note',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
