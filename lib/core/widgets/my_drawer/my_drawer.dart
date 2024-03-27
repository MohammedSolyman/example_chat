import 'package:flutter/material.dart';
import 'create_group_tile.dart';
import 'my_header.dart';
import 'sign_out_tile.dart';
import 'update_image_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
    required this.isGroup,
  });

  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorLight,
      child: ListView(
        children: [
          MyHeader(isGroup: isGroup),
          UpdateImageTile(isGroup: isGroup),
          if (!isGroup) const CreateGroupTile(),
          const SignOutTile(),
        ],
      ),
    );
  }
}
