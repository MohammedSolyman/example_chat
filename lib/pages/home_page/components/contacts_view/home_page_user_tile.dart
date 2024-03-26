import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/models/user_model.dart';
import '../../../../features/user/presentaion_layer/controller.dart';
import '../../../chat_page/chat_page.dart';
import '../profile_image.dart';

class HomePageUserTile extends StatelessWidget {
  const HomePageUserTile(
      {required this.currentUser, required this.user, super.key});

  final UserModel user;
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return Card(
      child: ListTile(
        leading: ProfileImage(user: user),
        title: Text(user.name!),
        onTap: () async {
          String roomId = userController.generateRoomId(
              senderId: currentUser.id!, recieverId: user.id!);
          Get.to(() => ChatPage(
              roomId: roomId,
              currentUser: currentUser,
              otherUser: user,
              isGroup: false));
        },
      ),
    );
  }
}
