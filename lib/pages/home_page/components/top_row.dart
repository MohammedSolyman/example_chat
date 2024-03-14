import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_title.dart';
import 'show_create_group_dialog.dart';

class TopRow extends StatelessWidget {
  const TopRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomTitle(text: AppStrings.homepage),
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
      ),
    );
  }
}
