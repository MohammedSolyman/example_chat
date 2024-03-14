import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/custom_title.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../core/dependency_injection/dependency_injection.dart' as di;
import '../../features/user/data_layer/model.dart';
import '../../features/user/presentaion_layer/controller.dart';

class SelectingGroupMembersPage extends StatelessWidget {
  const SelectingGroupMembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> selectedMemebersIds = [];

    Get.put(di.sl<GroupController>());

    UserController userController = Get.put(di.sl<UserController>());
    userController.getUsersFromCantactsInfo(context);

    return Scaffold(
        appBar:
            AppBar(title: const CustomTitle(text: AppStrings.selectMembers)),
        body: Obx(() {
          List<UserModel>? users = userController.model.value.users;
          if (users == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (users.isEmpty) {
            return const Center(
              child: CustomText(text: AppStrings.noContacts),
            );
          } else {
            return Center(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(users[index].name![0],
                            textAlign: TextAlign.center),
                      ),
                      title: Text(users[index].name!),

                      onLongPress: () {
                        selectedMemebersIds.add(users[index].id!);
                      },

                      // onTap: () async {
                      //   String roomId =
                      //       userController.generateRoomId(users[index].id!);
                      //   Get.to(() => ChatPage(
                      //       roomId: roomId,
                      //       thisUserId: currentUser.id!,
                      //       otherUser: users[index],
                      //       isGroup: false));
                      //  },
                    ),
                  );
                },
              ),
            );
          }
        }));
  }
}
