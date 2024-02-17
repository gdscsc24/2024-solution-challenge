import 'package:flutter/material.dart';

import 'package:rest_note/widgets/back_appbar.dart';
import 'package:rest_note/widgets/submit_button.dart';

class EditNicknamePage extends StatefulWidget {
  EditNicknamePage({super.key});
  @override
  _EditNicknamePageState createState() => _EditNicknamePageState();
}

class _EditNicknamePageState extends State<EditNicknamePage> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 2),
        child: BackAppBar(text: 'Edit nickname'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: screenSize.height * 0.04,
                left: screenSize.width * 0.067,
                bottom: screenSize.height * 0.04),
            child: const Text(
              'How can I call you?',
              style: TextStyle(
                fontFamily: 'Comfortaa',
                color: Color(0xFF403E39),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: screenSize.width * 0.067),
            child: SizedBox(
              width: screenSize.width * 0.86,
              height: screenSize.height * 0.06,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  hintText: 'nickname',
                  hintStyle: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333258),
                  ),
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: screenSize.width * 0.12),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.065),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF333258),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Container(
                width: screenSize.width * 0.86,
                height: screenSize.height * 0.06,
                alignment: Alignment.center,
                child: Text(
                  'Done',
                  style: const TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Color(0xffFFFFFF),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
