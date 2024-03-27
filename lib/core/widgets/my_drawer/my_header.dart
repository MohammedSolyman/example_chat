import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/auth/presentaion_layer/controller.dart';
import '../../../features/group/presentaion_layer/group_controller.dart';
import '../custom_text.dart';
import 'profile_image.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
    required this.isGroup,
  });

  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    GroupController groupController = Get.find<GroupController>();

    String title = isGroup
        ? groupController.model.value.currentGroup!.groupName
        : authController.model.value.currentUser!.name!;

    String subTitle = isGroup
        ? groupController.model.value.currentGroup!.groupDescription
        : authController.model.value.currentUser!.email;

    return DrawerHeader(
        child: Column(
      children: [
        ProfileImage(isGroup: isGroup),
        CustomText(text: title),
        CustomText(text: subTitle),
      ],
    ));
  }
}
