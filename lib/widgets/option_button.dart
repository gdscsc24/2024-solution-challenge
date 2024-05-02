import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final String buttonSubText;

  const OptionButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.buttonSubText,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.01),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFAF1F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Container(
          width: screenSize.width * 0.85,
          height: screenSize.height * 0.1,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    buttonText,
                    style: const TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Color(0xFF000000),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(child: const Icon(Icons.arrow_forward_ios_outlined)),
                ],
              ),
              Text(
                buttonSubText,
                style: const TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Color(0xFF757575),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
