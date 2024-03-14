import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/group/data_layer/model.dart';
import '../../../features/user/presentaion_layer/controller.dart';
import '../../chat_page/chat_page.dart';

class HomePageGroupTile extends StatelessWidget {
  const HomePageGroupTile({required this.group, super.key});

  final GroupModel group;
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(group.groupName[0], textAlign: TextAlign.center),
        ),
        title: Text(group.groupName),
        onTap: () async {
          Get.to(() => ChatPage(
              roomId: group.groupId!,
              groupModel: group,
              thisUserId: userController.model.value.currentUser!.id!,
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
