import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/show_my_dialoge.dart';
import '../../../features/group/presentaion_layer/group_controller.dart';
import '../../../features/user/presentaion_layer/controller.dart';

class SelecetingRow extends StatelessWidget {
  const SelecetingRow({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    GroupController groupController = Get.find<GroupController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  userController.makeAll(true);
                },
                child: const CustomText(
                  text: AppStrings.selectAll,
                  isSamll: true,
                )),
            TextButton(
                onPressed: () {
                  userController.makeAll(false);
                },
                child: const CustomText(
                    text: AppStrings.unSelectAll, isSamll: true)),
          ],
        ),
        IconButton(
            onPressed: () async {
              List<String> selectedIds = userController.getSelectedIds();

              if (selectedIds.isEmpty) {
                showMyDialog(
                    context: context,
                    msg: AppStrings.selectUserAtLeast,
                    isSuccess: false);
              } else {
                await groupController.addUsersToGroupFunction(
                    selectedIds, groupController.model.value.groupId);
                Get.back();
              }
            },
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ))
      ],
    );
  }
}
