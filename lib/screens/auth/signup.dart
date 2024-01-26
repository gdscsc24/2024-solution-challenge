import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAF1F1),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: screenSize.height * 0.29),
              const Text(
                'Create a new account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF302E2E),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF333258), // 텍스트 색상
                    minimumSize: Size(screenSize.width * 0.72,
                        screenSize.height * 0.055), // 최소 크기
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // 모서리 둥글게
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(width: 8),
                      Text(
                        'Sign up with email',
                        style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF),
                        ),
                      ), // 텍스트
                      // 텍스트와 이모지 간격 조절
                      // 이모지
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFFFAE100),
                    minimumSize: Size(screenSize.width * 0.72,
                        screenSize.height * 0.055), // 최소 크기
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // 모서리 둥글게
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(width: 8),
                      Text(
                        'Sign up with kakao',
                        style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ), // 텍스트
                      // 텍스트와 이모지 간격 조절
                      // 이모지
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFFFFFFFF), // 텍스트 색상
                    minimumSize: Size(screenSize.width * 0.72,
                        screenSize.height * 0.055), // 최소 크기
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // 모서리 둥글게
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(width: 8),
                      Text(
                        'Sign up with google',
                        style: const TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ), // 텍스트
                      // 텍스트와 이모지 간격 조절
                      // 이모지
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
