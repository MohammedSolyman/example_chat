import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({required this.text, this.isSamll = false, super.key});

  final String text;
  final bool isSamll;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isSamll ? 15 : 20,
        color: Colors.white,
      ),
    );
  }
}
