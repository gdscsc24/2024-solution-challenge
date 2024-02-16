import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_choose.dart';
import 'package:rest_note/screens/diary/diary_making.dart';
import 'package:rest_note/widgets/back_appbar.dart';
import 'package:rest_note/widgets/back_appbar_none.dart';

class DiaryChatPage extends StatefulWidget {
  DiaryChatPage({super.key});
  @override
  _DiaryChatPageState createState() => _DiaryChatPageState();
}

class _DiaryChatPageState extends State<DiaryChatPage> {
  final List<String> imageUrls = [
    'assets/images/Espresso.png',
    'assets/images/Americano.png',
    'assets/images/Macchiato.png',
  ];
  List<String> coffeeList = ['Espresso', 'Americano', 'Macchiato'];
  List<String> tasteList = ['bitter', 'balanced', 'sweet'];
  double _currentSliderValue = 0;
  int index = 0;
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiaryMakingPage()),
                    );
                  }),
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
