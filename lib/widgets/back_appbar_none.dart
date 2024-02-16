import 'package:flutter/material.dart';
import 'package:rest_note/screens/my_history.dart';
import 'package:rest_note/screens/settings/settings_main.dart';

class BackAppBarNone extends StatelessWidget implements PreferredSizeWidget {
  const BackAppBarNone({
    super.key,
  });

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
      title: Column(
        children: [
          Row(
            children: [
              SizedBox(width: screenSize.width * 0.37),
              Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.05),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()),
                        );
                      },
                      icon: Icon(Icons.settings))),
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.05),
                child: const Icon(Icons.notifications),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHistoryPage()),
                    );
                  },
                  icon: Icon(Icons.person_outline_outlined)),
            ],
          ),
        ],
      ),
    );
  }
}
