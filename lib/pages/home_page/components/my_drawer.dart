import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/assets_paths.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../features/auth/presentaion_layer/controller.dart';
import '../../../features/file/data_layer/model.dart';
import '../../../features/file/presentaion_layer/controller.dart';
import '../../../features/user/presentaion_layer/controller.dart';
import '../../sign_in_page/sign_in_page.dart';
import 'show_create_group_dialog.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    required this.currentUser,
    super.key,
  });

  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    FileController fileController = Get.find<FileController>();
    UserController userController = Get.find<UserController>();

    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    height: 65,
                    width: 65,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: currentUser.image == null
                        ? Image.asset(AssetsPaths.contact)
                        : CachedNetworkImage(
                            imageUrl: currentUser.image!,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                  ),
                ),
              ),
              CustomText(text: currentUser.name!),
              CustomText(text: currentUser.email),
            ],
          )),
          ListTile(
            leading: Icon(Icons.person),
            title: CustomText(text: AppStrings.updateProfileImage),
            onTap: () async {
              // open device directory to pick an image
              File? file = await fileController.pickFileFunction();

              if (file != null) {
                // if the user picked an image, prepare a file model
                FileModel fileModel = fileController.prepareProfileFile(
                    file: file, id: currentUser.id!, isGroup: false);

                // and upload this image to firebase storage
                String? imgUrl =
                    await fileController.createFileFunction(fileModel);

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
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const CustomText(text: AppStrings.createGroup),
            onTap: () async {
              //close the end drawer
              Scaffold.of(context).closeEndDrawer();

              // open (create group) dialog
              await showCreateGroupDialog(
                  context: context, currentUser: currentUser);
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const CustomText(text: AppStrings.signOut),
            onTap: () async {
              //sign out the current user.
              await authController.signOutFunction(context);

              //remove all previous routes and navigate to sign in page.
              Get.offAll(() => const SignInPage());
            },
          ),
        ],
      ),
    );
  }
}
