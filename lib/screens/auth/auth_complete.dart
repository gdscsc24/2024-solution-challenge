import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_main.dart';
import 'package:rest_note/widgets/submit_button.dart';

class AuthCompletePage extends StatelessWidget {
  const AuthCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF1F1),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.35),
            Image.asset('assets/images/ok.png',
                height: screenSize.height * 0.15),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: screenSize.height * 0.026),
              child: const Text(
                'Completed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF302E2E),
                ),
              ),
            ),
            SubmitButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DiaryMainPage()),
                );
              },
              buttonText: "Let's start!",
            )
          ],
        ),
      ),
    );
  }
}
