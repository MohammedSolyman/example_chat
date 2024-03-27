import 'package:flutter/material.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../features/group/data_layer/model.dart';
import '../../../home_page/components/profile_image.dart';

AppBar chatAppBar(
    {required BuildContext context,
    UserModel? otherUser,
    GroupModel? groupModel,
    required bool isGroup}) {
  String title = isGroup ? groupModel!.groupName : otherUser!.name!;
  String subtitle = isGroup ? groupModel!.groupDescription : otherUser!.email;

  return AppBar(
    toolbarHeight: 100,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ProfileImage(isGroup: isGroup, group: groupModel, user: otherUser),
            const SizedBox(width: 5),
            CustomTitle(text: title),
          ],
        ),
        CustomText(
          text: subtitle,
          isSamll: true,
        )
      ],
    ),
    actions: [
      Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Icon(Icons.settings, size: 40, color: Colors.white)))
    ],
  );
}
