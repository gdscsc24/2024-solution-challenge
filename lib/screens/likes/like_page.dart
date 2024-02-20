import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:rest_note/models/product_model.dart';
import 'package:rest_note/screens/recommended/content_detail.dart';
import 'package:rest_note/widgets/back_appbar.dart';

class LikesMain extends StatefulWidget {
  @override
  State<LikesMain> createState() => _LikesMainState();
}

class _LikesMainState extends State<LikesMain> {
  late Future<List<ProductModel>> futureProducts;
  final List<ProductModel> productList = [];

  final ScrollController _scrollController = ScrollController();

  late List<bool> heartStatusList;
  String activeButton = 'activity';
  bool activityPage = false;
  @override
  void initState() {
    super.initState();
    _loadProductList('assets/lists.json');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
        productList.add(ProductModel.fromJson(item));
      }
      heartStatusList = List<bool>.filled(productList.length, false);
      setState(() {}); // 상태 갱신
    } catch (error) {
      print('Error loading product list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackAppBar(text: 'Bookmark'),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: screenSize.width * 0.03),
              ContentButton(
                buttonText: 'activity',
                onPressed: () {
                  _loadProductList('assets/activity.json');
                  setState(() {
                    activeButton = 'activity'; // 활성 버튼 변경
                    activityPage = true;
                    print(1);
                  });
                },
                isActive: activeButton == 'activity', // 활성 상태 체크
              ),
              ContentButton(
                buttonText: 'video',
                onPressed: () {
                  _loadProductList('assets/lists.json');
                  setState(() {
                    activeButton = 'video'; // 활성 버튼 변경
                    activityPage = false;
                    print(2);
                  });
                },
                isActive: activeButton == 'video', // 활성 상태 체크
              ),
              ContentButton(
                buttonText: 'music',
                onPressed: () {
                  _loadProductList('assets/music_lists.json');
                  setState(() {
                    activeButton = 'music'; // 활성 버튼 변경
                    activityPage = false;
                    print(3);
                  });
                },
                isActive: activeButton == 'music', // 활성 상태 체크
              ),
              ContentButton(
                buttonText: 'book',
                onPressed: () {
                  _loadProductList('assets/book_lists.json');
                  setState(() {
                    activeButton = 'book'; // 활성 버튼 변경
                    activityPage = false;
                    print(4);
                  });
                },
                isActive: activeButton == 'book', // 활성 상태 체크
              ),
            ],
          ),
          Expanded(
            child: activityPage ? _activitypostListView() : _postListView(),
          ),
        ],
      ),
    );
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

  Widget _activitypostListView() {
    if (productList.isEmpty) {
      return Center(
        child: Text('No products available'),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              children: [
                Text(
                  'Take action right now!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                ),
                Text(
                  'special recipes to make you feel happy ',
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 12.16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 2,
                  ),
                ),
                SizedBox(height: 15)
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: (productList.length + 1) ~/
                  2, // 한 줄에 두 개의 아이템을 표시하기 위해 itemCount를 조정합니다.
              itemBuilder: (context, rowIndex) {
                return Row(
                  children: [
                    // 첫 번째 아이템일 경우 CoffeeUpgrade 위젯을 반환합니다.
                    ChangeNotifierProvider<ProductModel>.value(
                      value: productList[
                          rowIndex * 2], // rowIndex에 맞는 인덱스를 계산하여 제품을 가져옵니다.
                      child: _activitypostCard(context),
                    ),
                    // 두 번째 아이템일 경우, 리스트의 끝을 넘어가지 않도록 체크합니다.
                    if ((rowIndex * 2 + 1) < productList.length)
                      ChangeNotifierProvider<ProductModel>.value(
                        value: productList[rowIndex * 2 +
                            1], // rowIndex에 맞는 인덱스를 계산하여 제품을 가져옵니다.
                        child: _activitypostCard(context),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _activitypostCard(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<ProductModel>(
      builder: (context, product, child) {
        double paddingValue = MediaQuery.of(context).size.width * 0.042;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ContentDetailPage(
                  contentId: product.contentId,
                  image: product.imageLink,
                  text: product.title,
                  description: product.description,
                  link: product.youtubeLink,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var previousPageOffsetAnimation =
                      Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                          .chain(CurveTween(curve: Curves.decelerate))
                          .animate(animation);

                  return SlideTransition(
                    position: previousPageOffsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingValue),
            child: Stack(
              children: [
                Container(
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.23,
                  decoration: ShapeDecoration(
                    color: Color(0xFF212121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
                ),
                Container(
                  width: screenSize.width * 0.38,
                  height: screenSize.height * 0.18,
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 155.0),
                  child: _activitybuildProductDetails(context, product),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _activitybuildProductTexts(ProductModel productList) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(screenSize.width * 0.01, 0, 0, 0),
      child: Container(
        width: screenSize.width * 0.35,
        height: screenSize.width * 0.03,
        child: Text(
          productList.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }

  Widget _activitybuildProductDetails(
      BuildContext context, ProductModel productList) {
    double height = MediaQuery.of(context).size.width * 0.2;
    return Expanded(
      child: SizedBox(
        height: height,
        child: _activitybuildProductTexts(productList),
      ),
    );
  }

  Widget _postCard(BuildContext context, int index) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<ProductModel>(
      builder: (context, product, child) {
        double paddingValue = MediaQuery.of(context).size.width * 0.042;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContentDetailPage(
                  contentId: product.contentId,
                  image: product.imageLink,
                  text: product.title,
                  description: product.description,
                  link: product.youtubeLink,
                ),
              ),
            );
          },
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
              IconButton(
                onPressed: () {
                  setState(() {
                    heartStatusList[index] = !heartStatusList[index];
                  });
                },
                icon: Icon(
                  heartStatusList[index]
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: heartStatusList[index] ? Colors.red : null,
                ),
              )
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

class ContentButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isActive;
  const ContentButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      required this.isActive})
      : super(key: key);

  @override
  _ContentButtonState createState() => _ContentButtonState();
}

class _ContentButtonState extends State<ContentButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.02),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            pressed = !pressed;
          });
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              widget.isActive ? Color(0xFFFAF1F1) : Color(0xFFD9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          minimumSize: Size(screenSize.width * 0.19, screenSize.height * 0.03),
        ),
        child: Text(
          widget.buttonText,
          style: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
