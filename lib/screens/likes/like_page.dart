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
            BackAppBar(text: 'Bookmark'), // BackAppBar를 사용하여 AppBar 내용을 정의
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

  // 게시물 리스트 위젯
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
            child: _postCard(context),
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

  // 게시물 리스트에서 게시물 하나에 대한 위젯
  Widget _postCard(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<ProductModel>(
      builder: (context, productList, child) {
        double paddingValue = MediaQuery.of(context).size.width * 0.042;
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ContentDetailPage(
                  contentId: 1,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  var previousPageOffsetAnimation =
                      Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                          .chain(CurveTween(curve: Curves.decelerate))
                          .animate(animation);

                  return SlideTransition(
                    position: previousPageOffsetAnimation,
                    child: ContentDetailPage(
                      contentId: 1,
                    ),
                  );
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(
              paddingValue,
            ),
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
                  child: Image.asset(
                    "assets/images/loading_logo.png",
                  ),
                ),
                _buildProductDetails(context, productList),
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
