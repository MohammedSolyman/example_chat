import 'package:flutter/material.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_text.dart';
import '../profile_image.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
    required this.currentUser,
  });

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        child: Column(
      children: [
        ProfileImage(isGroup: false, user: currentUser),
        CustomText(text: currentUser.name!),
        CustomText(text: currentUser.email),
      ],
    ));
  }
}
