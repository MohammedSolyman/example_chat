import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({required this.text, super.key});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 32,
        color: Colors.white,
        fontFamily: 'pacifico',
      ),
    );
  }
}
