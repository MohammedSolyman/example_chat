import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/assets_paths.dart';
import '../../../features/auth/presentaion_layer/controller.dart';
import '../../../features/group/presentaion_layer/group_controller.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.isGroup,
  });

  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    GroupController groupController = Get.find<GroupController>();

    return Obx(() {
      String imageUrl = isGroup
          ? groupController.model.value.currentGroup!.groupImage!
          : authController.model.value.currentUser!.image!;

      String defaultImage = isGroup ? AssetsPaths.group : AssetsPaths.contact;
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
                            isGroup ? AssetsPaths.group : defaultImage,
                          ),
                          fit: BoxFit.fill)
                      : DecorationImage(
                          image: CachedNetworkImageProvider(imageUrl),
                          fit: BoxFit.fill))),
        ),
      );
    });
  }
}
