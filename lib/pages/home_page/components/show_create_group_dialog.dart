import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../features/group/data_layer/model.dart';
import '../../../features/group/presentaion_layer/group_controller.dart';
import '../../../features/user/presentaion_layer/controller.dart';

showCreateGroupDialog(BuildContext context) async {
  GroupController groupController = Get.find<GroupController>();
  UserController userController = Get.find<UserController>();

  TextEditingController tecGroupName = TextEditingController();
  TextEditingController tecGroupDescription = TextEditingController();

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
    backgroundColor: Theme.of(context).primaryColorLight,
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
          onPressed: () async {
            //create  a group and assign  creating user as an admin
            await groupController.createGoup(
                adminId: userController.model.value.currentUser!.id,
                context: context,
                groupName: tecGroupName.text,
                groupDescription: tecGroupDescription.text);

            //get the id of the created group
            String groupId = groupController.model.value.groupId;

            //add this group to user's groups list
            await userController.addGroupToUserFunction(
                user: userController.model.value.currentUser!,
                groupId: groupId);

            //TEST ONLY
            await groupController
                .addUsersToGroupFunction(['aaaaa', 'bbbbb'], groupId);
          },
          child: const CustomText(text: AppStrings.create, isSamll: true))
    ],
  );

  //2. show dialog
  await showDialog(
    context: context,
    builder: (context) {
      return dialog;
    },
  );
}
