import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/assets_paths.dart';
import '../../../features/group/presentaion_layer/group_controller.dart';
import '../../core/models/user_model.dart';

class ChatImage extends StatelessWidget {
  const ChatImage({
    super.key,
    required this.isGroup,
    this.otherUser,
  });

  final bool isGroup;
  final UserModel? otherUser;

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.find<GroupController>();

    // return Obx(() {
    String imageUrl = isGroup
        ? groupController.model.value.currentGroup!.groupImage!
        : otherUser!.image!;

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
                          defaultImage,
                        ),
                        fit: BoxFit.fill)
                    : DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.fill))),
      ),
    );
    //});
  }
}








// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/constants/assets_paths.dart';
// import '../../../features/group/presentaion_layer/group_controller.dart';
// import '../../core/models/user_model.dart';

// class ChatImage extends StatelessWidget {
//   const ChatImage({
//     super.key,
//     required this.isGroup,
//     this.otherUser,
//   });

//   final bool isGroup;
//   final UserModel? otherUser;

//   @override
//   Widget build(BuildContext context) {
//     GroupController groupController = Get.find<GroupController>();

//     // return Obx(() {
//     // String imageUrl = isGroup
//     //     ? groupController.model.value.currentGroup!.groupImage!
//     //     : otherUser!.image!;

//     // String defaultImage = isGroup ? AssetsPaths.group : AssetsPaths.contact;
//     return Container(
//       height: 60,
//       width: 60,
//       decoration:
//           const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//       child: Center(
//         child: Container(
//             height: 55,
//             width: 55,
//             decoration:
//                 isGroup ? myGroupDecoration() : myUserDecoration(otherUser)),
//       ),
//     );
//     //});
//   }
// }

// BoxDecoration myGroupDecoration() {
//   GroupController groupController = Get.find<GroupController>();

//   if (groupController.model.value.currentGroup!.groupImage == '') {
//     return const BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//             image: AssetImage(AssetsPaths.group), fit: BoxFit.fill));
//   } else {
//     return BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//             image: AssetImage(
//                 groupController.model.value.currentGroup!.groupImage!),
//             fit: BoxFit.fill));
//   }
// }

// BoxDecoration myUserDecoration(UserModel? otherUser) {
//   if (otherUser!.image == '') {
//     return const BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//             image: AssetImage(AssetsPaths.contact), fit: BoxFit.fill));
//   } else {
//     return BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//             image: AssetImage(otherUser.image!), fit: BoxFit.fill));
//   }
// }
