import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rest_note/models/test_model.dart';

import 'package:rest_note/screens/my_history.dart';
import 'package:rest_note/screens/settings/settings_main.dart';
import 'package:rest_note/screens/test/test_result.dart';

class TestMainPage extends StatefulWidget {
  TestMainPage({super.key});
  @override
  _TestMainPageState createState() => _TestMainPageState();
}

class _TestMainPageState extends State<TestMainPage> {
  final List<TestModel> productList = [];
  Map<int, int> selectedOptions = {};
  int calculateTotalScore() {
    return selectedOptions.values.fold(0, (sum, item) => sum + (item + 1));
  }

  void initState() {
    super.initState();
    _loadProductList('assets/test.json');
  }

  void setSelectedOption(int questionIndex, int value) {
    setState(() {
      selectedOptions[questionIndex] = value;
    });
  }

  Future<void> _loadProductList(String jsonFileName) async {
    try {
      // JSON 파일을 읽어옴
      String jsonString = await rootBundle.loadString('$jsonFileName');
      // JSON을 Map으로 디코딩
      List<dynamic> jsonData = json.decode(jsonString);
      productList.clear();
      // 각 항목을 ProductModel로 변환하여 productList에 추가
      for (var item in jsonData) {
        productList.add(TestModel.fromJson(item));
      }

      setState(() {}); // 상태 갱신
    } catch (error) {
      print('Error loading product list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Row(
          children: [
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.36),
                Padding(
                    padding: EdgeInsets.only(right: screenSize.width * 0.05),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()),
                          );
                        },
                        icon: Icon(Icons.settings))),
                Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.05),
                  child: const Icon(Icons.notifications),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHistoryPage()),
                      );
                    },
                    icon: Icon(Icons.person_outline_outlined)),
              ],
            ),
          ],
        )),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.05),
              Container(
                width: 393,
                height: 670,
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
                            'Center for Epidemiological \nStudies-Depression Scale (CES-D)',
                            style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Color(0xFF262522),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Text(
                            'The CES-D Depression Self-Assessment Test is designed to diagnose the degree of depression you subjectively feel in your daily life. Moodista provides effective solutions based on measurements of depressive mood, feelings of despair, loss of appetite, and sleep disorders. The questions below are about your condition over the past week.',
                            style: const TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF757575),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          const Text(
                            'Check how often it occurred during last week.',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF757575),
                            ),
                          ),
                          SizedBox(height: screenSize.width * 0.05),
                          Row(
                            children: [
                              SizedBox(width: screenSize.width * 0.1),
                              const Text(
                                'Question',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: screenSize.width * 0.16),
                              const Text(
                                'Rarely',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                '   At times',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                              const Text(
                                '    Often',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '  Frequently',
                                style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: screenSize.height * 0.38),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                              height: screenSize.height * 0.32,
                              child: _postListView()),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        ElevatedButton(
                          onPressed: () {
                            int totalScore = calculateTotalScore();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResultPage(totalScore: totalScore)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF333258),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Container(
                            width: screenSize.width * 0.2,
                            height: screenSize.height * 0.03,
                            alignment: Alignment.center,
                            child: Text(
                              'Submit',
                              style: const TextStyle(
                                fontFamily: 'Comfortaa',
                                color: Color(0xFFFFFFFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _postListView() {
    if (productList.isEmpty) {
      return Center(
        child: Text('No products available'),
      );
    } else {
      return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider<TestModel>.value(
            value: productList[index],
            child: Column(
              children: [
                _postCard(context, index),
              ],
            ),
          );
        },
        separatorBuilder: (context, i) {
          return const Divider(
            height: 1,
          );
        },
      );
    }
  }

  Widget _postCard(BuildContext context, int index) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<TestModel>(
      builder: (context, product, child) {
        double paddingValue = MediaQuery.of(context).size.width * 0.0;
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildProductDetails(context, product, index),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails(
      BuildContext context, TestModel product, int index) {
    double height = MediaQuery.of(context).size.width * 0.14;
    return Expanded(
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProductTexts(context, product, index),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTexts(
      BuildContext context, TestModel product, int index) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: screenSize.width * 0.4,
              child: Text(
                product.Question,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Color(0xFF757575),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List<Widget>.generate(
                4,
                (optionIndex) => Transform.scale(
                  scale: 0.7, // 크기 조절
                  child: Transform.translate(
                    offset: Offset(-5, 0), // X축으로 버튼 이동, 버튼 간 패딩을 시각적으로 줄임
                    child: Radio<int>(
                      value: optionIndex,
                      groupValue: selectedOptions[index],
                      onChanged: (value) {
                        setSelectedOption(index, value!);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
