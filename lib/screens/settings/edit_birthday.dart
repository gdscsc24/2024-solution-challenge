import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rest_note/widgets/back_appbar.dart';

class EditBirthdayPage extends StatefulWidget {
  EditBirthdayPage({super.key});
  @override
  _EditBirthdayPageState createState() => _EditBirthdayPageState();
}

class _EditBirthdayPageState extends State<EditBirthdayPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _updateBirthday() async {
    String? userEmail = _auth.currentUser?.email; // 현재 로그인한 유저의 이메일 가져오기
    String birthday = _controller.text; // TextField에서 입력한 생일 데이터

    if (userEmail != null && birthday.isNotEmpty) {
      try {
        await _firestore.collection('users').doc(userEmail).update({
          'birthday': birthday, // 'birthday' 필드 업데이트
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Birthday updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating birthday: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight * 2),
        child: BackAppBar(text: 'Edit birthday'),
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
              'Change your birthday',
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
                controller: _controller,
                onChanged: (value) {
                  if (value.length == 4 || value.length == 7) {
                    _controller.text = '$value/';
                    _controller.selection = TextSelection.collapsed(
                        offset: _controller.text.length);
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9/]')), //숫자와 / 입력가능
                  LengthLimitingTextInputFormatter(10), // 최대 길이 10
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.date_range_outlined),
                  hintText: 'YYYY / MM / DD',
                  hintStyle: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF757575),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.12,
                  ),
                  counterText: '', // counterText를 빈 문자열로 설정하여 힌트 텍스트에 맞춰서 입력됨
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.065),
            child: ElevatedButton(
              onPressed: () {
                _updateBirthday();
              },
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
}
