import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/user/data_layer/model.dart';
import '../../../features/user/presentaion_layer/controller.dart';
import '../../chat_page/chat_page.dart';

class HomePageUserTile extends StatelessWidget {
  const HomePageUserTile({required this.user, super.key});

  final UserModel user;
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(user.name![0], textAlign: TextAlign.center),
        ),
        title: Text(user.name!),
        onTap: () async {
          String roomId = userController.generateRoomId(user.id!);
          Get.to(() => ChatPage(
              roomId: roomId,
              thisUserId: userController.model.value.currentUser!.id!,
              otherUser: user,
              isGroup: false));
        },
      ),
    );
  }
}
