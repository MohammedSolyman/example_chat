import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/user/presentaion_layer/controller.dart';

class SelectingTile extends StatelessWidget {
  const SelectingTile({required this.index, super.key});

  final int index;
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return Obx(() {
      return Card(
        color: userController.model.value.customUsers[index].isSelected
            ? Colors.cyan
            : Colors.blueGrey.shade400,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            child: Text(
                userController.model.value.customUsers[index].user.name![0],
                textAlign: TextAlign.center),
          ),
          title: Text(userController.model.value.customUsers[index].user.name!),
          onLongPress: () {
            userController.toggleSelectivity(index);
          },
          // onTap: () async {
          //   String roomId = userController.generateRoomId(user.id!);
          //   Get.to(() => ChatPage(
          //       roomId: roomId,
          //       thisUserId: userController.model.value.currentUser!.id!,
          //       otherUser: user,
          //       isGroup: false));
          // },
        ),
      );
    });
  }
}
