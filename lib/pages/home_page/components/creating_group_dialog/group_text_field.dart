import 'package:flutter/material.dart';
import 'package:my_cli_test/core/constants/app_strings.dart';

class GroupTextField extends StatelessWidget {
  const GroupTextField(
      {super.key,
      required this.controller,
      this.hintText,
      this.linesNumbers = 1});

  final String? hintText;
  final TextEditingController controller;
  final int linesNumbers;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: (String? x) {
        if (x!.isEmpty) {
          return AppStrings.noEmpty;
        } else {
          return null;
        }
      },
      controller: controller,
      minLines: linesNumbers,
      maxLines: linesNumbers,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        errorStyle: const TextStyle(color: Colors.white),
        fillColor: Colors.white,
        filled: true,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
