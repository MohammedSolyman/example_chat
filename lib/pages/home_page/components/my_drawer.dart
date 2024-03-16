import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/assets_paths.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../features/auth/presentaion_layer/controller.dart';
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

    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: ListView(
        children: [
          DrawerHeader(
              child: Column(
            children: [
              SizedBox(
                  child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage(AssetsPaths.contact)),
                    shape: BoxShape.circle),
              )),
              CustomText(text: currentUser.name!),
              CustomText(text: currentUser.email),
            ],
          )),
          const ListTile(
            leading: Icon(Icons.person),
            title: CustomText(text: AppStrings.updateProfileImage),
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
