import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/birthday.dart';
// import 'package:rest_note/screens/auth/signup_verify.dart';
import 'package:rest_note/widgets/submit_button.dart';

class NicknamePage extends StatelessWidget {
  const NicknamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF1F1),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.29),
            const Text(
              'Your Nickname',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: Color(0xFF302E2E),
              ),
            ),
            SizedBox(height: screenSize.height * 0.13),
            SizedBox(
              width: screenSize.width * 0.72,
              height: screenSize.height * 0.03,
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.12,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/images/auth_line.png',
              width: screenSize.width * 0.7,
            ),
            SizedBox(height: screenSize.height * 0.07),
            SubmitButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BirthdayPage()),
                );
              },
              buttonText: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
