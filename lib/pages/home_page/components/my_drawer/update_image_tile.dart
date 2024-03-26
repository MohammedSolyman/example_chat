import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../features/file/data_layer/model.dart';
import '../../../../features/file/presentaion_layer/controller.dart';
import '../../../../features/user/presentaion_layer/controller.dart';

class UpdateImageTile extends StatelessWidget {
  const UpdateImageTile({
    super.key,
    required this.currentUser,
  });

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    FileController fileController = Get.find<FileController>();
    UserController userController = Get.find<UserController>();
    return ListTile(
      leading: const Icon(Icons.person),
      title: const CustomText(text: AppStrings.updateProfileImage),
      onTap: () async {
        // open device directory to pick an image
        File? file = await fileController.pickFileFunction();

        if (file != null) {
          // if the user picked an image, prepare a file model
          FileModel fileModel = fileController.prepareProfileFile(
              file: file, id: currentUser.id!, isGroup: false);

          // and upload this image to firebase storage
          String? imgUrl = await fileController.createFileFunction(fileModel);

          if (imgUrl != null) {
            // if uploading was successful, add image url in user info

            UserModel newModel = currentUser;
            newModel.image = imgUrl;
            userController.updateUserFunction(newModel);

            //and close the drawer
            Scaffold.of(context).closeEndDrawer();
          }
        }
      },
    );
  }
}
