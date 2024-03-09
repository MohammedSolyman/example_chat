import 'package:flutter/material.dart';

import '../constants/light_colors.dart';

void showMySnackBar(
    {required BuildContext context,
    required String msg,
    required bool isSuccess}) {
  SnackBar snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: isSuccess ? LightColors.green : LightColors.red);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
