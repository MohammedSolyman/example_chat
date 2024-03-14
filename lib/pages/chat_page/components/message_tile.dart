import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/message/data_layer/model.dart';
import '../../../features/message/presentaion_layer/controller.dart';
import 'message_block.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({required this.message, super.key});

  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    MessageController messageController = Get.find<MessageController>();

    return Obx(() {
      String msg = message.body;
      bool isMe = message.senderId == messageController.model.value.thisUserId;
      String timeString = message.getimeString();

      return MessageBlock(
        isMe: isMe,
        msg: msg,
        time: timeString,
      );
    });
  }
}
