import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/assets_paths.dart';
import '../../core/models/user_model.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../core/dependency_injection/dependency_injection.dart' as di;
import '../../features/user/presentaion_layer/controller.dart';
import 'components/contacts_view.dart';
import 'components/groups_view.dart';
import 'components/my_tab.dart';
import 'components/top_row.dart';
import 'components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.currentUser, super.key});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    GroupController groupController = Get.put(di.sl<GroupController>());

    userController.getUsersGenerateCustomUsers(currentUserId: currentUser.id!);
    groupController.getAllGroupsFunction();

    return Scaffold(
        endDrawer: MyDrawer(currentUser: currentUser),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AssetsPaths.background01,
                  ),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const TopRow(),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(labelColor: Colors.red, tabs: [
                          MyTab(text: AppStrings.contacts),
                          MyTab(text: AppStrings.groups),
                        ]),
                        Expanded(
                          child: TabBarView(children: [
                            ContactsView(currentUser: currentUser),
                            GroupsView(currentUser: currentUser),
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
