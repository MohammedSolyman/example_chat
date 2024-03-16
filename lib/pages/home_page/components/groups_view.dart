import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../features/group/data_layer/model.dart';
import '../../../features/group/presentaion_layer/group_controller.dart';
import 'home_page_group_tile.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({required this.currentUser, super.key});

  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.find<GroupController>();

    return Obx(() {
      List<GroupModel>? groups = groupController.model.value.allGroups;
      if (groups == null) {
        return const Center(child: CircularProgressIndicator());
      } else if (groups.isEmpty) {
        return const Center(
          child: CustomText(text: AppStrings.noGroups),
        );
      } else {
        return Center(
          child: ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return HomePageGroupTile(
                  currentUser: currentUser, group: groups[index]);
            },
          ),
        );
      }
    });
  }
}
