import 'package:flutter/material.dart';

showMyDialog(
    {required BuildContext context,
    required String msg,
    required bool isSuccess}) async {
  //1. define dialog
  AlertDialog dialog = AlertDialog(
    title: Text(msg),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    elevation: 20,
  );

  //2. show dialog
  await showDialog(
    context: context,
    builder: (context) {
      return dialog;
    },
  );
}
