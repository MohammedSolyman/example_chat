import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../../models/user_model.dart';
import '../custom_text.dart';
import '../../../pages/home_page/components/creating_group_dialog/show_create_group_dialog.dart';

class CreateGroupTile extends StatelessWidget {
  const CreateGroupTile({
    super.key,
    required this.currentUser,
  });

  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.people),
      title: const CustomText(text: AppStrings.createGroup),
      onTap: () async {
        //close the end drawer
        Scaffold.of(context).closeEndDrawer();

        // open (create group) dialog
        await showCreateGroupDialog(context: context, currentUser: currentUser);
      },
    );
  }
}
