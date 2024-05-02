import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_note/models/product_model.dart';

import 'package:rest_note/screens/my_history.dart';
import 'package:rest_note/screens/recommended/content_detail.dart';
import 'package:rest_note/screens/settings/settings_main.dart';

class CounselorMainPage extends StatefulWidget {
  CounselorMainPage({super.key});
  @override
  _CounselorMainPageState createState() => _CounselorMainPageState();
}

class _CounselorMainPageState extends State<CounselorMainPage> {
  final List<ProductModel> productList = [];
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
                SizedBox(width: screenSize.width * 0.23),
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
              Container(
                width: 347,
                height: 57,
                decoration: BoxDecoration(
                  color: Colors.white, // 배경색 설정
                  borderRadius: BorderRadius.circular(15), // 모서리 둥글기
                  border: Border.all(
                    color: Colors.grey, // 테두리 색상
                    width: 1.30, // 테두리 두께
                  ),
                ),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'find who you want',
                      hintStyle: const TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFBDBDBD),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: InputBorder.none),
                  style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF403E39),
                    decorationColor: Color(0xFFE9E4D1),
                    decorationThickness: 2.0,
                  ),
                  maxLines: null,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Container(
                width: 393,
                height: 600,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFFAF1F1), Colors.white],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                ),
                child: Stack(
                  children: [
                    Expanded(
                      child: _postListView(),
                    ),
                    Positioned(
                      left: 30,
                      top: 42,
                      child: Column(
                        children: [
                          Container(
                              width: screenSize.width * 0.31,
                              height: screenSize.width * 0.31,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/pro_5.png', // 이미지의 asset 경로
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ],
                      ),
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
          return ChangeNotifierProvider<ProductModel>.value(
            value: productList[index],
            child: _postCard(context, index),
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
    return Consumer<ProductModel>(
      builder: (context, product, child) {
        double paddingValue = MediaQuery.of(context).size.width * 0.042;
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: screenSize.width * 0.36,
                    height: screenSize.height * 0.1,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Image.network(
                      // 네트워크 이미지 로드
                      product.imageLink,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // 이미지 로드 실패 시 기본 이미지 반환
                        return Image.asset(
                          'assets/images/loading_logo.png',
                          fit: BoxFit.cover,
                        );
                      },
                    )),
                _buildProductDetails(context, product, index),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails(
      BuildContext context, ProductModel product, int index) {
    double height = MediaQuery.of(context).size.width * 0.28;
    return Expanded(
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductTexts(context, product, index),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTexts(
      BuildContext context, ProductModel product, int index) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(screenSize.width * 0.07, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: screenSize.width * 0.35,
                child: Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }
}
