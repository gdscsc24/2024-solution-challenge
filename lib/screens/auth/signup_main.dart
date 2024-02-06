import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/nickname.dart';
import 'package:rest_note/screens/auth/signup_mail.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '671024400454-1lo4ta2t4mfek3u4tsg0pi3dagvok5bt.apps.googleusercontent.com', // 여기에 웹 클라이언트 ID를 넣으세요.
  );

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
              'Create a new account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color(0xFF302E2E),
              ),
            ),
            SizedBox(height: screenSize.height * 0.03),
            SignupButton(
              text: 'sign up with email',
              backgroundColor: const Color(0xFF333258),
              textColor: Colors.white,
              imagePath: 'assets/images/mail.png',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignupMailPage()),
                );
              },
            ),
            SignupButton(
              text: 'sign up with facebook',
              backgroundColor: const Color(0xFF1947E5),
              textColor: Colors.white,
              imagePath: 'assets/images/facebook.png',
              onPressed: () {
                // Your logic here
              },
            ),
            SignupButton(
              text: 'sign up with google',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              imagePath: 'assets/images/google.png',
              onPressed: () async {
                try {
                  UserCredential userCredential = await signInWithGoogle();
                  // 로그인에 성공한 경우, NicknamePage로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NicknamePage()),
                  );
                } catch (error) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text(error.toString()),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF302E2E),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Login',
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
}

//계정 종류 선택 버튼 위젯
class SignupButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final String imagePath;
  final VoidCallback onPressed;

  SignupButton({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.14, vertical: 11),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          minimumSize: Size(
            screenSize.width * 0.72,
            screenSize.height * 0.055,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 24.0, // 이미지 크기 조절
              height: 24.0,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
