import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../../features/group/data_layer/model.dart';
import 'create_group_tile.dart';
import 'my_header.dart';
import 'sign_out_tile.dart';
import 'update_image_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    this.currentUser,
    super.key,
    this.groupModel,
    required this.isGroup,
  });

  final UserModel? currentUser;
  final GroupModel? groupModel;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    print('from MyDrawer:  isGroup: $isGroup ----------------------------');

    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: ListView(
        children: [
          MyHeader(
            currentUser: currentUser,
            groupModel: groupModel,
            isGroup: isGroup,
          ),
          UpdateImageTile(
              currentUser: currentUser,
              groupModel: groupModel,
              isGroup: isGroup),
          if (!isGroup) CreateGroupTile(currentUser: currentUser!),
          const SignOutTile(),
        ],
      ),
    );
  }
}
