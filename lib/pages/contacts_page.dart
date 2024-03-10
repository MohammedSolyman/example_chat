import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contacts_page_controller.dart';
import '../core/constants/app_strings.dart';
import '../core/models/user_model.dart';
import '../core/widgets/custom_text.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({required this.userId, super.key});

  final String userId;

  @override
  Widget build(BuildContext context) {
    ContactsPageController controller = Get.put(ContactsPageController());
    controller.getCurrentUserId(userId);
    controller.getContacts();

    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.contacts),
        ),
        body: Obx(() {
          List<UserModel> users = controller.model.value.users;

          if (users.isEmpty) {
            return const Center(
              child: CustomText(text: AppStrings.noContacts),
            );
          } else {
            return Center(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(users[index].name![0],
                            textAlign: TextAlign.center),
                      ),
                      title: Text(users[index].name!),
                    ),
                  );
                },
              ),
            );
          }
        }));
  }
}
