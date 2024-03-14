import 'package:flutter/material.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_title.dart';

AppBar chatAppBar({required String title, required String subtitle}) {
  return AppBar(
      title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomTitle(text: title),
      CustomText(
        text: subtitle,
        isSamll: true,
      )
    ],
  ));
}
