import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.isEmail,
      required this.controller,
      this.hintText});
  final String? hintText;
  final TextEditingController controller;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: (String? x) {
        if (isEmail) {
          if (x == null) {
            return 'enter an email';
          } else {
            bool isvalidEmail = EmailValidator.validate(x);
            if (!isvalidEmail) {
              return 'it is bad formatted email';
            } else {
              return null;
            }
          }
        }
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
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
