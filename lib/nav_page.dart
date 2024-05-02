import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:rest_note/nav_bar.dart';
<<<<<<< HEAD
import 'package:rest_note/screens/diary/diary_main.dart';
=======
>>>>>>> db1b6cdb24cc6e7f05e240b78190ebf0c883a982
import 'package:rest_note/screens/likes/like_page.dart';
import 'package:rest_note/screens/location/location_main.dart';
import 'package:rest_note/screens/recommended/recommend_main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTabIndex = 1;

  final List<Widget> _bodyPage = <Widget>[
    LocationPage(),
<<<<<<< HEAD
    DiaryMainPage(),
=======
    RecommendedMain(),
>>>>>>> db1b6cdb24cc6e7f05e240b78190ebf0c883a982
    LikesMain(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentTabIndex,
          children: _bodyPage,
        ),
        bottomNavigationBar: MainNavigationBar(
          currentTabIndex: currentTabIndex,
          onTap: (index) {
            if (currentTabIndex == 0 && index == 0) {}
            setState(() {
              currentTabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
