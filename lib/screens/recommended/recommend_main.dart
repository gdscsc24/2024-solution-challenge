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
import 'package:intl/intl.dart';

class RecommendedMain extends StatefulWidget {
  @override
  State<RecommendedMain> createState() => _RecommendedMainState();
}

class _RecommendedMainState extends State<RecommendedMain> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int?> _getUserMood() async {
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('datas')
        .doc(formattedDate)
        .get();

    if (documentSnapshot.exists) {
      final mood = documentSnapshot.data()?['mood'];
      if (mood is int) {
        // mood가 int 타입인지 확인
        return mood;
      }
    }
    return null; // mood 값이 없거나 int 타입이 아닐 때 null 반환
  }

  Future<String> _getUserNickname() async {
    final userEmail = _auth.currentUser?.email; // 현재 로그인한 사용자의 이메일 가져오기
    if (userEmail == null) return 'defaultNickname'; // 사용자 이메일이 없다면 기본 닉네임 반환

    try {
      final userDoc = await _firestore.collection('users').doc(userEmail).get();
      if (userDoc.exists) {
        return userDoc.data()?['nickname'] ??
            'defaultNickname'; // 닉네임이 없을 경우 기본값 반환
      }
      return 'defaultNickname'; // 문서가 존재하지 않을 경우 기본값 반환
    } catch (e) {
      print('Error getting user nickname: $e');
      return 'defaultNickname'; // 오류 발생 시 기본값 반환
    }
  }

  late Future<List<ProductModel>> futureProducts;
  final List<ProductModel> productList = [];

  final ScrollController _scrollController = ScrollController();
  late List<bool> heartStatusList;
  bool pressed = false;

  String activeButton = 'activity';

  bool activityPage = true;

  @override
  void initState() {
    super.initState();
    _loadProductList('assets/activity.json');
  }

  @override
  void dispose() {
    // _scrollController.removeListener(_onScroll);
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
            child: _postCard(context, index),
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

  Widget _postCard(BuildContext context, int index) {
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
      BuildContext context, ProductModel productList, int index) {
    double height = MediaQuery.of(context).size.width * 0.28;
    return Expanded(
      child: SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductTexts(context, productList, index),
          ],
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

  Widget _buildProductTexts(
      BuildContext context, ProductModel productList, int index) {
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
              IconButton(
                onPressed: () {
                  setState(() {
                    heartStatusList[index - 1] = !heartStatusList[index - 1];
                  });
                },
                icon: Icon(
                  heartStatusList[index - 1]
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: heartStatusList[index - 1] ? Colors.red : null,
                ),
              )
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

  Widget _CoffeeUpgrade() {
    Size screenSize = MediaQuery.of(context).size;
    final List<String> imageUrls = [
      'assets/images/Espresso_Romano.png',
      'assets/images/Hazelnut_Americano.png',
      'assets/images/Vanilla_Latte.png',
    ];
    List<String> textList = [
      'Espresso Romano',
      'Hazelnut Americano',
      'Vanilla Latte'
    ];

    List<String> textdetailList = [
      'refreshing taste from sugar and lemon',
      '4 pumps of fragrant hazelnut syrup',
      'Smooth milk and sweet vanilla scent'
    ];
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([_getUserMood(), _getUserNickname()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final int moodIndex = snapshot.data?[0] ?? 0;
        final String userNickname = snapshot.data?[1] ?? 'defaultNickname';

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
                    Image.asset(imageUrls[moodIndex],
                        width: screenSize.width * 0.27),
                    SizedBox(width: screenSize.width * 0.035),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textList[moodIndex],
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
                          "\n " + textdetailList[moodIndex],
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
