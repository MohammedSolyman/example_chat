import 'package:flutter/material.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_title.dart';

AppBar chatAppBar(UserModel otherUser) {
  return AppBar(
      title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomTitle(text: otherUser.name!),
      CustomText(
        text: otherUser.email,
        isSamll: true,
      )
    ],
  ));
}
