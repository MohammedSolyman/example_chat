import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text.dart';

class MyTab extends StatelessWidget {
  const MyTab({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(text: text, isSamll: true),
        ),
      ),
    );
  }
}
