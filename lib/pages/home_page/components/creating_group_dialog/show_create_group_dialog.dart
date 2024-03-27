import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../features/auth/presentaion_layer/controller.dart';
import '../../../../features/group/presentaion_layer/group_controller.dart';
import '../../../../features/user/presentaion_layer/controller.dart';
import '../../../selecting_group_members/selecting_group_members.dart';
import 'group_text_field.dart';

showCreateGroupDialog({required BuildContext context}) async {
  GroupController groupController = Get.find<GroupController>();
  UserController userController = Get.find<UserController>();
  AuthController authController = Get.find<AuthController>();

  TextEditingController tecGroupName = TextEditingController();
  TextEditingController tecGroupDescription = TextEditingController();

  GlobalKey<FormState> myKey = GlobalKey<FormState>();
  //1. define dialog
  AlertDialog dialog = AlertDialog(
    title: const Align(
        alignment: Alignment.center, child: Text(AppStrings.createGroup)),
    content: Form(
      key: myKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.addGroupName,
            ),
          ),
          GroupTextField(
            controller: tecGroupName,
            hintText: AppStrings.groupName,
          ),
          const SizedBox(height: 10),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(AppStrings.addGroupDescription)),
          GroupTextField(
            controller: tecGroupDescription,
            hintText: AppStrings.groupDescription,
            linesNumbers: 3,
          ),
        ],
      ),
    ),
    backgroundColor: Theme.of(context).primaryColorLight,
    elevation: 20,
    actions: [
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: const CustomText(
            text: AppStrings.cancel,
            isSamll: true,
          )),
      TextButton(
          onPressed: () async {
            bool isValid = myKey.currentState!.validate();
            if (isValid) {
              //ONLY if the fields are NOT empty
              //create  a group and assign  creating user as an admin
              await groupController.createGoup(
                  adminId: authController.model.value.currentUser!.id!,
                  context: context,
                  groupName: tecGroupName.text,
                  groupDescription: tecGroupDescription.text);

              //get the id of the created group
              String groupId = groupController.model.value.groupId;

              //add this group to user's groups list
              await userController.addGroupToUserFunction(
                  user: authController.model.value.currentUser!,
                  groupId: groupId);

              // close the dialog
              Get.back();

              //go to selecting groups members
              Get.to(() => const SelectingGroupMembersPage());
            }
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
