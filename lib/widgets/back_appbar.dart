import 'package:flutter/material.dart';
import 'package:rest_note/screens/my_history.dart';
import 'package:rest_note/screens/settings/settings_main.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;

  const BackAppBar({
    super.key,
    required this.text,
  });

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // 기본 AppBar 높이

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          AppBar(
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
                        padding:
                            EdgeInsets.only(right: screenSize.width * 0.05),
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
                            MaterialPageRoute(
                                builder: (context) => MyHistoryPage()),
                          );
                        },
                        icon: Icon(Icons.person_outline_outlined)),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                    color: Color(0xFF302E2E),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.018),
                child: Container(
                  width: screenSize.width * 0.96,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.7,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
