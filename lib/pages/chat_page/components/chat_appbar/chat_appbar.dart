import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../core/widgets/my_drawer/profile_image.dart';
import '../../../../features/group/presentaion_layer/group_controller.dart';
import '../../chat_image.dart';

AppBar chatAppBar(
    {required BuildContext context,
    UserModel? otherUser,
    required bool isGroup}) {
  GroupController groupController = Get.find<GroupController>();

  String title = isGroup
      ? groupController.model.value.currentGroup!.groupName
      : otherUser!.name!;
  String subtitle = isGroup
      ? groupController.model.value.currentGroup!.groupDescription
      : otherUser!.email;

  return AppBar(
    toolbarHeight: 100,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ChatImage(isGroup: isGroup, otherUser: otherUser),
            const SizedBox(width: 5),
            CustomTitle(text: title),
          ],
        ),
        CustomText(
          text: subtitle,
          isSamll: true,
        )
      ],
    ),
    actions: [
      Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.settings, size: 40, color: Colors.white)))
    ],
  );
}
