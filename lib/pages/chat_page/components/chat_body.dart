import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cli_test/pages/chat_page/components/message_tile.dart';
import 'package:my_cli_test/pages/chat_page/components/time_tile.dart';

import '../../../controllers/chat_page_controller.dart';
import '../../../core/models/message_model.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({super.key});

  @override
  Widget build(BuildContext context) {
    ChatPageController controller = Get.put(ChatPageController());
    String tempDate = '';

    return Obx(() {
      List<MessageModel> messages = controller.model.value.messages;

      return Expanded(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            List<Widget> widgetsList = [];

            String date =
                controller.numsToDateString(messages[index].time.toInt());

            if (index == 0) {
              tempDate = date;
              widgetsList.add(TimeTile(date: date));
            } else {
              if (tempDate != date) {
                tempDate = date;
                widgetsList.add(TimeTile(date: date));
              }
            }

            widgetsList.add(MessageTile(message: messages[index]));

            return Column(
              children: widgetsList,
            );
          },
        ),
      );
    });
  }
}
