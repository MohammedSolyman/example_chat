import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/auth/presentaion_layer/controller.dart';
import '../../../../features/message/data_layer/model.dart';
import 'message_sub_tile.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({required this.message, required this.isGroup, super.key});

  final MessageModel message;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Obx(() {
      String msg = message.body;
      bool isMe =
          message.senderId == authController.model.value.currentUser!.id!;
      String timeString = message.getimeString();

      return MessageSubTile(
          isGroup: isGroup,
          senderName: message.senderName,
          isMe: isMe,
          msg: msg,
          time: timeString,
          messageType: message.messageType);
    });
  }
}
