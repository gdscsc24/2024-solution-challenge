import 'package:flutter/material.dart';
import 'package:rest_note/nav_page.dart';

import 'package:rest_note/screens/diary/diary_main.dart';
import 'package:rest_note/screens/recommended/recommend_main.dart';

import 'package:rest_note/widgets/submit_button.dart';

class DiaryFinishPage extends StatefulWidget {
  DiaryFinishPage({super.key});
  @override
  _DiaryFinishPageState createState() => _DiaryFinishPageState();
}

class _DiaryFinishPageState extends State<DiaryFinishPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(height: screenSize.height * 0.3),
          Image.asset(
            'assets/images/finish_coffee.png',
            width: screenSize.width * 0.26,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.026),
            child: Text(
              'Finished!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 38,
                fontWeight: FontWeight.w800,
                color: Color(0xFF302E2E),
              ),
            ),
          ),
          SubmitButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            },
            buttonText: "Check my new recipe",
          )
        ],
      ),
    ));
  }
}
