import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/signup_verify.dart';
import 'package:rest_note/widgets/submit_button.dart';

class SignupMailPage extends StatelessWidget {
  const SignupMailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFAF1F1),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.29),
            const Text(
              'Sign up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color(0xFF302E2E),
              ),
            ),
            SizedBox(height: screenSize.height * 0.083),
            Padding(
              padding: EdgeInsets.only(bottom: screenSize.height * 0.016),
              child: SizedBox(
                width: screenSize.width * 0.72,
                height: screenSize.height * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
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
            SubmitButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignupVerifyPage()),
                );
              },
              buttonText: 'Sign up',
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
