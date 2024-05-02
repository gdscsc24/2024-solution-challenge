import 'package:flutter/material.dart';
import 'package:rest_note/screens/counselor/counselor_main.dart';
import 'package:rest_note/screens/diary/diary_coffee.dart';
import 'package:rest_note/screens/diary/diary_main.dart';
import 'package:rest_note/screens/location/location_main.dart';
import 'package:rest_note/widgets/option_button.dart';

class ResultPage extends StatelessWidget {
  final int totalScore;

  const ResultPage({Key? key, required this.totalScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: SingleChildScrollView(
        // 여기에 SingleChildScrollView를 추가
        child: Center(
          child: Container(
            width: 393,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFFF6F7E8), Colors.white],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Center for Epidemiological \nStudies-Depression Scale (CES-D)\nResult',
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFF262522),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Moodi',
                                    style: const TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Color(0xFFFF7A5C),
                                    ),
                                  ),
                                  Text(
                                    "'s",
                                    style: const TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Color(0xFF262522),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "depression score is",
                                style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: Color(0xFF262522),
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "$totalScore",
                                style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 25,
                                  color: Color(0xFF262522),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                          SizedBox(width: 30),
                          Image.asset(
                            'assets/images/body.png',
                            height: 120,
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      Image.asset(
                        'assets/images/score.png',
                        height: 300,
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Recommended feature',
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Color(0xFF262522),
                        ),
                      ),
                      SizedBox(height: 10),
                      OptionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationPage()),
                            );
                          },
                          buttonText: '주변 치료 센터 찾아보기',
                          buttonSubText: '내 주변 심리 상담 클리닉을 찾아보세요'),
                      SizedBox(height: 10),
                      OptionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiaryCoffeePage()),
                            );
                          },
                          buttonText: '감정 일기 쓰기          ',
                          buttonSubText: '내 음성 데이터로 내가 느끼는 감정을 분석해줘요')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
