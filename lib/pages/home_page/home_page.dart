import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/assets_paths.dart';
import '../../features/auth/presentaion_layer/controller.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../features/user/presentaion_layer/controller.dart';
import 'components/contacts_view/contacts_view.dart';
import 'components/groups_view/groups_view.dart';
import 'components/my_tab.dart';
import 'components/top_row.dart';
import '../../core/widgets/my_drawer/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    GroupController groupController = Get.find<GroupController>();
    AuthController authController = Get.find<AuthController>();

    String currentUserId = authController.model.value.currentUser!.id!;
    userController.getUsersGenerateCustomUsers(currentUserId: currentUserId);
    groupController.getGroupsFunction(currentUserId: currentUserId);

    return Scaffold(
        endDrawer: const MyDrawer(isGroup: false),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetsPaths.background01),
                  fit: BoxFit.cover)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TopRow(),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(labelColor: Colors.red, tabs: [
                          MyTab(text: AppStrings.contacts),
                          MyTab(text: AppStrings.groups),
                        ]),
                        Expanded(
                          child: TabBarView(children: [
                            ContactsView(),
                            GroupsView(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
