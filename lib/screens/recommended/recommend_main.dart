import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:rest_note/models/product_model.dart';
import 'package:rest_note/widgets/back_appbar.dart';

class RecommendedMain extends StatefulWidget {
  @override
  State<RecommendedMain> createState() => _RecommendedMainState();
}

class _RecommendedMainState extends State<RecommendedMain> {
  late Future<List<ProductModel>> futureProducts;
  final List<ProductModel> productList = [];

  final ScrollController _scrollController = ScrollController();

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
            BackAppBar(), // BackAppBar를 사용하여 AppBar 내용을 정의
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.05),
              child: Text(
                'Recommended',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Color(0xFF302E2E),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _postListView(),
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
    return Consumer<ProductModel>(
      builder: (context, product, child) {
        double paddingValue = MediaQuery.of(context).size.width * 0.042;
        return InkWell(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     PageRouteBuilder(
          //       transitionDuration: const Duration(milliseconds: 400),
          //       pageBuilder: (context, animation, secondaryAnimation) =>
          //           ProductDetailPage(
          //         postId: product.postId,
          //       ),
          //       transitionsBuilder:
          //           (context, animation, secondaryAnimation, child) {
          //         var previousPageOffsetAnimation =
          //             Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
          //                 .chain(CurveTween(curve: Curves.decelerate))
          //                 .animate(animation);

          //         return SlideTransition(
          //           position: previousPageOffsetAnimation,
          //           child: ProductDetailPage(
          //             postId: product.postId,
          //           ),
          //         );
          //       },
          //     ),
          //   );
          // },
          child: Padding(
            padding: EdgeInsets.all(
              paddingValue,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/images/loading_logo.png", width: 90),
                _buildProductDetails(context, product),
              ],
            ),
          ),
        );
      },
    );
  }

  // // 게시물 내역 이미지
  // Widget _buildProductImage(BuildContext context, ProductModel product) {
  //   double size = MediaQuery.of(context).size.width * 0.28;
  //   double paddingValue = MediaQuery.of(context).size.width * 0.042;

  //   return Padding(
  //     padding: EdgeInsets.only(
  //       right: paddingValue,
  //     ),
  //     child: Container(
  //       width: size,
  //       height: size,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(
  //           strokeAlign: BorderSide.strokeAlignInside,
  //           color: const Color(0xffF1F1F1),
  //           width: 0.5,
  //         ),
  //       ),
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(8),
  //         child: imageCache.containsKey(product.representativePhotoId)
  //             ? Image.network(
  //               'assets/images/loading_logo.png',
  //                 fit: BoxFit.cover,
  //                 errorBuilder: (BuildContext context, Object exception,
  //                     StackTrace? stackTrace) {
  //                   return Image.asset(
  //                     "assets/images/loading_logo.png",
  //                     width: 90,
  //                     fit: BoxFit.cover,
  //                   );
  //                 },
  //               )
  //             : product.representativePhotoId == 0
  //                 ? Image.asset(
  //                     "assets/images/loading_logo.png",
  //                     width: 90,
  //                     fit: BoxFit.cover,
  //                   )
  //                 : FutureBuilder<Response>(
  //                     future:
  //                         apiService.loadPhoto(product.representativePhotoId),
  //                     builder: (context, snapshot) {
  //                       if (snapshot.connectionState ==
  //                           ConnectionState.waiting) {
  //                         return const Center(
  //                           child: CircularProgressIndicator(),
  //                         );
  //                       } else if (snapshot.hasError) {
  //                         return Image.asset(
  //                           "assets/images/sample.png",
  //                           width: 90,
  //                           errorBuilder: (BuildContext context,
  //                               Object exception, StackTrace? stackTrace) {
  //                             return Image.asset(
  //                               "assets/images/sample.png",
  //                               width: 90,
  //                               fit: BoxFit.cover,
  //                             );
  //                           },
  //                         );
  //                       } else if (snapshot.data == null) {
  //                         return Image.asset(
  //                           '/assets/images/sample.png',
  //                           fit: BoxFit.cover,
  //                         );
  //                       } else if (snapshot.hasData) {
  //                         Map<String, dynamic> data = snapshot.data!.data;
  //                         String imageUrl = data["url"];
  //                         imageCache[product.representativePhotoId] = imageUrl;
  //                         return Image.network(
  //                           imageUrl,
  //                           fit: BoxFit.cover,
  //                         );
  //                       } else {
  //                         return Image.asset(
  //                           "assets/images/sample.png",
  //                           fit: BoxFit.cover,
  //                         );
  //                       }
  //                     },
  //                   ),
  //       ),
  //     ),
  //   );
  // }

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productList.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF302E2E),
          ),
        ),
        Text(
          productList.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF302E2E),
          ),
        ),
      ],
    );
  }
}
