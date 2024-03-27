import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/core/widgets/my_drawer/my_drawer.dart';
import '../../core/constants/assets_paths.dart';
import '../../core/models/user_model.dart';
import '../../features/group/data_layer/model.dart';
import '../../features/message/presentaion_layer/controller.dart';
import 'components/chat_appbar/chat_appbar.dart';
import 'components/chat_body.dart';
import 'components/lower_block.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(
      {required this.roomId,
      this.otherUser,
      this.groupModel,
      required this.currentUser,
      required this.isGroup,
      super.key});

  final String roomId;
  final UserModel? otherUser;
  final UserModel currentUser;
  final GroupModel? groupModel;
  final bool isGroup; // is it contact room or group room?

  @override
  Widget build(BuildContext context) {
    MessageController messageController = Get.find<MessageController>();

    messageController.getChatPageInfo(
      roomId: roomId,
      otherUser: otherUser,
      thisUserId: currentUser.id!,
    );

    messageController.getMessagesFunction(context: context, roomId: roomId);

    return Scaffold(
      endDrawer: MyDrawer(isGroup: isGroup),
      appBar: chatAppBar(
          context: context,
          isGroup: isGroup,
          groupModel: groupModel,
          otherUser: otherUser),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AssetsPaths.background), fit: BoxFit.fill)),
        child: Center(
          child: Column(
            children: [
              ChatBody(isGroup: isGroup),
              LowerBlock(
                roomId: roomId,
                recieverId: isGroup ? roomId : otherUser!.id!,
                currentUser: currentUser,
              )
            ],
          ),
        ),
      ),
    );
  }
}
