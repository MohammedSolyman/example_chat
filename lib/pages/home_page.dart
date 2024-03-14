import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_strings.dart';
import '../core/widgets/custom_text.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/custom_title.dart';
import '../features/group/data_layer/model.dart';
import '../features/group/presentaion_layer/group_controller.dart';
import '../core/dependency_injection/dependency_injection.dart' as di;
import '../features/user/data_layer/model.dart';
import '../features/user/presentaion_layer/controller.dart';
import 'chat_page/chat_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.currentUser, super.key});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(di.sl<GroupController>());
    UserController userController = Get.find<UserController>();

    // userController.getHomePageInfo(currentUser.id!);
    userController.getUsersFromCantactsInfo(context);

    TextEditingController tecGroupName = TextEditingController();
    TextEditingController tecGroupDescription = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTitle(text: AppStrings.contacts),
            Row(
              children: [
                CustomText(
                  text: AppStrings.createGroup,
                  isSamll: true,
                ),
                IconButton(
                  onPressed: () async {
                    //1. define dialog
                    AlertDialog dialog = AlertDialog(
                      title: const Text(AppStrings.createGroup),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(AppStrings.addGroupName),
                          CustomTextField(
                            isEmail: false,
                            hintText: AppStrings.groupName,
                            controller: tecGroupName,
                            isPassword: false,
                          ),
                          const Text(AppStrings.addGroupDescription),
                          CustomTextField(
                            isEmail: false,
                            hintText: AppStrings.groupDescription,
                            controller: tecGroupDescription,
                            isPassword: false,
                          )
                        ],
                      ),
                      backgroundColor: Colors.green,
                      elevation: 20,
                      actions: [
                        TextButton(
                            onPressed: () {
                              // for test ONLY, you must edit the original group model (copyWith)
                              GroupModel groupModel = GroupModel(
                                  groupName: tecGroupName.text,
                                  groupId: 'R9fZTdk2Yw3cWIeJBpYO',
                                  groupDescription: tecGroupDescription.text);

                              groupController.updateGoup(
                                  context: context, groupModel: groupModel);
                            },
                            child: const CustomText(
                              text: AppStrings.cancel,
                              isSamll: true,
                            )),
                        TextButton(
                            onPressed: () {
                              //create  a group and assign  creating user as an admin
                              groupController.createGoup(
                                  adminId: currentUser.id,
                                  context: context,
                                  groupName: tecGroupName.text,
                                  groupDescription: tecGroupDescription.text);

                              //get the id of the created group
                              String groupId =
                                  groupController.model.value.groupId;

//add this group to user's groups list
                              userController.addGroupToUserFunction(
                                  user: currentUser, groupId: groupId);
                            },
                            child: const CustomText(
                                text: AppStrings.create, isSamll: true))
                      ],
                    );

                    //2. show dialog
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
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
                            thisUserId: currentUser.id!,
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
