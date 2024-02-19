import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:rest_note/models/product_model.dart';
import 'package:rest_note/screens/recommended/content_detail.dart';
import 'package:rest_note/widgets/back_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendedMain extends StatefulWidget {
  @override
  State<RecommendedMain> createState() => _RecommendedMainState();
}

class _RecommendedMainState extends State<RecommendedMain> {
  late Future<List<ProductModel>> futureProducts;
  final List<ProductModel> productList = [];

  final ScrollController _scrollController = ScrollController();

  bool pressed = false;

  @override
  void initState() {
    super.initState();
    _loadProductList();
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadProductList() async {
    try {
      // JSON 파일을 읽어옴
      String jsonString = await rootBundle.loadString('assets/lists.json');
      // JSON을 Map으로 디코딩
      List<dynamic> jsonData = json.decode(jsonString);
      // 각 항목을 ProductModel로 변환하여 productList에 추가
      for (var item in jsonData) {
        productList.add(ProductModel.fromJson(item));
      }
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
            BackAppBar(text: 'Recommended'),
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
                    pressed = !pressed;
                  }),
              ContentButton(
                  buttonText: 'video',
                  onPressed: () {
                    pressed = !pressed;
                  }),
              ContentButton(
                  buttonText: 'music',
                  onPressed: () {
                    pressed = !pressed;
                  }),
              ContentButton(
                  buttonText: 'book',
                  onPressed: () {
                    pressed = !pressed;
                  })
            ],
          ),
          Expanded(
            child: _postListView(),
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
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: productList.length +
            1, // 제품 수에 1을 더하여 CoffeeUpgrade 위젯을 추가할 자리를 만듭니다.
        itemBuilder: (context, index) {
          // 첫 번째 아이템일 경우 CoffeeUpgrade 위젯을 반환합니다.
          if (index == 0) {
            return _CoffeeUpgrade();
          }
          // 나머지 경우에는 제품 카드를 반환합니다.
          return ChangeNotifierProvider<ProductModel>.value(
            value: productList[index - 1], // index - 1을 해서 제품 목록에 맞는 제품을 가져옵니다.
            child: _postCard(context),
          );
        },
      );
    }
  }

  Widget _postCard(BuildContext context) {
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
                  ),
                ),
                _buildProductDetails(context, product),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductDetails(BuildContext context, ProductModel productList) {
    double height = MediaQuery.of(context).size.width * 0.28;
    return Expanded(
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductTexts(productList),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTexts(ProductModel productList) {
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
                  productList.title,
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
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_outline))
            ],
          ),
          SizedBox(height: screenSize.height * 0.01),
          Text(
            productList.description,
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

  Widget _CoffeeUpgrade() {
    Size screenSize = MediaQuery.of(context).size;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return FutureBuilder<DocumentSnapshot>(
      future:
          _firestore.collection('users').doc(_auth.currentUser?.email).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        var userNickname = 'defaultNickname';
        if (snapshot.data != null && snapshot.data!.exists) {
          userNickname = snapshot.data!.get('nickname');
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(
              screenSize.width * 0.04,
              screenSize.height * 0.005,
              screenSize.width * 0.04,
              screenSize.height * 0.06),
          child: Container(
            width: screenSize.width * 0.89,
            height: screenSize.height * 0.2,
            decoration: ShapeDecoration(
              color: Color(0x7FF1F4D5),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(28.13),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.05,
                      vertical: screenSize.height * 0.024),
                  child: Text(
                    'For Here or to Go?',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(width: screenSize.width * 0.05),
                    Image.asset('assets/images/Espresso_Romano.png',
                        width: screenSize.width * 0.27),
                    SizedBox(width: screenSize.width * 0.035),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Espresso Romano',
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Color(0xFFFF7A5C),
                          ),
                        ),
                        Text(
                          "\n to upgrade $userNickname's mood!",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "\n refreshing taste from sugar and lemon",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContentButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const ContentButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

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
          backgroundColor: pressed ? Color(0xFFD9D9D9) : Color(0xFFFAF1F1),
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
