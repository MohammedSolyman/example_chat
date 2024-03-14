import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/custom_text.dart';
import '../../features/group/presentaion_layer/group_controller.dart';
import '../../core/dependency_injection/dependency_injection.dart' as di;
import '../../features/user/data_layer/model.dart';
import '../../features/user/presentaion_layer/controller.dart';
import 'components/create_group_row.dart';
import 'components/home_page_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.currentUser, super.key});

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    Get.put(di.sl<GroupController>());

    UserController userController = Get.put(di.sl<UserController>());
    userController.getUsersFromCantactsInfo(context);

    return Scaffold(
        appBar: AppBar(title: const CreateGroupRow()),
        body: Obx(() {
          List<UserModel>? users = userController.model.value.users;
          if (users == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (users.isEmpty) {
            return const Center(
              child: CustomText(text: AppStrings.noContacts),
            );
          } else {
            return Center(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return HomePageTile(user: users[index]);
                },
              ),
            );
          }
        }));
  }
}
