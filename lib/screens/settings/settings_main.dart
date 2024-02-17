import 'package:flutter/material.dart';
import 'package:rest_note/screens/settings/edit_profile.dart';

import 'package:rest_note/widgets/back_appbar.dart';
import 'package:rest_note/widgets/popup.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackAppBar(text: 'Settings'), // BackAppBar를 사용하여 AppBar 내용을 정의
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenSize.height * 0.03),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: screenSize.width * 0.31,
                height: screenSize.width * 0.31,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/user_profile.png', // 이미지의 asset 경로
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
          const Text(
            'Nickname',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              fontSize: 33,
              color: Color(0xFF262522),
            ),
          ),
          const Text(
            'email',
            style: TextStyle(
              fontFamily: 'Rubik-Regular',
              fontWeight: FontWeight.w400,
              fontSize: 22,
              color: Color(0xFF403E39),
            ),
          ),
          SizedBox(height: screenSize.height * 0.02),
          RoutingButton(
              text: 'Edit Profile',
              icon: Icons.person_outline,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              }),
          RoutingButton(
              text: 'Notifications',
              icon: Icons.notifications_none,
              onPressed: () {}),
          RoutingButton(
              text: 'Terms of service',
              icon: Icons.description_outlined,
              onPressed: () {}),
          RoutingButton(
              text: 'Privacy Policy',
              icon: Icons.description_outlined,
              onPressed: () {}),
          RoutingButton(
              text: 'Log out',
              icon: Icons.logout,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyPopup(
                        text: 'Log out of account?', buttonText: 'Log out');
                  },
                );
              })
        ],
      ),
    );
  }
}

class RoutingButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  RoutingButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        // vertical: 8,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFE9E4D1)))),
          child: SizedBox(
            width: screenSize.width * 0.93,
            height: screenSize.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  icon,
                  color: const Color(0xFF403239),
                  size: 24,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Color(0xFF403E39),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Color(0xFF403239),
                  size: 24,
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
