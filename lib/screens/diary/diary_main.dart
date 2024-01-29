import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_coffee.dart';

class DiaryMainPage extends StatefulWidget {
  DiaryMainPage({super.key});
  @override
  _DiaryMainPageState createState() => _DiaryMainPageState();
}

class _DiaryMainPageState extends State<DiaryMainPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Row(
          children: [
            const Text(
              'Rest Note',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xFF302E2E),
              ),
            ),
            SizedBox(width: screenSize.width * 0.31),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * 0.07),
              child: const Icon(Icons.settings),
            ),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * 0.07),
              child: const Icon(Icons.notifications),
            ),
            const Icon(Icons.person_outline),
          ],
        )),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.1),
              Image.asset(
                'assets/images/lightbulb.png',
                width: screenSize.width * 0.09,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.028),
                child: const Text(
                  'Welcome!\nWould you like to order coffee?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF302E2E),
                  ),
                ),
              ),
              Image.asset(
                'assets/images/diary_main_cafe.png',
                width: screenSize.width * 0.75,
              ),
              Ink(
                  decoration: ShapeDecoration(
                    color: Color(0xFFFAF1F1),
                    shape: CircleBorder(),
                    shadows: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiaryCoffeePage()),
                        );
                      },
                      icon: Icon(Icons.add)))
            ],
          ),
        ));
  }
}
