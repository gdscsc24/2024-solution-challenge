import 'dart:js_interop';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rest_note/widgets/back_appbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHistoryPage extends StatefulWidget {
  MyHistoryPage({super.key});
  @override
  _MyHistoryPageState createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  int num_Espresso = 0;
  int num_Americano = 0;
  int num_Macchiato = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String percentage_espresso = "0%";
  String percentage_americano = "0%";
  String percentage_macchiato = "0%";

  @override
  void initState() {
    super.initState();
    countMoods();
  }

  Future<void> countMoods() async {
    final User? user = _auth.currentUser;
    final String userEmail = user?.email ?? "defaultEmail@example.com";
    final String currentYearMonth =
        DateFormat('yyyy-MM').format(DateTime.now());

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('datas')
        .where(FieldPath.documentId,
            isGreaterThanOrEqualTo: "$currentYearMonth-01")
        .where(FieldPath.documentId,
            isLessThanOrEqualTo: "$currentYearMonth-31")
        .get();

    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      switch (data['mood']) {
        case 0:
          num_Espresso++;
          break;
        case 1:
          num_Americano++;
          break;
        case 2:
          num_Macchiato++;
          break;
      }
    }
    int total = num_Espresso + num_Americano + num_Macchiato;
    if (total > 0) {
      setState(() {
        percentage_espresso =
            ((num_Espresso / total) * 100).toStringAsFixed(1) + "%";
        percentage_americano =
            ((num_Americano / total) * 100).toStringAsFixed(1) + "%";
        percentage_macchiato =
            ((num_Macchiato / total) * 100).toStringAsFixed(1) + "%";
      });
    }
    setState(() {});
  }

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
                                      value: num_Americano.toDouble(),
                                      color: Color(0xFAF1F1),
                                      radius: screenSize.width * 0.08,
                                      title: ''),
                                  PieChartSectionData(
                                      value: num_Macchiato.toDouble(),
                                      color: Color(0xFFD6E4F0),
                                      radius: screenSize.width * 0.08,
                                      title: ''),
                                  PieChartSectionData(
                                    value: num_Espresso.toDouble(),
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
                    Column(
                      children: [
                        MoodCoffee(
                          image: 'assets/images/Espresso.png',
                          coffeetext: 'Espresso',
                          fontcolor: Color(0xFFE0E0E0),
                          borderColor: Color(0xFF757575),
                          percentage: percentage_espresso,
                        ),
                        MoodCoffee(
                          image: 'assets/images/Americano.png',
                          coffeetext: 'Americano',
                          fontcolor: Color(0xFFFAF1F1),
                          borderColor: Color(0xFF8E4917),
                          percentage: percentage_americano,
                        ),
                        MoodCoffee(
                          image: 'assets/images/Macchiato.png',
                          coffeetext: 'Macchiato',
                          fontcolor: Color(0xFFD6E4F0),
                          borderColor: Color(0xFF333258),
                          percentage: percentage_macchiato,
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
