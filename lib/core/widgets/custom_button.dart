import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.myFunc,
  });

  final String text;
  final Function myFunc;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        myFunc();
      },
      child: Text(text),
    );
  }
}
