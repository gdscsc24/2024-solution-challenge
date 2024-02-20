import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rest_note/widgets/back_appbar.dart';

import 'package:url_launcher/url_launcher.dart';

class ContentDetailPage extends StatefulWidget {
  final int? contentId;
  final String image;
  final String text;
  final String description;
  final String link;

  const ContentDetailPage(
      {Key? key,
      this.contentId,
      required this.image,
      required this.text,
      required this.description,
      required this.link})
      : super(key: key);

  @override
  State<ContentDetailPage> createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends State<ContentDetailPage> {
  int _current = 0;

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
      body: Center(
        child: _buildProductDetail(context),
      ),
    );
  }

  Widget _buildProductDetail(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: screenSize.width * 0.13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height * 0.1),
            Container(
                width: screenSize.width * 0.72,
                height: screenSize.height * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    launch(widget.link);
                  },
                  child: Image.network(
                    // 네트워크 이미지 로드
                    widget.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 이미지 로드 실패 시 기본 이미지 반환
                      return Image.asset(
                        'assets/images/loading_logo.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.03),
              child: Container(
                width: screenSize.width * 0.72,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.01),
              child: Container(
                width: screenSize.width * 0.72,
                child: Text(
                  widget.description,
                  style: TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
