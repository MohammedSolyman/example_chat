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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
