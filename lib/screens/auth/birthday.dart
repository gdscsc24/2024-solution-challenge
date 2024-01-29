import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/auth_complete.dart';
import 'package:rest_note/widgets/submit_button.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class BirthdayPage extends StatefulWidget {
  @override
  _BirthdayPageState createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveBirthday() async {
    String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
    String birthdayStr = _controller.text;

    try {
      DateFormat format = DateFormat('yyyy/MM/dd');
      DateTime birthday = format.parseStrict(birthdayStr);

      Timestamp birthdayTimestamp = Timestamp.fromDate(birthday);

      await _firestore.collection('users').doc(userEmail).set({
        'birthday': birthdayTimestamp,
      }, SetOptions(merge: true));
    } catch (e) {
      // 날짜 파싱 오류 처리
      print('Error parsing date: $e');
      // 필요에 따라 사용자에게 오류 메시지를 표시하세요.
    }
  }

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
              'Your Birthday',
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
                controller: _controller,
                onChanged: (value) {
                  if (value.length == 4 || value.length == 7) {
                    _controller.text = '$value/';
                    _controller.selection = TextSelection.collapsed(
                        offset: _controller.text.length);
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9/]')), //숫자와 / 입력가능
                  LengthLimitingTextInputFormatter(10), // 최대 길이 10
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'YYYY / MM / DD',
                  hintStyle: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF757575),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.12,
                  ),
                  counterText: '', // counterText를 빈 문자열로 설정하여 힌트 텍스트에 맞춰서 입력됨
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
              onPressed: () async {
                await _saveBirthday();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AuthCompletePage()),
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
