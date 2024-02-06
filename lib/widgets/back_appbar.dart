import 'package:flutter/material.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBar({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // 기본 AppBar 높이

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            SizedBox(width: screenSize.width * 0.44),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * 0.07),
              child: const Icon(Icons.settings),
            ),
            Padding(
              padding: EdgeInsets.only(right: screenSize.width * 0.07),
              child: const Icon(Icons.notifications),
            ),
            const Icon(Icons.person_outline),
          ],
        ));
  }
}
