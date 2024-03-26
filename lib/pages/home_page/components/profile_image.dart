import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/assets_paths.dart';
import '../../../../core/models/user_model.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
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
                image: user.image == ''
                    ? DecorationImage(
                        image: AssetImage(
                          AssetsPaths.contact,
                        ),
                        fit: BoxFit.fill)
                    : DecorationImage(
                        image: CachedNetworkImageProvider(user.image!),
                        fit: BoxFit.fill))),
      ),
    );
  }
}
