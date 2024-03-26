import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/assets_paths.dart';
import '../../../../core/models/user_model.dart';
import '../../../features/group/data_layer/model.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.user,
    this.group,
    required this.isGroup,
  });

  final UserModel? user;
  final GroupModel? group;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    String? imageUrl = isGroup ? group!.groupImage : user!.image;

    return Container(
      height: 60,
      width: 60,
      decoration:
          const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Center(
        child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: imageUrl == ''
                    ? DecorationImage(
                        image: AssetImage(
                          isGroup ? AssetsPaths.group : AssetsPaths.contact,
                        ),
                        fit: BoxFit.fill)
                    : DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl!),
                        fit: BoxFit.fill))),
      ),
    );
  }
}
