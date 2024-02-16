import 'package:flutter/material.dart';

import 'package:rest_note/widgets/back_appbar.dart';

import 'package:fl_chart/fl_chart.dart';

class MyHistoryPage extends StatefulWidget {
  MyHistoryPage({super.key});
  @override
  _MyHistoryPageState createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 2),
        child: BackAppBar(text: 'My History'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomContainer(
              text: 'Monthly mood graph',
              child: Padding(
                padding: EdgeInsets.only(
                    left: screenSize.width * 0.05,
                    bottom: screenSize.height * 0.02),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: screenSize.width * 0.39,
                          height: screenSize.width * 0.39,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFBF2), // 원 내부의 색상
                            shape: BoxShape.circle, // 원 모양
                          ),
                        ),
                        Positioned(
                          left: (screenSize.width * 0.39 -
                                  screenSize.width * 0.35) /
                              2, // 중심 정렬
                          top: (screenSize.width * 0.39 -
                                  screenSize.width * 0.35) /
                              2,
                          child: Container(
                            width: screenSize.width * 0.35,
                            height: screenSize.width * 0.35,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                      value: 30,
                                      color: Color(0xFAF1F1),
                                      radius: screenSize.width * 0.08,
                                      title: ''),
                                  PieChartSectionData(
                                      value: 20,
                                      color: Color(0xFFD6E4F0),
                                      radius: screenSize.width * 0.08,
                                      title: ''),
                                  PieChartSectionData(
                                    value: 50,
                                    color: Color(0xFFE0E0E0),
                                    radius: screenSize.width * 0.08,
                                    title: '',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        MoodCoffee(
                          image: 'assets/images/Espresso.png',
                          coffeetext: 'Espresso',
                          fontcolor: Color(0xFFE0E0E0),
                          borderColor: Color(0xFF757575),
                          percentage: '50%',
                        ),
                        MoodCoffee(
                          image: 'assets/images/Americano.png',
                          coffeetext: 'Americano',
                          fontcolor: Color(0xFFFAF1F1),
                          borderColor: Color(0xFF8E4917),
                          percentage: '30%',
                        ),
                        MoodCoffee(
                          image: 'assets/images/Macchiato.png',
                          coffeetext: 'Macchiato',
                          fontcolor: Color(0xFFD6E4F0),
                          borderColor: Color(0xFF333258),
                          percentage: '20%',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            CustomContainer(
              text: 'My Records',
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenSize.width * 0.06, 0,
                        screenSize.width * 0.06, screenSize.height * 0.05),
                    child: Column(
                      children: [
                        Image.asset('assets/images/Espresso.png',
                            width: screenSize.width * 0.15),
                        SizedBox(height: 5),
                        const Row(
                          children: [
                            Text(
                              '32 ',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF7A5C),
                              ),
                            ),
                            Text(
                              'cups of coffee',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenSize.height * 0.05),
                    child: Container(
                      height: screenSize.height * 0.12,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.5,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenSize.width * 0.06,
                        screenSize.height * 0.02,
                        screenSize.width * 0.06,
                        screenSize.height * 0.05),
                    child: Column(
                      children: [
                        Image.asset('assets/images/read.png',
                            width: screenSize.width * 0.15),
                        SizedBox(height: 5),
                        const Row(
                          children: [
                            Text(
                              '69 ',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFF7A5C),
                              ),
                            ),
                            Text(
                              'recipes made',
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomContainer(
                text: "The month's top moods",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.1),
                      child: Image.asset('assets/images/coffee_machine.png',
                          width: screenSize.width * 0.28),
                    ),
                    const Column(
                      children: [
                        const MoodCoffee(
                            image: 'assets/images/1st.png',
                            coffeetext: 'regretful',
                            fontcolor: Color(0xFF4265C0),
                            borderColor: Color(0xFF4265C0),
                            percentage: ''),
                        MoodCoffee(
                            image: 'assets/images/2nd.png',
                            coffeetext: 'frustrated',
                            fontcolor: Color(0xFFA85757),
                            borderColor: Color(0xFFA85757),
                            percentage: ''),
                        MoodCoffee(
                            image: 'assets/images/3rd.png',
                            coffeetext: 'annoyed',
                            fontcolor: Color(0xFFF77A7A),
                            borderColor: Color(0xFFF77A7A),
                            percentage: ''),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget child;
  final String text;
  const CustomContainer({required this.child, required this.text});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(screenSize.width * 0.06,
          screenSize.height * 0.01, 0, screenSize.height * 0.01),
      child: Container(
        width: screenSize.width * 0.86,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenSize.width * 0.05,
                  vertical: screenSize.height * 0.02),
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}

class MoodCoffee extends StatelessWidget {
  final String image;
  final String coffeetext;
  final Color fontcolor;
  final Color borderColor;
  final String percentage;

  const MoodCoffee(
      {required this.image,
      required this.coffeetext,
      required this.fontcolor,
      required this.borderColor,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: screenSize.width * 0.02, bottom: screenSize.height * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            image,
            width: screenSize.width * 0.094,
            height: screenSize.height * 0.03,
          ),
          // 이미지와 텍스트 사이 간격 조정
          Container(
            // 컨테이너를 사용하여 텍스트를 감싸고 너비를 설정합니다.
            width: screenSize.width * 0.26, // 원하는 너비로 설정하세요.
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 텍스트와 백분율을 좌우 끝에 배치합니다.
              children: [
                Text(
                  coffeetext,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: fontcolor,
                  ),
                ),
                Text(
                  percentage,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
