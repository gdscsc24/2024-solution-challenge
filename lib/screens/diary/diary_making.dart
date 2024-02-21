import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_finish.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiaryMakingPage extends StatefulWidget {
  DiaryMakingPage({super.key});
  @override
  _DiaryMakingPageState createState() => _DiaryMakingPageState();
}

class _DiaryMakingPageState extends State<DiaryMakingPage> {
  int index = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    final User? user = _auth.currentUser;
    final String email =
        user?.email ?? "defaultEmail@example.com"; // 사용자 이메일이 없는 경우 대비 기본값 설정
    final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    Timer(
      const Duration(seconds: 1),
      () {
        fetchVideoInfo(email: email, date: currentDate);
        // After the specified duration, navigate to the home screen or any other screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DiaryFinishPage(),
          ),
        );
      },
    );
  }

  Future<void> fetchVideoInfo(
      {required String email, required String date}) async {
    final url = Uri.parse(
        'https://us-central1-rest-diary-c01f6.cloudfunctions.net/main'); // 여기에 Cloud Function의 URL을 입력하세요.
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "date": date}));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // 여기에서 응답 데이터를 사용하세요. 예: 데이터를 상태로 설정하거나 화면에 표시
      print(data); // 콘솔에 데이터 출력, 필요에 따라 적절하게 처리
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DiaryFinishPage()));
    } else {
      // 오류 처리
      print('Failed to load video info');
    }
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
