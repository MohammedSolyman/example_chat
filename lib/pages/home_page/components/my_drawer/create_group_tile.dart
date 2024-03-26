import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_text.dart';
import '../creating_group_dialog/show_create_group_dialog.dart';

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
