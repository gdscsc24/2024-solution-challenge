import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/nickname.dart';
import 'package:rest_note/screens/auth/signup_main.dart';
import 'package:rest_note/screens/diary/diary_main.dart';

import 'package:rest_note/widgets/submit_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginMailPage extends StatefulWidget {
  const LoginMailPage({Key? key}) : super(key: key);

  @override
  _LoginMailPageState createState() => _LoginMailPageState();
}

class _LoginMailPageState extends State<LoginMailPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color(0xFF302E2E),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.016),
              child: SizedBox(
                width: screenSize.width * 0.72,
                height: screenSize.height * 0.06,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333258),
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.12),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.016),
              child: SizedBox(
                width: screenSize.width * 0.72,
                height: screenSize.height * 0.06,
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333258),
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.12),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SubmitButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DiaryMainPage()),
                  );
                } on FirebaseAuthException catch (e) {
                  // 에러 처리: 오류 메시지 표시
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'An error occurred')),
                  );
                }
              },
              buttonText: 'Login',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "You're new?",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF302E2E),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: const Text(
                      'Create new',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFB6C4B),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
