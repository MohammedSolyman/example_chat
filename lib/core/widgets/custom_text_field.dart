import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.isEmail,
      required this.controller,
      this.hintText,
      required this.isPassword});
  final String? hintText;
  final TextEditingController controller;
  final bool isEmail;
  final bool isPassword;
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
      obscureText: isPassword ? true : false,
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
