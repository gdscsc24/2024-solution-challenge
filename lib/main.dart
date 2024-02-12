import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rest_note/screens/auth/splash_screen.dart';
import 'package:rest_note/screens/auth/auth_complete.dart'; // AuthCompletePage 임포트

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rest_Note',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 연결 상태 확인
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // 로딩 인디케이터 표시
          } else if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다.')); // 오류 화면 표시
          } else if (snapshot.data == null) {
            return const SplashScreen(); // 로그인 화면 표시
          } else {
            return const AuthCompletePage(); // AuthCompletePage로 이동
          }
        },
      ),
    );
  }
}
