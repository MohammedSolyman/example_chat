import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_title.dart';
import '../features/group/presentaion_layer/group_controller.dart';
import '../core/dependency_injection/dependency_injection.dart' as di;

import '../features/user/data_layer/model.dart';
import '../features/user/presentaion_layer/controller.dart';
import 'chat_page/chat_page.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({required this.currentUserId, super.key});

  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(di.sl<GroupController>());
    UserController userController = Get.put(di.sl<UserController>());

    userController.getContactsPageInfo(currentUserId);
    userController.getUsersFromCantactsInfo(context);

    return Scaffold(
        appBar: AppBar(
            title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTitle(text: AppStrings.contacts),
            // Row(
            //   children: [
            //     const CustomText(
            //       text: AppStrings.createGroup,
            //       isSamll: true,
            //     ),
            //     IconButton(
            //       onPressed: () async {
            //         //1. define dialog
            //         AlertDialog dialog = AlertDialog(
            //           title: const Text(AppStrings.createGroup),
            //           content: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               const Text(AppStrings.addName),
            //               CustomTextField(
            //                 isEmail: false,
            //                 controller: controller.model.value.groupTec,
            //                 isPassword: false,
            //               )
            //             ],
            //           ),
            //           backgroundColor: Colors.green,
            //           elevation: 20,
            //           actions: [
            //             TextButton(
            //                 onPressed: () {
            //                   groupController.renameGoup(context, 'nn');

            //                   //  controller.cancelGroup();
            //                 },
            //                 child: const CustomText(
            //                   text: AppStrings.cancel,
            //                   isSamll: true,
            //                 )),
            //             TextButton(
            //                 onPressed: () {
            //                   //    controller.createGroup();
            //                   groupController.createGoup(
            //                       adminId: currentUserId,
            //                       context: context,
            //                       groupName: 'my group');
            //                 },
            //                 child: const CustomText(
            //                     text: AppStrings.create, isSamll: true))
            //           ],
            //         );

            //         //2. show dialog
            //         await showDialog(
            //           context: context,
            //           builder: (context) {
            //             return dialog;
            //           },
            //         );
            //       },
            //       icon: const Icon(Icons.add),
            //     ),
            //   ],
            // ),
          ],
        )),
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
                      onTap: () async {
                        String roomId =
                            userController.generateRoomId(users[index].id!);
                        Get.to(() => ChatPage(
                            roomId: roomId,
                            thisUserId: currentUserId,
                            otherUser: users[index],
                            isGroup: false));
                      },
                    ),
                  );
                },
              ),
            );
          }
        }));
  }
}
