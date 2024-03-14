import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/assets_paths.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../core/dependency_injection/dependency_injection.dart' as di;
import '../../features/user/data_layer/model.dart';
import '../../features/user/presentaion_layer/controller.dart';
import 'components/contacts_view.dart';
import 'components/groups_view.dart';
import 'components/my_tab.dart';
import 'components/top_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.currentUser, super.key});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(di.sl<GroupController>());
    UserController userController = Get.put(di.sl<UserController>());

    userController.getUsersFromCantactsInfo(context);
    groupController.getAllGroupsFunction();

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AssetsPaths.background01,
              ),
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
