import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/core/widgets/custom_text_field.dart';
import 'package:my_cli_test/core/widgets/custom_title.dart';
import '../controllers/contacts_page_controller.dart';
import '../core/constants/app_strings.dart';
import '../core/models/user_model.dart';
import '../core/widgets/custom_text.dart';
import '../features/group/presentaion_layer/group_controller.dart';
import 'package:my_cli_test/core/dependency_injection/dependency_injection.dart'
    as di;

class ContactsPage extends StatelessWidget {
  const ContactsPage({required this.currentUserId, super.key});

  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    GroupController groupController = di.sl<GroupController>();
    ContactsPageController controller = Get.put(ContactsPageController());
    controller.getCurrentUserId(currentUserId);
    controller.getContacts();

    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomTitle(text: AppStrings.contacts),
            Row(
              children: [
                const CustomText(
                  text: AppStrings.createGroup,
                  isSamll: true,
                ),
                IconButton(
                  onPressed: () async {
                    //1. define dialog
                    AlertDialog dialog = AlertDialog(
                      title: const Text(AppStrings.createGroup),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(AppStrings.addName),
                          CustomTextField(
                            isEmail: false,
                            controller: controller.model.value.groupTec,
                            isPassword: false,
                          )
                        ],
                      ),
                      backgroundColor: Colors.green,
                      elevation: 20,
                      actions: [
                        TextButton(
                            onPressed: () {
                              groupController.renameGoup(context, 'nn');

                              //  controller.cancelGroup();
                            },
                            child: const CustomText(
                              text: AppStrings.cancel,
                              isSamll: true,
                            )),
                        TextButton(
                            onPressed: () {
                              //    controller.createGroup();
                              groupController.createGoup(
                                  adminId: currentUserId,
                                  context: context,
                                  groupName: 'my group');
                            },
                            child: const CustomText(
                                text: AppStrings.create, isSamll: true))
                      ],
                    );

                    //2. show dialog
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        )),
        body: Obx(() {
          List<UserModel>? users = controller.model.value.users;
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
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(users[index].name![0],
                            textAlign: TextAlign.center),
                      ),
                      title: Text(users[index].name!),
                      onTap: () async {
                        await controller.goToChatPage(users[index]);
                      },
                    ),
                  );
                },
              ),
            );
          }
        }));
  }
}
