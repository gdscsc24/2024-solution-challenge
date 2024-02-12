import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MainNavigationBar extends StatefulWidget {
  final int currentTabIndex;
  final Function(int) onTap;

  const MainNavigationBar({
    super.key,
    required this.currentTabIndex,
    required this.onTap,
  });

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(
              0xffBEBCBC,
            ),
            width: 0.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: widget.currentTabIndex,
        onTap: widget.onTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              activeIcon: Icon(Icons.location_on),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: ''),
        ],
      ),
    );
  }
}
