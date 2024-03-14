// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_strings.dart';
import '../../core/dependency_injection/dependency_injection.dart' as di;
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/custom_title.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../features/user/data_layer/model.dart';
import '../../features/user/presentaion_layer/controller.dart';
import 'components/Selecting_tile.dart';
import 'components/selecting_row.dart';

class SelectingGroupMembersPage extends StatelessWidget {
  const SelectingGroupMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(di.sl<UserController>());
    GroupController groupController = Get.put(di.sl<GroupController>());

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

                        // Card(
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       backgroundColor: Colors.red,
                        //       child: Text(users[index].name![0],
                        //           textAlign: TextAlign.center),
                        //     ),
                        //     title: Text(users[index].name!),

                        //     onLongPress: () {
                        //       selectedMemebersIds.add(users[index].id!);
                        //     },

                        //     // onTap: () async {
                        //     //   String roomId =
                        //     //       userController.generateRoomId(users[index].id!);
                        //     //   Get.to(() => ChatPage(
                        //     //       roomId: roomId,
                        //     //       thisUserId: currentUser.id!,
                        //     //       otherUser: users[index],
                        //     //       isGroup: false));
                        //     //  },
                        //   ),
                        // );
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
