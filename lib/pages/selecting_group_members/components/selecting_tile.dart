import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/assets_paths.dart';
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
          leading: const CircleAvatar(
            foregroundImage: AssetImage(AssetsPaths.contact),
          ),
          title: Text(userController.model.value.customUsers[index].user.name!),
          onLongPress: () {
            userController.toggleSelectivity(index);
          },
        ),
      );
    });
  }
}
