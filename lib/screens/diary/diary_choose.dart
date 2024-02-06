import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_chat.dart';
import 'package:rest_note/widgets/back_appbar.dart';
import 'package:rest_note/widgets/submit_button.dart';

class DiaryChoosePage extends StatefulWidget {
  DiaryChoosePage({super.key});
  @override
  _DiaryChoosePageState createState() => _DiaryChoosePageState();
}

class _DiaryChoosePageState extends State<DiaryChoosePage> {
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
        appBar: const BackAppBar(),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.1),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.028),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'How do you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF302E2E),
                          ),
                        ),
                        Text(
                          ' feel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color:
                                Color(0xFFFF7A5C), // feel 텍스트의 색상을 원하는 색상으로 설정
                          ),
                        ),
                        Text(
                          ' now?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF302E2E),
                          ),
                        ),
                      ])),
              const Text(
                'Choose 1-3 words that best describe your mood',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF302E2E),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              SubmitButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiaryChatPage()),
                  );
                },
                buttonText: 'Next',
              ),
            ],
          ),
        ));
  }
}
