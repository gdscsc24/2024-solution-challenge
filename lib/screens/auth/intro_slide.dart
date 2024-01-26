import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/signup.dart';

class IntroSlide extends StatefulWidget {
  @override
  _IntroSlideState createState() => _IntroSlideState();
}

class _IntroSlideState extends State<IntroSlide> {
  final PageController _pageController = PageController();

  final List<String> imageUrls = [
    'assets/images/slide_image_1.png',
    'assets/images/slide_image_2.png',
    'assets/images/slide_image_3.png',
    'assets/images/slide_image_4.png'
  ];
  List<String> textList = [
    '\nRecord your emotion',
    'Plenty of contents \nfor mental care',
    'Find yourself \ngrowing every day',
    'Find a mental health \nprovider near you'
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF1F1),
      body: Padding(
        padding: EdgeInsets.only(top: screenSize.height * 0.23),
        child: Container(
          height: screenSize.height * 0.73,
          child: PageView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(
                    textList[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF302E2E),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.048),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.17),
                    child: Image.asset(
                      imageUrls[index],
                      width: screenSize.width * 0.65,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text('Sign up'))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
