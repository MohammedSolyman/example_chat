import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/tile_image.dart';
import '../../../../features/auth/presentaion_layer/controller.dart';
import '../../../../features/group/data_layer/model.dart';
import '../../../../features/group/presentaion_layer/group_controller.dart';
import '../../../chat_page/chat_page.dart';

class HomePageGroupTile extends StatelessWidget {
  const HomePageGroupTile({required this.group, super.key});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    GroupController groupController = Get.find<GroupController>();

    return Card(
      child: ListTile(
        leading: TileImage(image: group.groupImage!, isGroup: true),
        title: Text(group.groupName),
        onTap: () async {
          Get.to(() => ChatPage(
              roomId: group.groupId!,
              groupModel: group,
              currentUser: authController.model.value.currentUser!,
              isGroup: true));
        },
      ),
    );
  }
}
