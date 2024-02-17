import 'package:flutter/material.dart';
import 'package:rest_note/screens/settings/edit_birthday.dart';
import 'package:rest_note/screens/settings/edit_nickname.dart';

import 'package:rest_note/widgets/back_appbar.dart';
import 'package:rest_note/widgets/popup.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 2),
        child: BackAppBar(text: 'Edit Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoutingButton(
              text: 'Edit nickname',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditNicknamePage()),
                );
              }),
          RoutingButton(
              text: 'Edit birthday',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditBirthdayPage()),
                );
              }),
          RoutingButton(
              text: 'Delete account',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyPopup(
                        text: 'Delete account?', buttonText: 'delete');
                  },
                );
              }),
        ],
      ),
    );
  }
}

class RoutingButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  RoutingButton({super.key, required this.text, required this.onPressed});

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
