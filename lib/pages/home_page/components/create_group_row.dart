import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_title.dart';
import 'show_create_group_dialog.dart';

class AddGroupRow extends StatelessWidget {
  const AddGroupRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                await showCreateGroupDialog(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
