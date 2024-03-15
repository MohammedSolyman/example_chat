import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../features/user/presentaion_layer/controller.dart';
import 'home_page_user_tile.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({required this.currentUserId, super.key});

  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    return Obx(() {
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
              if (users[index].id != currentUserId) {
                return HomePageUserTile(user: users[index]);
              } else {
                return Container();
              }
            },
          ),
        );
      }
    });
  }
}
