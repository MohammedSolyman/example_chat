import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/assets_paths.dart';
import '../../core/models/user_model.dart';
import '../../core/widgets/custom_text.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../core/dependency_injection/dependency_injection.dart' as di;
import '../../features/user/presentaion_layer/controller.dart';
import 'components/contacts_view.dart';
import 'components/groups_view.dart';
import 'components/my_tab.dart';
import 'components/show_create_group_dialog.dart';
import 'components/top_row.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.currentUser, super.key});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    GroupController groupController = Get.put(di.sl<GroupController>());

    userController.getUsersGenerateCustomUsers(currentUserId: currentUser.id!);
    groupController.getAllGroupsFunction();

    //final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        endDrawer: MyDrawer(currentUser: currentUser),
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

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    required this.currentUser,
    super.key,
  });

  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: ListView(
        children: [
          const DrawerHeader(
              child: CircleAvatar(
            foregroundImage: AssetImage(
              AssetsPaths.chatIcon,
            ),
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
          const ListTile(
            leading: Icon(Icons.exit_to_app),
            title: CustomText(text: AppStrings.signOut),
          ),
        ],
      ),
    );
  }
}
