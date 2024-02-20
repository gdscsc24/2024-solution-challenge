import 'package:flutter/material.dart';
import 'package:rest_note/screens/diary/diary_chat.dart';
import 'package:rest_note/widgets/back_appbar.dart';
import 'package:rest_note/widgets/back_appbar_none.dart';
import 'package:rest_note/widgets/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class DiaryCoffeePage extends StatefulWidget {
  DiaryCoffeePage({super.key});
  @override
  _DiaryCoffeePageState createState() => _DiaryCoffeePageState();
}

class _DiaryCoffeePageState extends State<DiaryCoffeePage> {
  void saveMoodToFirestore(int moodIndex) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userEmail = user.email; // Get the current user's email
      final dateId = DateFormat('yyyy-MM-dd')
          .format(DateTime.now()); // Format the date as '2024-02-19'
      final documentReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail) // Use the user's email as the document ID
          .collection('datas')
          .doc(dateId); // Use the formatted date as the document ID

      await documentReference.set(
          {
            'mood': moodIndex, // Save the mood index
          },
          SetOptions(
              merge:
                  true)); // Merge the data with existing document to avoid overwriting
    }
  }

  final List<String> imageUrls = [
    'assets/images/Espresso.png',
    'assets/images/Americano.png',
    'assets/images/Macchiato.png',
  ];
  List<String> coffeeList = ['Espresso', 'Americano', 'Macchiato'];
  List<String> tasteList = ['bitter', 'balanced', 'sweet'];
  double _currentSliderValue = 0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: BackAppBarNone(),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.1),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: screenSize.height * 0.028),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'How do you',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF302E2E),
                          ),
                        ),
                        Text(
                          ' feel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color:
                                Color(0xFFFF7A5C), // feel 텍스트의 색상을 원하는 색상으로 설정
                          ),
                        ),
                        Text(
                          ' now?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF302E2E),
                          ),
                        ),
                      ])),
              const Text(
                'Recommend a coffee that matches your mood today',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF302E2E),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Image.asset(
                imageUrls[index],
                width: screenSize.width * 0.38,
              ),
              Text(
                coffeeList[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF302E2E),
                ),
              ),
              Text(
                tasteList[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFF7A5C),
                ),
              ),
              Slider(
                value: _currentSliderValue,
                min: 0.0,
                max: 3.0,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    if (value < 1) {
                      index = 0; //부정
                    } else if (value < 2 && value > 1) {
                      index = 1; //중립
                    } else {
                      index = 2; //긍정
                    }
                  });
                },
                activeColor: const Color(0xFF8E4917),
                inactiveColor: const Color(0xFFF2F4D6),
                thumbColor: Colors.white,
              ),
              SizedBox(height: screenSize.height * 0.04),
              SubmitButton(
                onPressed: () {
                  saveMoodToFirestore(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiaryChatPage()),
                  );
                },
                buttonText: 'Next',
              ),
            ],
          ),
        ));
  }
}
