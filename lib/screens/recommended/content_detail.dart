import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rest_note/widgets/back_appbar.dart';

class ContentDetailPage extends StatefulWidget {
  final int? contentId;

  const ContentDetailPage({
    Key? key,
    this.contentId,
  }) : super(key: key);

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
    return Scaffold();
  }
}
