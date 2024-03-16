import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/assets_paths.dart';
import '../../../core/models/user_model.dart';
import '../../../features/group/data_layer/model.dart';
import '../../chat_page/chat_page.dart';

class HomePageGroupTile extends StatelessWidget {
  const HomePageGroupTile(
      {required this.currentUser, required this.group, super.key});

  final GroupModel group;
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
//    UserController userController = Get.find<UserController>();

    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          foregroundImage: AssetImage(AssetsPaths.group),
        ),
        title: Text(group.groupName),
        onTap: () async {
          Get.to(() => ChatPage(
              roomId: group.groupId!,
              groupModel: group,
              currentUser: currentUser,
              isGroup: true));

          // String roomId = userController.generateRoomId(group.groupName.id!);
          // Get.to(() => ChatPage(
          //     roomId: roomId,
          //     thisUserId: userController.model.value.currentUser!.id!,
          //     otherUser: user,
          //     isGroup: false));
        },
      ),
    );
  }
}
