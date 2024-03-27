import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../custom_text.dart';
import '../../../features/group/data_layer/model.dart';
import '../../../pages/home_page/components/profile_image.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({
    super.key,
    this.currentUser,
    this.groupModel,
    required this.isGroup,
  });

  final UserModel? currentUser;
  final GroupModel? groupModel;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    String title = isGroup ? groupModel!.groupName : currentUser!.name!;
    String subTitle =
        isGroup ? groupModel!.groupDescription : currentUser!.email;

    return DrawerHeader(
        child: Column(
      children: [
        ProfileImage(isGroup: isGroup, user: currentUser, group: groupModel),
        CustomText(text: title),
        CustomText(text: subTitle),
      ],
    ));
  }
}
