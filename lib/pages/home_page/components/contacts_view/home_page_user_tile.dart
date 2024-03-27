import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/tile_image.dart';
import '../../../../features/auth/presentaion_layer/controller.dart';
import '../../../../features/user/presentaion_layer/controller.dart';
import '../../../chat_page/chat_page.dart';

class HomePageUserTile extends StatelessWidget {
  const HomePageUserTile({required this.user, super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    AuthController authController = Get.find<AuthController>();

    return Card(
      child: ListTile(
        leading: TileImage(image: user.image!, isGroup: false),
        title: Text(user.name!),
        onTap: () async {
          String roomId = userController.generateRoomId(
              senderId: authController.model.value.currentUser!.id!,
              recieverId: user.id!);
          Get.to(
              () => ChatPage(roomId: roomId, otherUser: user, isGroup: false));
        },
      ),
    );
  }
}
