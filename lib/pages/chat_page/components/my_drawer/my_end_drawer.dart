 
 
//  import '../../../../core/models/user_model.dart';
// import '../../../../core/widgets/custom_text.dart';
// import '../../../../features/file/data_layer/model.dart';
// import '../../../../features/file/presentaion_layer/controller.dart';
// import '../../../../features/group/data_layer/model.dart';
// import '../../../../features/group/presentaion_layer/group_controller.dart';
// import '../../../../features/user/presentaion_layer/controller.dart';
// import '../../../../core/widgets/my_drawer/my_header.dart';
// import '../../../../core/widgets/my_drawer/sign_out_tile.dart';
// import '../../../../core/widgets/my_drawer/update_image_tile.dart';

// // class MyChatDrawer extends StatelessWidget {
// //   const MyChatDrawer({
// //     required this.groupModel,
// //     super.key,
// //   });

// //   final GroupModel groupModel;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Drawer(
// //       backgroundColor: Theme.of(context).primaryColorLight,
// //       child: ListView(
// //         children: [
// //           MyHeader(currentUser: currentUser),
// //           UpdateGroupImageTile(groupModel: groupModel, isGroup: true),
// //           const SignOutTile(),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class UpdateGroupImageTile extends StatelessWidget {
// //   const UpdateGroupImageTile({
// //     super.key,
// //     this.currentUser,
// //     this.groupModel,
// //     required this.isGroup,
// //   });

// //   final UserModel? currentUser;
// //   final GroupModel? groupModel;
// //   final bool isGroup;

// //   @override
// //   Widget build(BuildContext context) {
// //     String id = isGroup ? groupModel!.groupId! : currentUser!.id!;

// //     FileController fileController = Get.find<FileController>();
// //     UserController userController = Get.find<UserController>();
// //     GroupController groupController = Get.find<GroupController>();

// //     return ListTile(
// //       leading: const Icon(Icons.person),
// //       title: const CustomText(text: AppStrings.updateProfileImage),
// //       onTap: () async {
// //         // open device directory to pick an image
// //         File? file = await fileController.pickFileFunction();

// //         if (file != null) {
// //           // if the user picked an image, prepare a file model
// //           FileModel fileModel = fileController.prepareProfileFile(
// //               file: file, id: id, isGroup: isGroup);

// //           // and upload this image to firebase storage
// //           String? imgUrl = await fileController.createFileFunction(fileModel);

// //           if (imgUrl != null) {
// //             // if uploading was successful, add image url in group info

// //             GroupModel newModel = groupModel!;
// //             newModel.groupImage = imgUrl;
// //             groupController.updateGoup(context: context, groupModel: newModel);

// //             //and close the drawer
// //             Scaffold.of(context).closeEndDrawer();
// //           }
// //         }
// //       },
// //     );
// //   }
// // }
