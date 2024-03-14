import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/assets_paths.dart';
import '../../core/dependency_injection/dependency_injection.dart' as di;
import '../../features/group/data_layer/model.dart';
import '../../features/message/presentaion_layer/controller.dart';
import '../../features/user/data_layer/model.dart';
import 'components/chat_appbar.dart';
import 'components/chat_body.dart';
import 'components/lower_block.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(
      {required this.roomId,
      this.otherUser,
      this.groupModel,
      required this.thisUserId,
      required this.isGroup,
      super.key});

  final String roomId;
  final UserModel? otherUser;
  final GroupModel? groupModel;
  final String thisUserId;
  final bool isGroup; // is it contact room or group room?

  @override
  Widget build(BuildContext context) {
    MessageController messageController = Get.put(di.sl<MessageController>());

    messageController.getChatPageInfo(
      roomId: roomId,
      otherUser: otherUser,
      thisUserId: thisUserId,
    );

    String title = isGroup
        ? groupModel!.groupName
        : messageController.model.value.otherUser!.name!;
    String subtitle = isGroup
        ? groupModel!.groupDescription
        : messageController.model.value.otherUser!.email;

    messageController.getMessagesFunction(context: context, roomId: roomId);

    return Scaffold(
      appBar: chatAppBar(title: title, subtitle: subtitle),
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
                  roomId: roomId, recieverId: isGroup ? roomId : otherUser!.id!)
            ],
          ),
        ),
      ),
    );
  }
}
