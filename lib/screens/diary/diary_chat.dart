import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_choose.dart';
import 'package:rest_note/screens/diary/diary_making.dart';
import 'package:rest_note/widgets/back_appbar_none.dart';
import 'package:rest_note/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:rest_note/constants/event_text.dart';
import 'package:rest_note/constants/event_color.dart';
<<<<<<< HEAD
import 'package:speech_to_text/speech_to_text.dart' as stt;
=======
>>>>>>> db1b6cdb24cc6e7f05e240b78190ebf0c883a982

class DiaryChatPage extends StatefulWidget {
  DiaryChatPage({super.key});
  @override
  _DiaryChatPageState createState() => _DiaryChatPageState();
}

class _DiaryChatPageState extends State<DiaryChatPage> {
  final TextEditingController _textController = TextEditingController();

  int index = 0;
  bool chat = false;
<<<<<<< HEAD

  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
=======
>>>>>>> db1b6cdb24cc6e7f05e240b78190ebf0c883a982
  Future<void> _saveTextToFirestore() async {
    String text =
        _textController.text.isEmpty ? "Plain text" : _textController.text;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    User? currentUser = FirebaseAuth.instance.currentUser;
    String userEmail = currentUser?.email ?? 'default_email';
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('datas')
        .doc(formattedDate);

    await documentReference.set({
      'text': text,
    }, SetOptions(merge: true)).then((_) {
      // 성공 메시지를 표시합니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Text saved successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      // 실패 메시지를 표시합니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save text'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

<<<<<<< HEAD
  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

=======
>>>>>>> db1b6cdb24cc6e7f05e240b78190ebf0c883a982
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BackAppBarNone(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.03),
                child: Text(
                  'Which event caused your feelings?',
                  style: const TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Column(
                children: [
                  for (var i = 0; i < eventTextList.length; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(eventTextList[i].length, (index) {
                        return EventButton(
                          event: eventTextList[i][index],
                          color: eventColorList[i][index], // 이벤트 색상 적용
                          onPressed1: () {
                            setState(() {
                              chat = true;
                            });
                            print('Selected event: ${eventTextList[i][index]}');
                          },
                        );
                      }),
                    ),
                  if (chat) ChatWidget()
                ],
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        ));
  }

  Widget ChatWidget() {
    @override
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(
              left: screenSize.width * 0.08, top: screenSize.height * 0.05),
          child: Container(
            width: screenSize.width * 0.53,
            height: screenSize.height * 0.08,
            decoration: BoxDecoration(
                color: Color(0xFFFFFBF2),
                borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.03),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Tell me more about your emotion.',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF403E39),
                  decoration: TextDecoration.underline, // 밑줄 추가
                  decorationColor: Color(0xFFE9E4D1), // 밑줄 색상 지정
                  decorationThickness: 2.0, // 밑줄 두께 지정
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.05),
        Padding(
          padding: EdgeInsets.only(left: screenSize.width * 0.31),
          child: Container(
            width: screenSize.width * 0.63,
<<<<<<< HEAD
            child: Text(
              _text,
=======
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                filled: true, // 배경색 적용
                fillColor: Color(0xFFFFFBF2), // 배경색 지정
                hintText: 'Write here...',
                hintStyle: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF403E39),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // 텍스트 필드의 모서리 둥글기 설정
                  borderSide: BorderSide.none, // 테두리 제거
                ),
              ),
>>>>>>> db1b6cdb24cc6e7f05e240b78190ebf0c883a982
              style: const TextStyle(
                fontFamily: 'Rubik',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF403E39),
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFFE9E4D1),
                decorationThickness: 2.0,
              ),
              maxLines: null,
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.01),
        Row(children: [
<<<<<<< HEAD
          SizedBox(width: screenSize.width * 0.44),
          ElevatedButton.icon(
            onPressed: _listen,
            icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none), // 상태에 따라 아이콘 변경
            label: Text(''), // 버튼 텍스트
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xFFFFFFFF),
              backgroundColor: Color(0xFF333258),
              minimumSize: Size(
                screenSize.width * 0.13,
                screenSize.height * 0.028,
              ),
            ),
          ),
=======
          SizedBox(width: screenSize.width * 0.74),
>>>>>>> db1b6cdb24cc6e7f05e240b78190ebf0c883a982
          ChatButton(
            text: 'Done',
            onPressed: () {
              _saveTextToFirestore().then((_) {
                // 성공적으로 저장 후에 다음 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiaryMakingPage()),
                );
              }).catchError((error) {
                // 오류 처리...
              });
            },
          ),
        ]),
      ]),
    );
  }
}

class ChatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  ChatButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFF333258),
        minimumSize: Size(
          screenSize.width * 0.17,
          screenSize.height * 0.028,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class EventButton extends StatelessWidget {
  final String event;
  final VoidCallback onPressed1;
  final Color color;

  EventButton(
      {required this.event, required this.onPressed1, required this.color});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ElevatedButton(
      onPressed: onPressed1,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: color,
        minimumSize: Size(
          screenSize.width * 0.1,
          screenSize.height * 0.028,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            event,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Comfortaa',
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
