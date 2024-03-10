import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/controllers/chat_page_controller.dart';
import 'package:my_cli_test/pages/chat_page/components/message_block.dart';

import '../../../core/models/message_model.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({required this.message, super.key});

  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    ChatPageController controller = Get.put(ChatPageController());

    return Obx(() {
      String msg = message.message;
      bool isMe = message.senderId == controller.model.value.thisUserId;
      String timeString = controller.numsToTimeString(message.time.toInt());

      return MessageBlock(
        isMe: isMe,
        msg: msg,
        time: timeString,
      );
    });
  }
}
