import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/tile_image.dart';
import '../../../../features/group/data_layer/model.dart';
import '../../../../features/group/presentaion_layer/group_controller.dart';
import '../../../chat_page/chat_page.dart';

class HomePageGroupTile extends StatelessWidget {
  const HomePageGroupTile({required this.group, super.key});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    // AuthController authController = Get.find<AuthController>();
    GroupController groupController = Get.find<GroupController>();

    return Card(
      child: ListTile(
        leading: TileImage(image: group.groupImage!, isGroup: true),
        title: Text(group.groupName),
        onTap: () async {
          groupController.assignCurrentGroup(group);
          Get.to(() => ChatPage(roomId: group.groupId!, isGroup: true));
        },
      ),
    );
  }
}
