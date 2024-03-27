import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/pages/chat_page/chat_page.dart';
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
    this.currentUser,
    this.groupModel,
    required this.isGroup,
  });

  final UserModel? currentUser;
  final GroupModel? groupModel;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    String id = isGroup ? groupModel!.groupId! : currentUser!.id!;

    FileController fileController = Get.find<FileController>();
    UserController userController = Get.find<UserController>();
    GroupController groupController = Get.find<GroupController>();

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
              GroupModel newModel = groupModel!.copyWith(groupImage: imgUrl);
              await groupController.updateGoup(
                  context: context, groupModel: newModel);

              Scaffold.of(context).closeEndDrawer();

              Get.off(ChatPage(
                  roomId: groupModel!.groupId!,
                  groupModel: groupModel,
                  currentUser: currentUser!,
                  isGroup: true));
            } else {
              UserModel newModel = currentUser!.copyWith(image: imgUrl);
              userController.updateUserFunction(newModel);
              //and close the drawer
              Scaffold.of(context).closeEndDrawer();
            }
          }
        }
      },
    );
  }
}
