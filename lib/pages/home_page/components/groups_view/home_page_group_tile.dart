import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/assets_paths.dart';
import '../../../../core/models/user_model.dart';
import '../../../../features/group/data_layer/model.dart';
import '../../../chat_page/chat_page.dart';
import '../profile_image.dart';

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
        leading: ProfileImage(isGroup: true, group: group),
        title: Text(group.groupName),
        onTap: () async {
          Get.to(() => ChatPage(
              roomId: group.groupId!,
              groupModel: group,
              currentUser: currentUser,
              isGroup: true));
        },
      ),
    );
  }
}
