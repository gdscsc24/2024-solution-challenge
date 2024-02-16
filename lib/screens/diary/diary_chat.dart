import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_choose.dart';
import 'package:rest_note/screens/diary/diary_making.dart';
import 'package:rest_note/widgets/back_appbar_none.dart';
import 'package:rest_note/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DiaryChatPage extends StatefulWidget {
  DiaryChatPage({super.key});
  @override
  _DiaryChatPageState createState() => _DiaryChatPageState();
}

class _DiaryChatPageState extends State<DiaryChatPage> {
  final TextEditingController _textController = TextEditingController();
  final List<String> imageUrls = [
    'assets/images/Espresso.png',
    'assets/images/Americano.png',
    'assets/images/Macchiato.png',
  ];
  List<String> coffeeList = ['Espresso', 'Americano', 'Macchiato'];
  List<String> tasteList = ['bitter', 'balanced', 'sweet'];
  double _currentSliderValue = 0;
  int index = 0;

  Future<void> _saveTextToFirestore() async {
    if (_textController.text.isEmpty) {
      // 텍스트가 비어있다면 저장하지 않음
      return;
    }
    String text = _textController.text;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    User? currentUser = FirebaseAuth.instance.currentUser;
    String userEmail = currentUser?.email ?? 'default_email';
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail) // 사용자 이메일을 문서 ID로 사용
        .collection('datas')
        .doc(formattedDate); // 오늘 날짜로 문서 이름을 지정

    await documentReference.set({
      'date': now,
      'text': text,
    });

    // 선택적으로 사용자에게 성공 메시지를 보여줄 수 있습니다.
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BackAppBarNone(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenSize.height * 0.06),
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.082),
            child: Container(
              width: screenSize.width * 0.53,
              height: screenSize.height * 0.08,
              decoration: BoxDecoration(
                  color: Color(0xFFFFFBF2),
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.03),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Tell me more about your emotion.',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403E39),
                    decoration: TextDecoration.underline, // 밑줄 추가
                    decorationColor: Color(0xFFE9E4D1), // 밑줄 색상 지정
                    decorationThickness: 2.0, // 밑줄 두께 지정
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.05),
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.31),
            child: Container(
              width: screenSize.width * 0.63,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  filled: true, // 배경색 적용
                  fillColor: Color(0xFFFFFBF2), // 배경색 지정
                  hintText: 'Write here...',
                  hintStyle: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF403E39),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // 텍스트 필드의 모서리 둥글기 설정
                    borderSide: BorderSide.none, // 테두리 제거
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF403E39),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFFE9E4D1),
                  decorationThickness: 2.0,
                ),
                maxLines: null,
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Row(
            children: [
              SizedBox(width: screenSize.width * 0.5),
              ChatButton(
                  text: 'Skip',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiaryChoosePage()),
                    );
                  }),
              SizedBox(width: screenSize.width * 0.03),
              ChatButton(
                text: 'Done',
                onPressed: () {
                  _saveTextToFirestore().then((_) {
                    // 성공적으로 저장 후에 다음 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiaryMakingPage()),
                    );
                  }).catchError((error) {
                    // 오류 처리...
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ChatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  ChatButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFF333258),
        minimumSize: Size(
          screenSize.width * 0.17,
          screenSize.height * 0.028,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
