// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_strings.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/custom_title.dart';
import '../../features/user/presentaion_layer/controller.dart';
import 'components/Selecting_tile.dart';
import 'components/selecting_row.dart';

class SelectingGroupMembersPage extends StatelessWidget {
  const SelectingGroupMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    //  GroupController groupController = Get.find<GroupController>();

    return Scaffold(
        appBar:
            AppBar(title: const CustomTitle(text: AppStrings.selectMembers)),
        body: Obx(() {
          List<CustomUser> customUusers =
              userController.model.value.customUsers;

          if (customUusers == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (customUusers.isEmpty) {
            return const Center(
              child: CustomText(text: AppStrings.noContacts),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  const SelecetingRow(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: customUusers.length,
                      itemBuilder: (context, index) {
                        return SelectingTile(index: index);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }));
  }
}
