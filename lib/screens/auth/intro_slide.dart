import 'package:flutter/material.dart';
import 'package:rest_note/screens/auth/signup_main.dart';
import 'package:rest_note/widgets/submit_button.dart';

class IntroSlide extends StatefulWidget {
  @override
  _IntroSlideState createState() => _IntroSlideState();
}

class _IntroSlideState extends State<IntroSlide> {
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
  final List<IconData> icons = [
    Icons.radio_button_off_outlined,
    Icons.radio_button_off_outlined,
    Icons.radio_button_off_outlined,
    Icons.radio_button_off_outlined,
  ];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF1F1),
      body: Padding(
        padding: EdgeInsets.only(top: screenSize.height * 0.23),
        child: PageView.builder(
          itemCount: icons.length,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
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
                SizedBox(height: screenSize.height * 0.04),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.17),
                  child: Image.asset(
                    imageUrls[index],
                    width: screenSize.width * 0.65,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.035),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      icons.length,
                      (iconIndex) => ColoredIcon(
                        icon: icons[iconIndex],
                        color: _getColorForIndex(iconIndex, index),
                      ),
                    ),
                  ),
                ),
                if (index == 3) //맨 마지막 페이지일때 회원가입 버튼 나타나기
                  SubmitButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupPage()),
                      );
                    },
                    buttonText: "Let's start",
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color _getColorForIndex(int iconIndex, int pageIndex) {
    int currentPage = pageIndex % 4;
    return iconIndex == currentPage
        ? const Color(0xFF333258)
        : const Color(0xFFBDBDBD);
  }
}

// 페이지 동그라미 색상
class ColoredIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  ColoredIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: color,
          size: screenSize.width * 0.06,
        ),
      ),
    );
  }
}
