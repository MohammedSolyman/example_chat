import 'package:flutter/material.dart';
import '../../../../core/models/user_model.dart';
import 'create_group_tile.dart';
import 'my_header.dart';
import 'sign_out_tile.dart';
import 'update_image_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    required this.currentUser,
    super.key,
  });

  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: ListView(
        children: [
          MyHeader(currentUser: currentUser),
          UpdateImageTile(currentUser: currentUser),
          CreateGroupTile(currentUser: currentUser),
          const SignOutTile(),
        ],
      ),
    );
  }
}
