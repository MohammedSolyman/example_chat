import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/pages/chat_page/chat_page.dart';
import '../../../features/auth/presentaion_layer/controller.dart';
import '../../constants/app_strings.dart';
import '../../models/user_model.dart';
import '../custom_text.dart';
import '../../../features/file/data_layer/model.dart';
import '../../../features/file/presentaion_layer/controller.dart';
import '../../../features/group/data_layer/model.dart';
import '../../../features/group/presentaion_layer/group_controller.dart';
import '../../../features/user/presentaion_layer/controller.dart';

class UpdateImageTile extends StatelessWidget {
  const UpdateImageTile({
    super.key,
    required this.isGroup,
  });

  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    FileController fileController = Get.find<FileController>();
    UserController userController = Get.find<UserController>();
    GroupController groupController = Get.find<GroupController>();
    AuthController authController = Get.find<AuthController>();

    String id = isGroup
        ? groupController.model.value.groupId
        : authController.model.value.currentUser!.id!;

    return ListTile(
      leading: const Icon(Icons.person),
      title: const CustomText(text: AppStrings.updateProfileImage),
      onTap: () async {
        // open device directory to pick an image
        File? file = await fileController.pickFileFunction();

        if (file != null) {
          // if the user picked an image, prepare a file model
          FileModel fileModel = fileController.prepareProfileFile(
              file: file, id: id, isGroup: isGroup);

          // and upload this image to firebase storage
          String? imgUrl = await fileController.createFileFunction(fileModel);

          if (imgUrl != null) {
            // if uploading was successful, add image url in user or group info
            if (isGroup) {
              GroupModel newModel = groupController.model.value.currentGroup!
                  .copyWith(groupImage: imgUrl);
              await groupController.updateGoup(
                  context: context, groupModel: newModel);

              //update current group
              groupController.assignCurrentGroup(newModel);

              Get.off(ChatPage(
                  roomId: groupController.model.value.currentGroup!.groupId!,
                  groupModel: groupController.model.value.currentGroup!,
                  currentUser: authController.model.value.currentUser!,
                  isGroup: true));
            } else {
              UserModel newModel = authController.model.value.currentUser!
                  .copyWith(image: imgUrl);
              userController.updateUserFunction(newModel);

              //update current group
              authController.assignCurrentUser(newModel);
            }
          }
        }
      },
    );
  }
}
